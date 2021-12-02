#DSDP, ODP, IODP Expedition Map
#started: 1 December 2021
#updated: 29 November 2021
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

if(!require(shiny)){ #check if the package is installed and sourced
  install.packages("shiny") #if not, install the package
  library(shiny) #and source the package
}

ui <- fluidPage(
  title = "Scientific Ocean Drilling Map", #website title
  h3("Scientific Ocean Drilling Map"),
  leafletOutput("mymap", height = "800px", width = "1600px")
)

server <- function(input, output) {
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% #related to our background, can allow us to label
      setView( lng = 0, lat = 0, zoom = 2.5 ) %>% #set the initial view
      addProviderTiles("Esri.WorldImagery") #nice looking background
  })
}

shinyApp(ui = ui, server = server)