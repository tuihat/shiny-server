library(dplyr)
library(shiny)
library(shinythemes)
#library(imager)
library(leaflet)

#load data
# jr_icon <- makeIcon("ship_icon.jpg", iconWidth = 100, iconHeight = 100)
bike <- read.csv("bike_rack_db.csv")

last_update <- "11 January 2023"

#position colors
pal <- colorFactor(
  palette = c('yellow', 'blue'),
  domain = bike$style
)

ui <- fluidPage(theme = shinytheme("slate"),
                title = "College Station/Bryan Bike Rack Locator", #website title
                titlePanel("College Station/Bryan Bike Rack Locator"),
                tags$style(type = "text/css", "#mymap {height: calc(100vh - 100px) !important;}"),
                fluidRow(width = 12, leafletOutput("mymap")),
                fluidRow(width = 12, textOutput("lastdate")),
                tags$i("This is not an official City of Collge Station or Bryan application 
                                    and functionality is not guaranteed. User assumes all risk.") #italic disclaimer
  
)

server <- function(input, output, session) {
#########---Output Map---#######################################################
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% #related to our background, can allow us to label
      addCircles(lng = bike$lon_DD, lat = bike$lat_DD, #add our bike rack points
                 popup = paste("Approx. # of spots:", bike$num_spots, "<br>",
                               "Type of spot:", bike$style, "<br>",
                               "Date last confirmed:", bike$date_last_confirmed, "<br>",
                               "<img src = ", bike$image_link, ">"), #if you click one, it will show the date
                 weight = 15, radius = 20, #size of the circles
                 color = pal(bike$style)) %>% #color of the circles
      addLegend("bottomright", pal = pal, values = bike$style,
                title = "",
                opacity = 1) %>%
      fitBounds(
        lng1= min(bike$lon_DD), lat1= min(bike$lat_DD),
        lng2= max(bike$lon_DD), lat2= max(bike$lat_DD),
        options = list(padding = c(20,20))) %>% #set the initial view
      addProviderTiles("Esri.WorldImagery") #nice looking background
  })
  
#String output of most recent position date
  output$lastdate <- renderText({
    paste0("Map last updated: ",last_update)
  })
   
}

shinyApp(ui = ui, server = server)