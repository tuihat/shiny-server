#JOIDES Resolution Drilling Stats - now with Glomar Challenger
#started: 21 October 2022
#updated: 7 December 2023
#Laurel Childress; childress@iodp.tamu.edu

###############################################################################
# A very basic table and summary of standard JR drilling statistics.

#This application provides a visualization of some JOIDES
#...Resolution drilling statistics and offers several filters for parameters
#...such as core recovery and water depth. The entire
#...database or the selected expeditions can be downloaded. Glomar Challenger
#...statistics are available as well but should be used with caution.
###############################################################################

#Packages
if(!require(rmarkdown)){ #check if the package is installed and sourced
  install.packages("rmarkdown") #if not, install the package
  library(rmarkdown) #and source the package 
}

if(!require(ggplot2)){ #check if the package is installed and sourced
  install.packages("ggplot2") #if not, install the package
  library(ggplot2) #and source the package 
}

if(!require(tidyr)){ #check if the package is installed and sourced
  install.packages("tidyr") #if not, install the package
  library(tidyr) #and source the package 
}

if(!require(DT)){ #check if the package is installed and sourced
  install.packages("DT") #if not, install the package
  library(DT) #and source the package 
}

if(!require(shiny)){ #check if the package is installed and sourced
  install.packages("shiny") #if not, install the package
  library(shiny) #and source the package
}

if(!require(shinyjs)){ #check if the package is installed and sourced
  install.packages("shinyjs") #if not, install the package
  library(shinyjs) #and source the package
}

if(!require(shinyWidgets)){ #check if the package is installed and sourced
  install.packages("shinyWidgets") #if not, install the package
  library(shinyWidgets) #and source the package
}

if(!require(shinydashboard)){ #check if the package is installed and sourced
  install.packages("shinydashboard") #if not, install the package
  library(shinydashboard) #and source the package
}

if(!require(shinydashboardPlus)){ #check if the package is installed and sourced
  install.packages("shinydashboardPlus") #if not, install the package
  library(shinydashboardPlus) #and source the package
}

import_stats <- read.csv("GLOMAR_JOIDES_ship_drilling_stats.csv") #import data
#######EXP LIST ORDERFOR USE BELOW#############################################
JR_exp <- c("100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "124E", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169S", "169", "170", "171A", "171B", "172", "173", "174A", "174B", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "301", "301T", "303", "304", "305", "306", "307", "308", "309", "311", "312", "320T", "320", "321", "321T", "323", "324", "317", "318", "318T", "327", "328", "328T", "329", "330", "330T", "334", "335", "335T", "336", "339", "340T", "340", "342T", "342", "344T", "344", "345", "341T", "341S", "341", "346", "346T", "349P", "349T", "349", "350", "351", "352", "353P/T", "353", "354", "355", "355T", "356T", "356P", "356", "359", "360", "361", "361P", "362T",
"362", "363", "366", "367", "368", "368P/371T", "371", "369", "372", "374", "375", "376", "376T/378P/T", "368X", "368T", "379", "382", "383", "379T", "385T", "385", "378T", "378", "378S", "387P/T", "384P/T/A", "384", "390P", "390C", "390R", "395P", "395E", "395C", "396", "396T", "391", "392", "390","393","397P",
"397T","397","398","398P", "399", "395", "400")

all_exp <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "11C", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23",
"24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "44A", "45", "46", "47",
"48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68 - Site 501", "68", "69",
"70", "71", "72", "73", "74", "75", "76", "77", "78A", "78B", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", 
"93", "94", "95", "96", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118",
"119", "120", "121", "122", "123", "124", "124E", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139",
"140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161",
"162", "163", "164", "165", "166", "167", "168", "169S", "169", "170", "171A", "171B", "172", "173", "174A", "174B", "175", "176", "177", "178", "179",
"180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", 
"201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "301", "301T", "303", "304", "305", "306", "307", "308", "309", "311", "312", "320T", "320", "321", "321T", "323", "324", "317", "318", "318T", "327", "328", "328T", "329", "330", "330T", "334", "335", "335T", "336", "339", "340T", "340", "342T", "342", "344T", "344", "345", "341T", "341S", "341", "346", "346T", "349P", "349T", "349", "350", "351", "352", "353P/T", "353", "354", "355", "355T", "356T", "356P", "356", "359", "360", "361", "361P", "362T", "362", "363", "366", "367", "368", "368P/371T", "371", "369", "372", "374", "375", "376", "376T/378P/T", "368X", "368T", "379", "382", "383", "379T", "385T", "385", "378T", "378", "378S", "387P/T", "384P/T/A", "384", "390P", "390C", "390R", "395P", "395E", "395C", "396", "396T", "391", "392", "390","393","397P","397T","397","398","398P", "399", "395", "400")

#nicer if the more recent ones are at the top
JR_exp <- rev(JR_exp)
all_exp <- rev(all_exp)

ui <- dashboardPage(
  title = "JOIDES Resolution Drilling Statistics", #website title
  header = dashboardHeader(title = "JOIDES Resolution Drilling Statistics"),
  sidebar = dashboardSidebar(width = "0px"),
  body = dashboardBody(
    fluidRow(
             box(width = 2,
                 pickerInput('inputmain', 'Expedition:', 
                             choices = JR_exp,
                             selected = JR_exp,
                             options = pickerOptions(`actions-box` = TRUE, dropupAuto = FALSE),
                             multiple = T)
             ),
             box(width = 3,
                 column(width = 6, numericInput('input1', 'Core Recovery Minimum:', 0)),
                 column(width = 6, numericInput("input2", "Core Recovery Maximum:", max(import_stats$Core.recovered..m., na.rm = TRUE)))
             ),
             box(width = 3,
                 column(width = 6, numericInput('input3', 'Water Depth Minimum:', 0)),
                 column(width = 6, numericInput("input4", "Water Depth Maximum:", max(import_stats$Maximum.water.depth..m., na.rm = TRUE)))
             ),
             box(width = 3,
                 column(width = 6, numericInput('input5', 'Penetration Minimum:', 0)),
                 column(width = 6, numericInput("input6", "Penetration Maximum:", max(import_stats$Total.penetration..m., na.rm = TRUE)))
             ),
             column(width = 1,
                 h1(" "),
                 actionBttn(inputId = "reset_all", label = "Reset", style = "bordered", color = "success", icon = icon("cog")
                 )
             )
    ),
    fluidRow(
      column(width = 4,
          plotOutput("plot_TotalCoredist", height = 600)),
      column(width = 4,
          plotOutput("plot_PortTransitSite", height = 600)
      ),
      box(width = 4, 
          br(),
          textOutput("exp_output"),
          tags$head(tags$style(HTML("#exp_output {font-size: 25px;}"))),
          br(),br(),
          textOutput("sites_output"),
          tags$head(tags$style(HTML("#sites_output {font-size: 25px;}"))),
          br(),br(),
          textOutput("holes_output"),
          tags$head(tags$style(HTML("#holes_output {font-size: 25px;}"))),
          br(),br(),
          textOutput("cores_output"),
          tags$head(tags$style(HTML("#cores_output {font-size: 25px;}"))),
          br(),br(),
          textOutput("dist_output"),
          tags$head(tags$style(HTML("#dist_output {font-size: 25px;}"))),
          br(),br(),
          textOutput("recov_output"),
          tags$head(tags$style(HTML("#recov_output {font-size: 25px;}"))),
          br(),br(),
          textOutput("speed_output"),
          tags$head(tags$style(HTML("#speed_output {font-size: 25px;}"))),
          br(),
          h6("*Includes transits/tie ups, some with operations."),
          h6("Coring = coring/drilling/tripping pipe; Logging = logging/downhole tools; Lost = weather/repairs.")
      )
    ), br(),
    fluidRow( #user must comply with template use
      column(width = 1,
             downloadButton("downloadall", "Download all data", style='padding:4px; font-size:80%')),
      column(width = 1,
             downloadButton("downloadsome", "Download selected data", style='padding:4px; font-size:80%')),
      column(width = 1,
             textOutput("     ")),
      column(width = 3,
             switchInput(inputId = "GLOMAR", value = FALSE, label = "Glomar Challenger"))),
    br(),
      fluidRow(
        box(width = 12,
          DT::dataTableOutput("SiteHoleTable"))),
    br(),
    br(),
    "JR Data derived from: ",
    tags$a(href="https://iodp.tamu.edu/publicinfo/ship_stats.html", 
           "JOIDES Resolution Coring Statistics",
           target="_blank"), #app link
    br(),
    "Glomar Challenger data derived primarily from DSDP Technical Reports: ",
    tags$a(href="http://deepseadrilling.org/t_reports.htm", 
           "DSDP Technical Reports",
           target="_blank"), #app link
    br(),
    tags$i("DSDP Technical Reports and LIMS may differ as core recovered during
           drill-down/wash/etc. was not categorized under current standards.
           DSDP aged information should be approached with caution under the 
           best circumstances; discrepencies between LIMS, Initial Report Volumes,
           and the Technical Reports is common."), #italic disclaimer
    br(),
    tags$i("These are not official IODP-JRSO applications and functionality is 
           not guaranteed. User assumes all risk."), #italic disclaimer
    br(),
    tags$i("Questions, comments, concerns, compliments: shinylaurelwebmaster@gmail.com"),
    br(),
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
    tags$head(includeHTML(("google_analytics.html"))),
    tags$script("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';")
  )
)

server <- function(input, output, session) {
#########---Reactive Searched Dataframe---######################################
  
  observeEvent(input$reset_all, {
    updatePickerInput(session, "inputmain", choices = JR_exp, selected = JR_exp)
    updateNumericInput(session, "input1", value = 0)
    updateNumericInput(session, "input2", value = max(import_stats$Core.recovered..m., na.rm = TRUE))
    updateNumericInput(session, "input3", value = 0)
    updateNumericInput(session, "input4", value = max(import_stats$Maximum.water.depth..m., na.rm = TRUE))
    updateNumericInput(session, "input5", value = 0)
    updateNumericInput(session, "input6", value = max(import_stats$Total.penetration..m., na.rm = TRUE))
    updateSwitchInput(session, "GLOMAR", value = FALSE)
  })
  
  chosen_boat <- reactive({
    if(input$GLOMAR == "FALSE"){
      subset(import_stats, Vessel == "JOIDES Resolution")
    }else{
      new_df <- import_stats
    }
  })
  
  observeEvent(input$GLOMAR, {
    if(input$GLOMAR == "FALSE"){
      updatePickerInput(session, "inputmain", choices = JR_exp, selected = JR_exp)
    }else{
      updatePickerInput(session, "inputmain", choices = all_exp, selected = all_exp)
    }
  })
  
  chosen_progs <- reactive({
    prog_range <- subset(chosen_boat(), Expedition_Leg %in% input$inputmain) #narrow down to expeditions
    recov_range <- subset(prog_range, Core.recovered..m. <= input$input2 & Core.recovered..m. >= input$input1 | is.na(Core.recovered..m.))
    water_range <- subset(recov_range, Maximum.water.depth..m. <= input$input4 & Maximum.water.depth..m. >= input$input3 | is.na(Maximum.water.depth..m.)) #narrow down to water depths
    pen_range <- subset(water_range, Total.penetration..m. <= input$input6 & Total.penetration..m. >= input$input5 | is.na(Total.penetration..m.)) #narrow down to penetrations
    pen_range <- pen_range[,-1]
    pen_range
  })
  #####---Prep values for pie chart days coring##############
  core_pie <- reactive({
    hm <- as.data.frame(t(colSums(chosen_progs()[,c(14:15,19)], na.rm = TRUE)))
    hm2 <- gather(hm)
    hm2[,1] <- c("Coring", "Logging", "Lost")
    hm2 <- subset(hm2, value > 0)
    hm2$pct <- hm2$value/(sum(hm2$value))*100
    hm2$pct <- round(hm2$pct, digits = 0)
    hm2$ymax <- cumsum(hm2$pct) # Compute the cumulative percentages (top of each rectangle)
    hm2$ymin <- c(0, head(hm2$ymax, n=-1)) # Compute the bottom of each rectangle
    hm2$labelPosition <- (hm2$ymax + hm2$ymin) / 2 # Compute label position
    hm2$value <- round(hm2$value, digits = 0)
    hm2$label <- paste0(hm2$key, "\n", hm2$value, " days") # Compute a good label
    hm2
  })
  
  #####---Prep values for pie chart days port/transit##############
  port_pie <- reactive({
    hm <- as.data.frame(t(colSums(chosen_progs()[,c(10:12)], na.rm = TRUE)))
    hm2 <- gather(hm)
    hm2[,1] <- c("Port", "Transit", "Site")
    hm2 <- subset(hm2, value > 0)
    hm2$pct <- hm2$value/(sum(hm2$value))*100
    hm2$pct <- round(hm2$pct, digits = 0)
    hm2$ymax <- cumsum(hm2$pct) # Compute the cumulative percentages (top of each rectangle)
    hm2$ymin <- c(0, head(hm2$ymax, n=-1)) # Compute the bottom of each rectangle
    hm2$labelPosition <- (hm2$ymax + hm2$ymin) / 2 # Compute label position
    hm2$value <- round(hm2$value, digits = 0)
    hm2$label <- paste0(hm2$key, "\n", hm2$value, " days") # Compute a good label
    hm2
  })
  
#########---Output Table---#####################################################  
  output$SiteHoleTable <- DT::renderDataTable({
    pretty_table <- chosen_progs()
    names(pretty_table)[1] <- "Expedition or Leg"
    names(pretty_table)[2] <- "Science program"
    names(pretty_table)[3] <- "Start date"
    names(pretty_table)[4] <- "Start port city"
    names(pretty_table)[5] <- "Start port"
    names(pretty_table)[6] <- "End date"
    names(pretty_table)[7] <- "End port city"
    names(pretty_table)[8] <- "End port"
    names(pretty_table)[9] <- "Total days"
    names(pretty_table)[10] <- "In port days"
    names(pretty_table)[11] <- "In transit days"
    names(pretty_table)[12] <- "On site days"
    names(pretty_table)[13] <- "Off site days"
    names(pretty_table)[14] <- "Coring/drilling/tripping days"
    names(pretty_table)[15] <- "Logging/downhole tools days"
    names(pretty_table)[16] <- "Reentry/casing/cementing days"
    names(pretty_table)[17] <- "Remedial action days"
    names(pretty_table)[18] <- "Engineering completion (CORK) days"
    names(pretty_table)[19] <- "Lost time (weather, repairs) days"
    names(pretty_table)[20] <- "Other days"
    names(pretty_table)[21] <- "Sites"
    names(pretty_table)[22] <- "Holes"
    names(pretty_table)[23] <- "Cores"
    names(pretty_table)[24] <- "Distance traveled (nmi)"
    names(pretty_table)[25] <- "Average transit speed (kn)"
    names(pretty_table)[26] <- "Total penetration (m)"
    names(pretty_table)[27] <- "Interval drilled (m)"
    names(pretty_table)[28] <- "Interval cored (m)"
    names(pretty_table)[29] <- "Core recovered (m)"
    names(pretty_table)[30] <- "Recovery (%)"
    names(pretty_table)[31] <- "Maximum water depth (m)"
    names(pretty_table)[32] <- "Minimum water depth (m)"
    names(pretty_table)[33] <- "Seafloor camera deployments"
    names(pretty_table)[34] <- "Reentries"
    DT::datatable(pretty_table, options = list(pageLength = 20, scrollX = TRUE,
                                               columnDefs = 
                                                 list(list(className = 'dt-center', 
                                                           targets = "_all"))),
                  rownames= FALSE)
  })
#########---Output Graphs---#####################################################   
  # ###################################
  output$plot_TotalCoredist <- renderPlot({
    validate(
      need(nrow(chosen_progs()) > 0, "No data for this selection.")
    )
    ggplot(core_pie(), aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=key)) +
      geom_rect() +
      geom_text(x=3.5, aes(y=labelPosition, label=label), size=5) +
      scale_fill_brewer(palette=1) +
      coord_polar(theta="y") +
      xlim(c(2, 4)) +
      theme_void() +
      theme(legend.position = "none",
            plot.title = element_text(size=22, vjust = -10)) +
      labs(title = "Days spent:")
  })
  # }, height = 600, width = 600)
  # ###################################
  output$plot_PortTransitSite <- renderPlot({
    validate(
      need(nrow(chosen_progs()) > 0, "No data for this selection.")
    )
    ggplot(port_pie(), aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=key)) +
      geom_rect() +
      geom_text(x=3.5, aes(y=labelPosition, label=label), size=5) +
      scale_fill_brewer(palette=2) +
      coord_polar(theta="y") +
      xlim(c(2, 4)) +
      theme_void() +
      theme(legend.position = "none",
            plot.title = element_text(size=22, vjust = -10)) +
      labs(title = "Days spent:")
  })
  ###################################
#########---Output Textss---####################################################  
  output$exp_output <- renderText({
    tmp2 <- chosen_progs()
    paste0("Expeditions*: ", nrow(tmp2))
  }) 
  
  output$sites_output <- renderText({
    tmp2 <- chosen_progs()
    paste0("Sites: ", sum(tmp2$Sites, na.rm = TRUE))
  }) 
  
  output$holes_output <- renderText({
    tmp2 <- chosen_progs()
    paste0("Holes: ", sum(tmp2$Holes, na.rm = TRUE))
  })
  
  output$cores_output <- renderText({
    tmp2 <- chosen_progs()
    paste0("Cores: ", sum(tmp2$Cores, na.rm = TRUE))
  })
  
  output$dist_output <- renderText({
    tmp2 <- chosen_progs()
    paste0("Distance traveled (nmi): ", sum(tmp2$Distance.traveled..nmi., na.rm = TRUE))
  })
  
  output$recov_output <- renderText({
    tmp2 <- chosen_progs()
    paste0("Core recovered (m): ", sum(tmp2$Core.recovered..m., na.rm = TRUE))
  })
  
  output$speed_output <- renderText({
    tmp2 <- chosen_progs()
    paste0("Average transit speed (kts): ", round(mean(tmp2$Average.transit.speed..kn., na.rm = TRUE), digits = 1))
  })
  
  ###################################
#########---Download tables#####################################################
  output$downloadall <- downloadHandler(
    filename <- function() {
      paste("GLOMAR_JOIDES_ship_drilling_stats", "csv", sep=".")
    },
    
    content <- function(file) {
      file.copy("GLOMAR_JOIDES_ship_drilling_stats.csv", file)
    })
  
  # Downloadable csv of selected Exps ----
  output$downloadsome <- downloadHandler(
    filename = function() {
      paste("selected_JOIDES_stats", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(chosen_progs(), file, row.names = FALSE)
    })
}

shinyApp(ui = ui, server = server)