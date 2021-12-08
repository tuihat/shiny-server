#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)

# Define UI for application that draws a histogram
ui <- dashboardPage(
    title = "R Shiny Applications for Ocean Drilling", #website title
    header = dashboardHeader(title = "R Shiny Applications for Ocean Drilling"),
    sidebar = dashboardSidebar(width = "0px"),
    body = dashboardBody(
        tags$i("These are not official IODP-JRSO applications and functionality is 
         not guaranteed. User assumes all risk."), #italic disclaimer
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        h4("General Applications", style = 'font-weight: bold;'), #subset of applications
        userBox(
            title = userDescription(
                title = "Elizabeth Pierce",
                subtitle = "Web Designer",
                image = "ops_app_image.jpg"
            ),
            status = "teal",
            closable = FALSE,
            maximizable = TRUE,
            "Some text here!",
            footer = "The footer here!"
        ),
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
                              }'))) 
    ),
    

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    # output$opsdrillimg <- renderImage({
    #     return(list(src = "www/ops_app_image.jpg", height = 300,
    #                 contentType = "image/png", alt = "App Preview Image"))
    # }, deleteFile = FALSE) #where the src is wherever you have the picture

}

# Run the application 
shinyApp(ui = ui, server = server)
