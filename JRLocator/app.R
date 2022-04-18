library(shiny)
library(shinythemes)
#library(imager)
library(leaflet)

#load data
jr_icon <- makeIcon("ship_icon.jpg", iconWidth = 100, iconHeight = 100)
jr_loc <- read.csv("JR_location.csv")
jr_loc100 <- jr_loc[c(1:100),] #just the last 100 days
jr_today <- jr_loc[1,]


#position colors
pal <- colorFactor(
  palette = c('yellow', 'red', 'purple'),
  domain = jr_loc100$status
)

ui <- fluidPage(theme = shinytheme("slate"),
                title = "JOIDES Resolution Locator Map", #website title
                titlePanel("JOIDES Resolution Locator Map - Previous 100 Days"),
                tags$style(type = "text/css", "#mymap {height: calc(100vh - 100px) !important;}"),
                fluidRow(width = 12, leafletOutput("mymap")),
                fluidRow(width = 12, textOutput("lastdate")),
                tags$i("These are not official IODP-JRSO applications 
                                    and functionality is not guaranteed. User assumes all risk.") #italic disclaimer
  
)

server <- function(input, output, session) {
#########---Output Map---#######################################################
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% #related to our background, can allow us to label
      addCircles(lng = jr_loc100$lon_DD, lat = jr_loc100$lat_DD, #add our exp points
                 popup = paste("Expedition:", jr_loc100$exp, "<br>",
                               "Date:", jr_loc100$date, "<br>"), #if you click one, it will show the date
                 weight = 15, radius = 30, #size of the circles
                 color = pal(jr_loc100$status)) %>% #color of the circles
      addMarkers(lng = jr_today$lon_DD, lat = jr_today$lat_DD, icon = jr_icon) %>%
      addLegend("bottomright", pal = pal, values = jr_loc100$status,
                title = "",
                opacity = 1) %>%
      setView( lng = 0, lat = 0, zoom = 2.5 ) %>% #set the initial view
      addProviderTiles("Esri.WorldImagery") #nice looking background
  })
  
#String output of most recent position date
  output$lastdate <- renderText({
    paste0("Map last updated: ",jr_today$date)
  })
   
}

shinyApp(ui = ui, server = server)