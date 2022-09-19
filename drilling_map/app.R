#DSDP, ODP, IODP Expedition Map
#started: 1 December 2021
#updated: 19 September 2022
#Laurel Childress; childress@iodp.tamu.edu

###############################################################################
# A very basic map leaflet of expedition holes.
###############################################################################

#Packages
if(!require(rmarkdown)){
  install.packages("rmarkdown")
  library(rmarkdown) #rmarkdown
}

if(!require(ggplot2)){
  install.packages("ggplot2")
  library(ggplot2) #ggplot2
}

if(!require(tidyr)){
  install.packages("tidyr")
  library(tidyr) #tidyr
}

if(!require(leaflet)){ #check if the package is installed and sourced
  install.packages("leaflet") #if not, install the package
  library(leaflet) #and source the package 
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

exp_coords <- read.csv("DSDP_ODP_IODP_coords_LIMS.csv")
exp_coords$program <- factor(exp_coords$program,
                                levels = c("DSDP", "ODP", "IODP"),
                                ordered = TRUE)
#######EXP LIST ORDERFOR USE BELOW#############################################
all_exp <- c("1","2","3","4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "301", "302", "303", "304", "305", "306", "307", "308", "309", "310", "311", "312", "320T", "320", "321", "323", "324", "317", "318", "327", "328", "329", "330", "334", "335", "336", "339", "340T", "340", "342", "344", "345", "341S", "341", "346", "349", "350", "351", "352", "353", "354", "355", "356", "359", "360", "361", "362T", "364", "362", "363", "366", "367", "368", "371", "369", "372", "374", "375", "376", "368X", "379", "382", "383", "379T", "385", "378", "384", "390C", "395E", "395C", "396", "391","392", "390", "393")
DSDP_only <- c("1","2","3","4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96")
ODP <- c("100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210")
IODP <- c("301", "302", "303", "304", "305", "306", "307", "308", "309", "310", "311", "312", "320T", "320", "321", "323", "324", "317", "318", "327", "328", "329", "330", "334", "335", "336", "339", "340T", "340", "342", "344", "345", "341S", "341", "346", "349", "350", "351", "352", "353", "354", "355", "356", "359", "360", "361", "362T", "364", "362", "363", "366", "367", "368", "371", "369", "372", "374", "375", "376", "368X", "379", "382", "383", "379T", "385", "378", "384", "390C", "395E", "395C", "396", "391","392", "390", "393")

coretype_colors <- c("APC" = "mediumturquoise", "HLAPC" = "royalblue4", "XCB" = "palevioletred3", "RCB" = "orange")
programs <- c("DSDP", "ODP", "IODP")
#program colors
pal <- colorFactor(
  palette = c('yellow', 'red', 'purple'),
  domain = exp_coords$program
)

ui <- dashboardPage(
  title = "Scientific Ocean Drilling Map", #website title
  header = dashboardHeader(title = "Scientific Ocean Drilling Map"),
  sidebar = dashboardSidebar(width = "0px"),
  body = dashboardBody(
    tags$style(type = "text/css", "#mymap {height: calc(100vh - 400px) !important;}"),
    #tags$style(".input2 .btn {height: 26.5px; min-height: 26.5px; padding: 0px;}"),
    fluidRow(
      box(width = 12,
          leafletOutput("mymap")
      )
    ),
    fluidRow(
             box(width = 2,
                 pickerInput('input1', 'Program:', 
                             choices = programs,
                             selected = programs,
                             options = list(`actions-box` = TRUE), 
                             multiple = T)
             ),
             box(width = 2,
                 pickerInput('input2', 'Expedition:', 
                             choices = all_exp,
                             selected = all_exp,
                             options = pickerOptions(`actions-box` = TRUE, dropupAuto = FALSE),
                             multiple = T)
             ),
             box(width = 3,
                 column(width = 6, numericInput('input3', 'Water Depth Minimum:', 0)),
                 column(width = 6, numericInput("input4", "Water Depth Maximum:", max(exp_coords$Water.depth..m., na.rm = TRUE)))
             ),
             box(width = 3,
                 column(width = 6, numericInput('input5', 'Penetration Minimum:', 0)),
                 column(width = 6, numericInput("input6", "Penetration Maximum:", max(exp_coords$Penetration.DSF..m., na.rm = TRUE)))
             ),
             column(width = 1,
                 h1(" "),
                 actionBttn(inputId = "reset_all", label = "Reset", style = "bordered", color = "success", icon = icon("cog")
                 )
             )
    ),
      fluidRow(
        box(width = 12,
          DT::dataTableOutput("SiteHoleTable"))),
    br(),
    fluidRow(
      box(width = 3,
          plotOutput("plot_H2Odist")
      ),
      box(width = 3,
          plotOutput("plot_Pendist")
      ),
      box(width = 3,
          plotOutput("plot_TotalCoredist")
      ),
      box(width = 3,
          plotOutput("plot_RecoveryPctdist")
      )
    ),
    br(),
    "Data is derived from LORE: ",
    tags$a(href="https://web.iodp.tamu.edu/LORE/", 
           "https://web.iodp.tamu.edu/LORE/",
           target="_blank"), #app link
    br(),
    "Water depth data for Leg/Exp 1 to 312 is derived from JANUS: ",
    tags$a(href="https://web.iodp.tamu.edu/janusweb/coring_summaries/sitesumm.shtml", 
           "JANUS Data",
           target="_blank"), #app link
    br(),
    "*Cores may be temporarily housed in other repositories. Always check with the repository curator for the most up-to-date information.",
    br(),
    tags$i("These are not official IODP-JRSO applications and functionality is 
           not guaranteed. User assumes all risk."), #italic disclaimer
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
    tags$script("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';")
  )
)

server <- function(input, output, session) {
#########---Reactive Searched Dataframe---######################################
  
  observeEvent(input$reset_all, {
    updatePickerInput(session, "input1", choices = programs, selected = programs)
    updatePickerInput(session, "input2", choices = all_exp, selected = all_exp)
    updateNumericInput(session, "input3", value = 0)
    updateNumericInput(session, "input4", value = max(exp_coords$Water.depth..m.))
    updateNumericInput(session, "input5", value = 0)
    updateNumericInput(session, "input6", value = max(exp_coords$Penetration.DSF..m., na.rm = TRUE))
  })
  
  choose_program <- reactive({
    exp_range <- subset(exp_coords, program %in% input$input1)
    exp_range1 <- unique(exp_range$Exp)
    sorted_exp <- exp_range1[order(match(exp_range1, all_exp))]
  })
  
  observe({ #use Program to limit Exp choices
    updatePickerInput(session, "input2", choices = choose_program(), selected = choose_program())
  })
  
  chosen_progs <- reactive({
    prog_range <- subset(exp_coords, program %in% input$input1) #narrow down to programs
    exp_range <- subset(prog_range, Exp %in% input$input2) #narrow down to Exps
    water_range <- subset(exp_range, Water.depth..m. <= input$input4 & Water.depth..m. >= input$input3) #narrow down to water depths
    pen_range <- subset(water_range, Penetration.DSF..m. <= input$input6 & Penetration.DSF..m. >= input$input5) #narrow down to penetrations
    pen_range
  })
  #####---Prep values for pie chart##############
  core_pie <- reactive({
    hm <- as.data.frame(t(colSums(chosen_progs()[,c(14:17)])))
    hm2 <- gather(hm)
    hm2[,1] <- c("APC", "HLAPC", "XCB","RCB")
    hm2 <- subset(hm2, value > 0)
    hm2$pct <- hm2$value/(sum(hm2$value))*100
    hm2$pct <- round(hm2$pct, digits = 0)
    hm2
  })
  
#########---Output Map---#######################################################
  output$mymap <- renderLeaflet({
    leaflet(chosen_progs()) %>%
      addTiles() %>% #related to our background, can allow us to label
      addCircles(lng = ~Longitude_DD, lat = ~Latitude_DD, #add our exp points
                 popup = paste("Expedition:", chosen_progs()$Exp, "<br>",
                               "Site:", chosen_progs()$Site, "<br>",
                               "Hole:", chosen_progs()$Hole, "<br>",
                               "Total cores:", chosen_progs()$Total.cores..no..), #if you click one, it will show the date
                 weight = 15, radius = 30, #size of the circles
                 color = ~pal(program)) %>% #color of the circles
      addLegend("bottomright", pal = pal, values = ~program,
                title = "Program",
                opacity = 1) %>%
      setView( lng = 0, lat = 0, zoom = 2.5 ) %>% #set the initial view
      addProviderTiles("Esri.WorldImagery") #nice looking background
  })
#########---Output Table---#####################################################  
  output$SiteHoleTable <- DT::renderDataTable({
    pretty_table <- chosen_progs()
    pretty_table <- pretty_table[,c(1:22,25,26)]
    round(pretty_table$Latitude_DD, digits = 4)
    round(pretty_table$Longitude_DD, digits = 4)
    names(pretty_table)[4] <- "Latitude"
    names(pretty_table)[5] <- "Longitude"
    names(pretty_table)[6] <- "Water depth (m)"
    names(pretty_table)[7] <- "Penetration (DSF m)"
    names(pretty_table)[8] <- "Cored interval (m)"
    names(pretty_table)[9] <- "Recovered length (m)"
    names(pretty_table)[10] <- "Recovery (%)"
    names(pretty_table)[11] <- "Drilled interval (m)"
    names(pretty_table)[12] <- "Drilled interval (no.)"
    names(pretty_table)[13] <- "Total cores"
    names(pretty_table)[14] <- "APC cores"
    names(pretty_table)[15] <- "HLAPC cores"
    names(pretty_table)[16] <- "XCB cores"
    names(pretty_table)[17] <- "RCB cores"
    names(pretty_table)[18] <- "Other cores"
    names(pretty_table)[19] <- "Date started (UTC)"
    names(pretty_table)[20] <- "Date finished (UTC)"
    names(pretty_table)[21] <- "Time on hole (days)"
    names(pretty_table)[22] <- "Comments"
    names(pretty_table)[23] <- "Program"
    names(pretty_table)[24] <- "Repository*"
    DT::datatable(pretty_table, options = list(pageLength = 5, scrollX = TRUE), rownames= FALSE)%>% 
      formatRound(columns = c(4:5), digits = 4)
  })
#########---Output Graphs---#####################################################   
  output$plot_H2Odist <- renderPlot({
    ggplot() +
      geom_histogram(data = chosen_progs(), aes(x = Water.depth..m.),
                     binwidth = 0.01*max(chosen_progs()$Water.depth..m.), fill = "gold", color = "gray40") +
      labs(x = "Water Depth (m)", subtitle = paste0("Water Depth Distribution, n = ", sum(!is.na(chosen_progs()$Water.depth..m.))))
  })
  ###################################
  output$plot_Pendist <- renderPlot({
    ggplot() +
      geom_histogram(data = chosen_progs(), aes(x = Penetration.DSF..m.),
                     binwidth = 0.01*max(chosen_progs()$Penetration.DSF..m.), fill = "gold", color = "gray40") +
      labs(x = "Penetration (m)", subtitle = paste0("Seafloor Penetration Distribution, n = ", sum(!is.na(chosen_progs()$Penetration.DSF..m.))))
  })
  ###################################
  output$plot_TotalCoredist <- renderPlot({
    validate(
      need(nrow(chosen_progs()) > 0, "No data for this selection.")
    )
    ggplot(core_pie(), aes(x="", y=value, fill=key)) +
      geom_bar(stat="identity", width=1, color="white") +
      coord_polar("y", start=0) +
      theme_void() +
      theme(legend.position="none") +
      scale_fill_manual(values = coretype_colors) +
      geom_label(aes(label = paste0(key,"\n",value,"\n","(",pct,"%)")), position = position_stack(vjust = 0.5), size = 5, alpha = 0.8, color = "white") +
      # geom_text(aes(label = paste0(key,"\n",value)),
      #           position = position_stack(vjust = 0.5), color = "white", size = 5) +
      labs(title = "Coring Types", 
           caption = "Note: Expeditions 341 and 346 used the HLAPC system, \n
           however a letter designation did not yet exist for that coring type and are not represented here.")
  })
  ###################################
  recovery_special <- reactive({
    real_recovery <- subset(chosen_progs(), Recovery.... < 120)
  })
  output$plot_RecoveryPctdist <- renderPlot({
    ggplot() +
      geom_histogram(data = recovery_special(), aes(x = Recovery....),
                     binwidth = 2, fill = "gold", color = "gray40") +
      labs(x = "Recovery %", subtitle = paste0("Recovery % Distribution, n = ", sum(!is.na(recovery_special()$Recovery....)))) +
      coord_cartesian(xlim = c(0,120))
  })
}

shinyApp(ui = ui, server = server)