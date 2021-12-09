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

exp_coords <- read.csv("DSDP_ODP_IODP_coords_LIMS.csv")

#program colors
pal <- colorFactor(
  palette = c('yellow', 'red', 'purple'),
  domain = exp_coords$program
)

ui <- fluidPage(
  title = "Scientific Ocean Drilling Map", #website title
  h3("Scientific Ocean Drilling Map"),
  leafletOutput("mymap", height = "800px", width = "1600px"),
  "Data is derived from LORE: ",
  tags$a(href="https://web.iodp.tamu.edu/LORE/", 
         "https://web.iodp.tamu.edu/LORE/",
         target="_blank"), #app link
  br(),
  tags$i("These are not official IODP-JRSO applications and functionality is 
         not guaranteed. User assumes all risk.") #italic disclaimer
)

server <- function(input, output) {
  output$mymap <- renderLeaflet({
    leaflet(exp_coords) %>%
      addTiles() %>% #related to our background, can allow us to label
      addCircles(lng = ~Longitude_DD, lat = ~Latitude_DD, #add our exp points
                 popup = paste("Expedition:", exp_coords$Exp, "<br>",
                               "Site:", exp_coords$Site, "<br>",
                               "Hole:", exp_coords$Hole, "<br>",
                               "Total cores:", exp_coords$Total.cores..no..), #if you click one, it will show the date
                 weight = 15, radius = 30, #size of the circles
                 color = ~pal(program)) %>% #color of the circles
      addLegend("bottomright", pal = pal, values = ~program,
                title = "Program",
                opacity = 1) %>%
      setView( lng = 0, lat = 0, zoom = 2.5 ) %>% #set the initial view
      addProviderTiles("Esri.WorldImagery") #nice looking background
  })
}

shinyApp(ui = ui, server = server)