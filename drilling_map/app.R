#DSDP, ODP, IODP Expedition Map
#started: 1 December 2021
#updated: 21 April 2022
#Laurel Childress; childress@iodp.tamu.edu

###############################################################################
# A very basic map leaflet of expedition holes.
###############################################################################

#Packages
if(!require(rmarkdown)){
  install.packages("rmarkdown")
  library(rmarkdown) #rmarkdown
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
all_exp <- c("1","2","3","4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "301", "302", "303", "304", "305", "306", "307", "308", "309", "310", "311", "312", "320T", "320", "321", "323", "324", "317", "318", "327", "328", "329", "330", "334", "335", "336", "339", "340T", "340", "342", "344", "345", "341S", "341", "346", "349", "350", "351", "352", "353", "354", "355", "356", "359", "360", "361", "362T", "364", "362", "363", "366", "367", "368", "371", "369", "372", "374", "375", "376", "368X", "379", "382", "383", "379T", "385", "378", "384", "390C", "395E", "395C", "396", "391","392")
DSDP_only <- c("1","2","3","4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96")
ODP <- c("100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210")
IODP <- c("301", "302", "303", "304", "305", "306", "307", "308", "309", "310", "311", "312", "320T", "320", "321", "323", "324", "317", "318", "327", "328", "329", "330", "334", "335", "336", "339", "340T", "340", "342", "344", "345", "341S", "341", "346", "349", "350", "351", "352", "353", "354", "355", "356", "359", "360", "361", "362T", "364", "362", "363", "366", "367", "368", "371", "369", "372", "374", "375", "376", "368X", "379", "382", "383", "379T", "385", "378", "384", "390C", "395E", "395C", "396", "391","392")

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
    fluidRow(
      box(width = 12,
          leafletOutput("mymap")
      )
    ),
    fluidRow(
             box(width = 12,
                 sliderTextInput(
                   inputId = "chooseExps",
                   label = "Choose a range of expeditions:", 
                   choices = all_exp,
                   selected = all_exp[c(1,length(all_exp))]
                 )
             )
    ),
      fluidRow(
        box(width = 12,
          DT::dataTableOutput("SiteHoleTable"))),
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
#########---Reactive Searched Dataframe---######################################
  chosen_progs <- reactive({
    exp_range <- match(c(input$chooseExps[1], input$chooseExps[2]), all_exp)
    exp_range2 <- all_exp[exp_range[1]:exp_range[2]]
    df2 <- exp_coords[exp_coords$Exp %in% exp_range2,]
    df2
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
    pretty_table <- pretty_table[,c(1:22,25)]
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
    DT::datatable(pretty_table, options = list(pageLength = 5, scrollX = TRUE), rownames= FALSE)%>% 
      formatRound(columns = c(4:5), digits = 4)
  })
}

shinyApp(ui = ui, server = server)