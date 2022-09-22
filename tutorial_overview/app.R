#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(shinydashboard)
library(shinydashboardPlus)

# Define UI for application that draws a histogram
ui <- dashboardPage(
    title = "LIMS Tutorials", #website title
    header = dashboardHeader(title = "LIMS Tutorials"),
    sidebar = dashboardSidebar(width = "0px"),
    body = dashboardBody(
        tags$i("These are not official IODP-JRSO applications and functionality is 
         not guaranteed. User assumes all risk."), #italic disclaimer
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        ########################################################################
        h2("Tutorial: An Introduction to LIMS"),
            fluidRow(column(width = 12, 
                            tags$video(id="video1", type = "video/mp4", src = "Tutorial-LIMS_Overview.mp4", controls = "controls", width = 800))),

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
                              }'))),
        tags$script("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';") 
    )
    

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

}

# Run the application 
shinyApp(ui = ui, server = server)
