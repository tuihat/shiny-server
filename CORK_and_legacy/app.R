#Scientific Ocean Drilling CORK & Legacy Holes
#started: 28 February 2024
#updated: 28 February 2024
#Laurel Childress; childress@iodp.tamu.edu

###############################################################################
# A very basic map and table to summarize CORK and legacy holes.

#This application provides a visualization of CORK and legacy holes,
#...along with any known history or properties of each CORK or hole.
###############################################################################

#Packages
if(!require(shiny)){ #check if the package is installed and sourced
  install.packages("shiny") #if not, install the package
  library(shiny) #and source the package
}

if(!require(shinyjs)){ #check if the package is installed and sourced
  install.packages("shinyjs") #if not, install the package
  library(shinyjs) #and source the package
}

if(!require(leaflet)){ #check if the package is installed and sourced
  install.packages("leaflet") #if not, install the package
  library(leaflet) #and source the package 
}

if(!require(DT)){ #check if the package is installed and sourced
  install.packages("DT") #if not, install the package
  library(DT) #and source the package 
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

import_CORK <- read.csv("CORK.csv") #import data
import_legacy <- read.csv("Legacy_Holes.csv") #import data
####################################################

#program colors
pal2 <- colorFactor(
  palette = c('yellow', 'red', 'purple'),
  domain = import_legacy$Program
)

ui <- dashboardPage(
  title = "SOD CORK and Legacy Holes", #website title
  header = dashboardHeader(title = "SOD CORK and Legacy Holes"),
  sidebar = dashboardSidebar(width = "0px"),
  body = dashboardBody(
    tags$style(type = "text/css", "#mymap {height: calc(115vh - 400px) !important;}"),
    #tags$style(".input2 .btn {height: 26.5px; min-height: 26.5px; padding: 0px;}"),
    fluidRow(
      box(width = 12,
          leafletOutput("mymap")
      )
    ),
    h5("This site offers a map and tabular infomration for scientific ocean drilling CORK (Circulation Obviation Retrofit Kit) installations, as well as legacy holes which are fitted with re-entry cones (and possibly casing) for extended use."), 
    h5("CORKs are designed for long-term in situ monitoring of temperature and pressure as well as collecting borehole fluid samples through added tubing and valves. The CORK also provides a means to hang a third-party sensor or an osmotic sampler (to collect geochemical samples) in the casing and open hole. Remotely operated vehicles/(ROVs) or submersibles are routinely used to retrieve the data from the top of a CORK for shore-based study. If the CORK can be attached to an existing subsea cable, data can be downloaded in real time."),
    tags$a(href="https://iodp.merlinone.net/MX/ContentHub/Digital_Library/index.html?portalview=8615&assetview=161609",
           "CORK Guide",
           target="_blank"), #another app link,
    hr(),
    br(),
    h4("CORKS"),
    fluidRow(
      box(width = 12,
          DT::dataTableOutput("CORKTable"))),
    br(),
    br(),
    h4("Legacy Site-Holes"),
    fluidRow(
      box(width = 12,
          DT::dataTableOutput("LegacyTable"))),
    br(),
    br(),
    tags$i("Data is derived from JOIDES Resolution Science Operator."), #italic disclaimer
    br(),
    tags$i("These are not official IODP-JRSO applications and functionality is 
           not guaranteed. User assumes all risk."), #italic disclaimer
    br(),
    tags$i("Questions, comments, concerns, compliments: shinylaurelwebmaster@gmail.com"),
    br(),
    tags$i("This app can be cited by https://doi.org/10.5281/zenodo.10498831"),
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
#########---Reactive Searched Dataframe---#####################################
  
CORK_yrs <- reactive({
  df <- import_CORK
  df$Date.Deployed <- as.Date(df$Date.Deployed, format = "%m/%d/%y")
  df$Date.Retrieved <- as.Date(df$Date.Retrieved, format = "%m/%d/%y")
  
  today <- Sys.Date()
  df$Years.Installed <- (today - df$Date.Deployed)
  
  df$Years.Installed <- ifelse(!is.na(df$Date.Retrieved), (df$Date.Retrieved - df$Date.Deployed), df$Years.Installed)
  df$Years.Installed <- round(df$Years.Installed/365, 1)
  newdf <- df
})
#########---Output Map---#######################################################
CORK_icon = makeIcon("CORK_icon.png", "CORK_icon.png", 25, 25)

output$mymap <- renderLeaflet({
  leaflet() %>%
    addTiles() %>% #related to our background, can allow us to label
    addCircles(data = import_legacy, lng = import_legacy$Longitude..DD., 
               lat = import_legacy$Latitude..DD., group = "Legacy Holes", #add our exp points
               popup = paste("Expedition:", import_legacy$Expedition, "<br>",
                             "Site:", import_legacy$Site, "<br>",
                             "Hole:", import_legacy$Hole, "<br>",
                             import_legacy$Special.Hole.Type), #if you click one, it will show the date
               weight = 15, radius = 30, #size of the circles
               color = ~pal2(Program)) %>% #color of the circles
    addMarkers(data = CORK_yrs(), lng = CORK_yrs()$Longitude..DD., lat = CORK_yrs()$Latitude..DD., #add our exp points
               group = "CORKs",
               popup = paste("Expedition:", CORK_yrs()$Expedition, "<br>",
                             "Site:", CORK_yrs()$Site, "<br>",
                             "Hole:", CORK_yrs()$Hole),
               icon = CORK_icon) %>%
    addLegend("bottomright", pal = pal2, values = import_legacy$Program,
              title = "Program",
              opacity = 1) %>%
    setView( lng = 0, lat = 0, zoom = 2) %>% #set the initial view
    addLayersControl(
      overlayGroups = c("CORKs", "Legacy Holes"),
      options = layersControlOptions(collapsed = FALSE)) %>%
    addProviderTiles("Esri.WorldImagery") #nice looking background
    
})

#########---Output Table---#####################################################  
output$CORKTable <- DT::renderDataTable({
  pretty_table <- CORK_yrs()
  names(pretty_table)[4] <- "Latitude (DD)"
  names(pretty_table)[5] <- "Longitude (DD)"
  names(pretty_table)[6] <- "Water Depth (m below rigfloor)"
  names(pretty_table)[7] <- "CORK Type"
  names(pretty_table)[8] <- "Date Deployed"
  names(pretty_table)[9] <- "Date Retrieved"
  names(pretty_table)[10] <- "Years Installed"
  names(pretty_table)[11] <- "Casing Size (inches, outer diameter)"
  names(pretty_table)[12] <- "Casing Length (m)"
  names(pretty_table)[13] <- "Screens"
  names(pretty_table)[14] <- "# of Packers"
  names(pretty_table)[15] <- "Packer Type"
  names(pretty_table)[16] <- "Notes"
  names(pretty_table)[17] <- "Operations (including 3rd party)"
  names(pretty_table)[18] <- "Program"
  DT::datatable(pretty_table, options = list(pageLength = 5, scrollX = TRUE, columnDefs = list(list(className = 'dt-center', targets = "_all"))), rownames= FALSE)%>% 
    formatRound(columns = c(4:5), digits = 4)
})


output$LegacyTable <- DT::renderDataTable({
  pretty_table2 <- import_legacy
  names(pretty_table2)[4] <- "Special Hole Type"
  names(pretty_table2)[5] <- "General Location"
  names(pretty_table2)[6] <- "Latitude (DD)"
  names(pretty_table2)[7] <- "Longitude (DD)"
  names(pretty_table2)[8] <- "Water Depth (m below rigfloor)"
  names(pretty_table2)[9] <- "Total Penetration (m)"
  names(pretty_table2)[10] <- "Basement Penetration (m)"
  names(pretty_table2)[11] <- "# Casing Strings"
  names(pretty_table2)[12] <- "Casing 1 Size (inches, outer diameter)"
  names(pretty_table2)[13] <- "Casing 1 Bottom Depth (m below seafloor)"
  names(pretty_table2)[14] <- "Casing 2 Size (inches, outer diameter)"
  names(pretty_table2)[15] <- "Casing 2 Bottom Depth (m below seafloor)"
  names(pretty_table2)[16] <- "Casing 3 Size (inches, outer diameter)"
  names(pretty_table2)[17] <- "Casing 3 Bottom Depth (m below seafloor)"
  names(pretty_table2)[18] <- "Program"
  names(pretty_table2)[19] <- "Comment"
  DT::datatable(pretty_table2, options = list(pageLength = 5, scrollX = TRUE, columnDefs = list(list(className = 'dt-center', targets = "_all"))), rownames= FALSE)%>% 
    formatRound(columns = c(6:7), digits = 4)
})
##################################################

}

shinyApp(ui = ui, server = server)