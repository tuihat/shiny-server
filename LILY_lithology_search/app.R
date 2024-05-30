#LILY Lithology Search
#started: 1 December 2021
#updated: 27 May 2024
#Laurel Childress; childress@iodp.tamu.edu

###############################################################################
# A very basic way to search for lithologies in LILY.

# This application provides a mechanism to search for cores that contain specific
#...lithologies. It also allows the user to determine the lithology for a 
#...specific sample.
###############################################################################

#Packages
if(!require(DT)){ #check if the package is installed and sourced
  install.packages("DT") #if not, install the package
  library(DT) #and source the package 
}

if(!require(dplyr)){ #check if the package is installed and sourced
    install.packages("dplyr") #if not, install the package
    library(dplyr) #and source the package 
}

if(!require(shiny)){ #check if the package is installed and sourced
    install.packages("shiny") #if not, install the package
    library(shiny) #and source the package 
}

if(!require(shinyjs)){ #check if the package is installed and sourced
    install.packages("shinyjs") #if not, install the package
    library(shinyjs) #and source the package 
}

all_litho <- read.csv("CleanLITH.csv")
exp_choices <- c("320", "321", "323", "324", "318", "327", "329", "330", "334", "335", "336", "339", "340", "342", "344", "345", "341", "346", "349", "350", "351", "352", "353", "354", "355", "356", "359", "360", "361", "362", "363", "366", "367", "368", "371", "369", "372", "374", "375", "376", "368X", "379")
uni_prefix <- sort(unique(all_litho$Prefix), decreasing = FALSE)
uni_princ <- sort(unique(all_litho$Principal), decreasing = FALSE)
uni_suffix <- sort(unique(all_litho$Suffix), decreasing = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(navbarPage("LILY Database - Lithology Tool",
           tabPanel("Search by lithology",
                    tags$head(tags$style(HTML("
                 .multicol { 
                   height: 400px;
                   -webkit-column-count: 3; /* Chrome, Safari, Opera */ 
                   -moz-column-count: 3;    /* Firefox */ 
                   column-count: 3; 
                   -moz-column-fill: auto;
                   -column-fill: auto;
                 } 
                 "))),
                  titlePanel("Select Expeditions"),
                  sidebarLayout(
                      sidebarPanel(actionButton("selectall", label="Select/Deselect All"),
                                   hr(),
                                   tags$div(align = 'left', 
                                            class = 'multicol',
                          checkboxGroupInput(inputId = "exps", label = NULL, 
                                             choices =  exp_choices, selected = exp_choices)),
                          width = 3),
                      mainPanel(br(),
                        h4("Enter search terms:"),
                        h5("Type lithologies into the text fields. Searches are independent (a full lithology is not required to contain all terms), and each text field can support multiple search terms."),
                        br(),
                        fluidRow(
                          # column(width = 2, checkboxInput(inputId = "prefix_check", label = "Prefix", value = TRUE)),
                          column(width = 12, selectizeInput("prefix_in", label = "Prefix",
                                                            choices = paste0(uni_prefix), multiple = TRUE))
                        ),
                        fluidRow(
                          # column(width = 2, checkboxInput(inputId = "princ_check", label = "Principal", value = TRUE)),
                          column(width = 12, selectizeInput("princ_in", label = "Principal",
                                                            choices = paste0(uni_princ), multiple = TRUE))
                        ),
                        fluidRow(
                          # column(width = 2, checkboxInput(inputId = "suffix_check", label = "Suffix", value = TRUE)),
                          column(width = 12, selectizeInput("suffix_in", label = "Suffix",
                                                            choices = paste0(uni_suffix), multiple = TRUE))
                        ),
                        br(),
                        actionButton("goButton1", "Search"),
                        fluidRow(
                          column(width = 11),
                          column(width = 1, downloadButton("downloadresult1", "Download Results"))
                        ),
                        hr(),
                        DT::dataTableOutput("concat_df", width = 1400)
                                )
                    ),
                  ########################################################################
                  br(),
                  hr(style = "border-top: 1px solid #000000;"), #horizontal line
                  tags$i("These are not official IODP-JRSO applications and functionality is 
         not guaranteed. User assumes all risk."), #italic disclaimer
                  
                  tags$i("Questions, comments, concerns, compliments: shinylaurelwebmaster@gmail.com")),
           tabPanel("Search by sample",
                    titlePanel("Sample Lithology Identifier"),
                    h5("This app will return the lithology of a specific IODP Sample ID."),
                    h5("To use this app: Enter an expedition, site, hole, core, section, and offset (cm) value."),
                    hr(),
                    sidebarLayout(
                      sidebarPanel(
                        selectInput('var11', 'Expedition', 
                                    choices = exp_choices),
                        selectInput('var22', 'Select Site', 'placeholder11'),
                        selectInput('var33', 'Select Hole', 'placeholder22'),
                        selectInput('var44', 'Select Core', 'placeholder33'),
                        selectInput('var55', 'Select Section', 'placeholder44'),
                        numericInput("offset1", "Offset (cm):", value = 1)),
                        # selectInput("exp", "Select Expedition:",
                        #             c(exp_choices), selected = "376"),
                        # textInput("site", "Site", value = "U1530"),
                        # textInput("hole", "Hole", value = "A"),
                        # numericInput("core", "Core", value = 60),
                        # textInput("section", "Section", value = "1"),
                        # numericInput("offset", "Offset (cm)", value = 116),
                        # width = 3),
                      mainPanel(
                        h2("Your sample is:"),
                        textOutput("lithoMatchResult"),
                        tags$head(tags$style(HTML("#lithoMatchResult {font-size: 30px;}")))
                      )))
           ))

# Define server logic required to draw a histogram
server <- function(input, output, session) {
################# LITHOLOGY SEARCH #############################################     
  reportResults <- eventReactive(input$goButton1, {
    filter_exp <- all_litho[all_litho$Exp %in% input$"exps", ]
    filter_prefix <- filter_exp[filter_exp$Prefix %in% input$"prefix_in" | 
                                  filter_exp$Principal %in% input$"princ_in" | 
                                  filter_exp$Suffix %in% input$"suffix_in", ]
  })
################# #select all button
  observe({
    if (input$selectall > 0) {
      if (input$selectall %% 2 == 0){
        updateCheckboxGroupInput(session=session, inputId="exps",
                                 choices = exp_choices,
                                 selected = exp_choices)
      }
      else {
        updateCheckboxGroupInput(session=session, inputId="exps",
                                 choices = exp_choices,
                                 selected = c())
      }}
  })
################# #make the table
  output$concat_df <- DT::renderDataTable({
    pretty_table <- reportResults()
    pretty_table <- pretty_table[,c(18,1:17,19:26)]
    pretty_table <- pretty_table[order(factor(pretty_table$Exp, levels=exp_choices), pretty_table$Site, pretty_table$Hole),]
    round(pretty_table$Latitude..DD., digits = 4)
    round(pretty_table$Longitude..DD., digits = 4)
    names(pretty_table)[1] <- "Full Lithology"
    names(pretty_table)[7] <- "Section"
    names(pretty_table)[8] <- "A/W"
    names(pretty_table)[12] <- "Top offset (cm)"
    names(pretty_table)[13] <- "Bottom offset (cm)"
    names(pretty_table)[14] <- "Top depth (CSF-A m)"
    names(pretty_table)[15] <- "Bottom depth (CSF-A m)"
    names(pretty_table)[19] <- "Simplified Lithology"
    names(pretty_table)[20] <- "Lithology Type"
    names(pretty_table)[21] <- "Degree of Consolidation"
    names(pretty_table)[22] <- "Lithology Subtype"
    names(pretty_table)[23] <- "Expanded Core Type"
    names(pretty_table)[24] <- "Latitude (DD)"
    names(pretty_table)[25] <- "Longitude (DD)"
    names(pretty_table)[26] <- "Water depth (mbsl)"
    DT::datatable(pretty_table, options = list(pageLength = 10, scrollX = TRUE), rownames= FALSE)%>% 
      formatRound(columns = c(24:25), digits = 4)
  })
################# #make the table nice for download
  nice_download <- reactive({
    pretty_table <- reportResults()
    pretty_table <- pretty_table[,c(18,1:17,19:26)]
    pretty_table <- pretty_table[order(factor(pretty_table$Exp, levels=exp_choices), pretty_table$Site, pretty_table$Hole),]
    round(pretty_table$Latitude..DD., digits = 4)
    round(pretty_table$Longitude..DD., digits = 4)
    names(pretty_table)[1] <- "Full Lithology"
    names(pretty_table)[7] <- "Section"
    names(pretty_table)[8] <- "A/W"
    names(pretty_table)[12] <- "Top offset (cm)"
    names(pretty_table)[13] <- "Bottom offset (cm)"
    names(pretty_table)[14] <- "Top depth (CSF-A m)"
    names(pretty_table)[15] <- "Bottom depth (CSF-A m)"
    names(pretty_table)[19] <- "Simplified Lithology"
    names(pretty_table)[20] <- "Lithology Type"
    names(pretty_table)[21] <- "Degree of Consolidation"
    names(pretty_table)[22] <- "Lithology Subtype"
    names(pretty_table)[23] <- "Expanded Core Type"
    names(pretty_table)[24] <- "Latitude (DD)"
    names(pretty_table)[25] <- "Longitude (DD)"
    names(pretty_table)[26] <- "Water depth (mbsl)"
    final_version <- pretty_table
  })
  
################# #download the table
  output$downloadresult1 <- downloadHandler(
    filename = function() {
      paste("LILY_search", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(nice_download(), file, row.names = FALSE)
    })
##########################################
################# SEARCH BY SAMPLE ###############################################
##########################################
  toListen <- reactive({
    list(input$var11, input$var22, input$var33)
  })
  
  toListen2 <- reactive({
    list(input$var11, input$var22, input$var33, input$var44)
  })
  
  observe({ #use Exp to limit Site choices
    updateSelectInput(session, "var22", choices = with(all_litho, Site[Exp == input$var11]))
    reset("offset1")
  })
  
  observeEvent(input$var22, { #use Site to limit Hole choices
    column_levels <- with(all_litho, Hole[Site == input$var22])
    updateSelectInput(session, "var33", choices = column_levels)
    reset("offset1")
  })
  
  observeEvent(toListen(), { #use Site and Hole to limit Core choices
    column_levels <- with(all_litho, Core[Site == input$var22 & Hole == input$var33])
    updateSelectInput(session, "var44", choices = column_levels)
    reset("offset1")
  })
  
  observeEvent(toListen2(), { #use Site and Hole and Core to limit section choices
    column_levels <- with(all_litho, Sect[Site == input$var22 & Hole == input$var33 & Core == input$var44])
    updateSelectInput(session, "var55", choices = column_levels)
    reset("offset1")
  })
  
   output$lithoMatchResult <- reactive({
       match1 <- subset(all_litho, Exp == input$var11)
       match1 <- subset(match1, Site == input$var22)
       match1 <- subset(match1, Hole == input$var33)
       match1 <- subset(match1, Core == input$var44)
       match1 <- subset(match1, Sect == input$var55)
       tmp <- match1 %>%
           filter(Top.offset..cm. <= input$offset1, input$offset1 < Bottom.offset..cm.)
       value <- tmp$Full.Lithology
       if(length(value) < 1){
           oops <- paste0("not described within DESClogik. Please see the expedition Proceedings Volume for more information.")
       } else {
           value <- value
       }
   })
    

}    
# Run the application 
shinyApp(ui = ui, server = server)
