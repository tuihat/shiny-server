library(dplyr)
if(!require(DT)){ #check if the package is installed and sourced
  install.packages("DT") #if not, install the package
  library(DT) #and source the package 
}
library(shiny)
library(rhandsontable)
library(shinydashboard)
library(shinydashboardPlus)

table_template <- read.csv("table_template.csv", colClasses = c("character", "integer", "factor"))
volumes <- read.csv("sample_volume.csv")

ui <- dashboardPage(
  header = dashboardHeader(title = "Easy Sample Volume Calculations"),
  sidebar = dashboardSidebar(width = "0px"),
  body = dashboardBody(
    fluidRow(
      column(width = 4,
             h2("Paste your data in here."),
             h3("Examples are given in the first three columns. Non-integer values provided
       for sample length will be truncated to integers."),
             wellPanel(
      rHandsontableOutput("table"))
    ),
    column(width = 1),
    column(width = 6,
           h2("Results are over here."),
           h3("SED applies to APC and XCB material (F, H, X). RCB applies to RCB
              material (R)."), br(),
           DT::dataTableOutput("resultstable"),
           downloadButton("download1.1", "Download results")),
    column(width = 1)),
    br(),
    tags$i("These are not official IODP-JRSO applications and functionality is 
           not guaranteed. User assumes all risk."), #italic disclaimer
    tags$head(tags$style(HTML('
        /* logo */
        .skin-blue .main-header .logo {
                              background-color: #f4b943;width: 400px;
                              }

        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
                              background-color: #f4b943;
                              }

        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color: #f4b943;margin-left: 400px;
                              }
        /* main sidebar */
        .skin-blue .main-sidebar {
                              background-color: #325669;
                              }
         .box-header{ display: none}
                           '))),
    tags$script("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';")
  )
)

server <- function(input, output, session) {
  
  df <- table_template
  
  datavalues<-reactiveValues(data=df)
  
  output$table <- renderRHandsontable({
    
    mytab <- rhandsontable(datavalues$data, 
                           colHeaders = c("Sample ID", "Sample Length (cm)", "Tool"), 
                           stretchH = "all")
    return(mytab)
  })
  
  do_data_stuff <- reactive({
    tmp_df <- hot_to_r(input$table)
    tmp_list <- list()
    for(i in 1:nrow(tmp_df)){
      df_row <- tmp_df[i,]
      tmp_vols <- subset(volumes, length_cm == as.integer(df_row$Sample.length..cm.))
      tmp_vols2 <- tmp_vols[grepl(df_row$Tool, names(tmp_vols))]
      df_row$SED_cc <- as.character(tmp_vols2[1,1])
      df_row$RCB_cc <- as.character(tmp_vols2[1,2])
      tmp_list[[i]] <- df_row
    }
    new_df <- do.call("rbind", tmp_list)
    new_df
  })
  
  output$resultstable <- DT::renderDataTable({
    pretty_table <- do_data_stuff()
    names(pretty_table)[1] <- "Sample ID"
    names(pretty_table)[2] <- "Sample Length (cm)"
    names(pretty_table)[3] <- "Tool"
    names(pretty_table)[4] <- "SED volume (cc)"
    names(pretty_table)[5] <- "RCB volume (cc)"
    DT::datatable(pretty_table, options = list(pageLength = 20, scrollX = TRUE,
                                               columnDefs = list(list(className = 'dt-center', targets = "_all"))), 
                                                rownames= FALSE) %>% 
      formatRound(columns = c(4:5), digits = 1)
  })
  
  #################################################
  output$download1.1 <- downloadHandler( # Downloadable csv (single file) ----
                         filename = function() {
                           paste("volume_results", ".csv", sep = "")
                         },
                         content = function(file) {
                           write.csv(do_data_stuff(), file, row.names = FALSE)
                         })

   
}

shinyApp(ui = ui, server = server)