library(dplyr)
library(shiny)
library(shinythemes)
#library(imager)
library(leaflet)

#load data
jr_icon <- makeIcon("ship_icon.jpg", iconWidth = 100, iconHeight = 100)
jr_loc <- read.csv("JR_location.csv")
jr_loc100 <- jr_loc[c(1:100),] #just the last 100 days
jr_today <- jr_loc[1,]

##special on-site functions
jr_onsite <- which(jr_loc100$site != dplyr::lag(jr_loc100$site))
jr_onsite2 <- jr_loc100[jr_onsite[1]-1,]

if(jr_onsite2$status == "on site"){
  current_site <- paste0("Site: ", jr_onsite2$site)
  site_since <- paste0("On site since: ",jr_onsite2$date)
}
if(jr_onsite2$status != "on site"){
  current_site <- ""
  site_since <- ""
}

jr_loc100[jr_loc100 == ""] <- NA

#position colors
pal <- colorFactor(
  palette = c('yellow', 'red', 'purple'),
  domain = jr_loc100$status
)

ui <- fluidPage(theme = shinytheme("slate"),
                tags$head(includeHTML(("google-analytics.html"))),
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
                               "Date:", jr_loc100$date, "<br>",
                               "Site:", jr_loc100$site), #if you click one, it will show the date
                 weight = 15, radius = 30, #size of the circles
                 color = pal(jr_loc100$status)) %>% #color of the circles
      addMarkers(lng = jr_today$lon_DD, lat = jr_today$lat_DD, icon = jr_icon,
                 popup = paste("Expedition:", jr_today$exp, "<br>",
                               "Date:", jr_today$date, "<br>",
                               "Status:", jr_today$status, "<br>",
                               current_site, "<br>",
                               site_since)) %>%#if you click one, it will show the date
      addLegend("bottomright", pal = pal, values = jr_loc100$status,
                title = "",
                opacity = 1) %>%
      addScaleBar(position = c("bottomleft"),
        options = scaleBarOptions(maxWidth = 200, metric = TRUE, imperial = FALSE)) %>%
      setView( lng = jr_today$lon_DD, jr_today$lat_DD, zoom = 6 ) %>% #set the initial view
      # fitBounds(
      #   lng1= min(jr_today$lon_DD), lat1= min(jr_today$lat_DD),
      #   lng2= max(jr_today$lon_DD), lat2= max(jr_today$lat_DD),
      #   options = list(padding = c(100,100))) %>% #set the initial view
      addProviderTiles("Esri.WorldImagery") #nice looking background
  })
  
#String output of most recent position date
  output$lastdate <- renderText({
    paste0("Map last updated: ",jr_today$date)
  })
   
}

shinyApp(ui = ui, server = server)