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
  id = c("SOD", "science", "interest"),
  content = c("Scientific Ocean Drilling", "Scientific Discoveries", "Human Interest")
)

ui <- fluidPage(
  h2("History of Scientific Ocean Drilling"),
  h4("(and some other stuff...)"),
  timevisOutput("timeline"),
  tags$head(
    tags$style(HTML(".red_style   { border-color: red; color: white; background-color: red; }
                     .green_style { border-color: green; color: white; background-color: green; }
                     .blue_style { border-color: blue; color: white; background-color: blue; }
                    "))
  ),
  tags$i("These are not official IODP-JRSO applications 
                                    and functionality is not guaranteed. User assumes all risk.") #italic disclaimer
)

server <- function(input, output, session) {
  output$timeline <- renderTimevis({
    timevis(data = data, groups = timevisDataGroups)
  })
}

shinyApp(ui = ui, server = server)