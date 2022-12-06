#SOD Timeline
#started: 5 December 2022
#updated: 5 December 2022
#Laurel Childress; childress@iodp.tamu.edu

###############################################################################
# A very basic map leaflet of expedition holes.
###############################################################################

#Packages
if(!require(shiny)){ #check if the package is installed and sourced
  install.packages("shiny") #if not, install the package
  library(shiny) #and source the package
}

if(!require(timevis)){ #check if the package is installed and sourced
  install.packages("timevis") #if not, install the package
  library(timevis) #and source the package
}

data <- read.csv("timeline.csv")

timevisDataGroups <- data.frame(
  id = c("SOD", "science", "tech", "space", "media", "interest"),
  content = c("Scientific Ocean Drilling - General", "Scientific Discoveries", "Scientific Ocean Drilling Technology", "Space Exploration", "Media", "Human Interest")
)

ui <- fluidPage(
  h2("History of Scientific Ocean Drilling"),
  h4("(and some other stuff...)"),
  timevisOutput("timeline"),
  tags$head(
    tags$style(HTML(".red_style   { border-color: #B79F00; color: white; background-color: #B79F00; }
                     .green_style { border-color: #F564E3; color: white; background-color: #F564E3; }
                     .blue_style { border-color: #F8766D; color: white; background-color: #F8766D; }
                     .yellow_style   { border-color: #00BFC4; color: white; background-color: #00BFC4; }
                     .purple_style { border-color: #619CFF; color: white; background-color: #619CFF; }
                     .orange_style { border-color: #00BA38; color: white; background-color: #00BA38; }
                    "))
  ),
  h3("More information about selected event:"),
  h5("(click on an event to see more)"),
  br(),
  textOutput("eventsummary"),
  uiOutput("keyfacts"),
  tags$head(tags$style(HTML("#eventsummary {font-size: 20px;}"))),
  hr(),
  tags$i("These are not official IODP-JRSO applications 
                                    and functionality is not guaranteed. User assumes all risk.") #italic disclaimer
)

server <- function(input, output, session) {
  output$timeline <- renderTimevis({
    timevis(data = data, groups = timevisDataGroups, fit = TRUE, showZoom = TRUE)
  })
  
  choose_program <- reactive({
    event <- subset(data, id == input$timeline_selected)
    event2 <- event$extra_info
  })
  
  output$eventsummary <- renderText({
    temp <- paste0(choose_program())
    final <- temp
  })
  
  output$keyfacts <- renderUI({
    event <- subset(data, id == input$timeline_selected)
    if (req(event$link_check) == "yes") {
      url <- a(event$content, href = event$link)
      tagList("URL link:", url) }
    else {div()}
  })
    

}

shinyApp(ui = ui, server = server)