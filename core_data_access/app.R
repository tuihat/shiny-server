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
    title = "Scientific Ocean Drilling - Data and Core Access Guide", #website title
    header = dashboardHeader(title = "Data and Core Access Guide"),
    sidebar = dashboardSidebar(width = "0px"),
    body = dashboardBody(
        
        ########################################################################
        # fluidRow(
          # column(12, align="center",
          #        div(style="display: inline-block;",img(src="LILY_logo.jpg", height="20%", width="20%")))),
        h2(HTML("<b>Scientific Ocean Drilling - Data and Core Access Guide</b>"), style="text-align:center"),
        h4(HTML("<b>This PDF provides a guide to accessing scientific ocean drilling (DSDP, ODP, IODP)
        data and cores.</b>"), style="text-align:center"),
        br(),
        h4(HTML("<b>The PDF is interactive and best navigated by downloading the document and viewing 
        it near full screen. Navigate through the document by clicking on items, links, and action
        buttons on each page.</b>"), style="text-align:center"),
        br(),
        h5(HTML("<i>Current version: 1.0</i>"), style="text-align:center"),
        ########################################################################
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        uiOutput("pdfview"),
        ########################################################################
        br(),
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        tags$i("These are not official IODP-JRSO applications and functionality is 
         not guaranteed. User assumes all risk."), #italic disclaimer
        
        tags$i("Questions, comments, concerns, compliments: shinylaurelwebmaster@gmail.com"),
        tags$head(tags$style(HTML('
        /* logo */
        .skin-blue .main-header .logo {
                              background-color: #8e7cc3;width: 400px;
                              }

        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
                              background-color: #8e7cc3;
                              }

        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color: #8e7cc3;margin-left: 400px;
                              }
            google_analytics.html'))),
        tags$script("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';") 
    )

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  output$pdfview <- renderUI({
    tags$iframe(style="height:800px; width:100%", src="SOD_Core_and_Data_Access_InteractivePDF_v1.0.pdf")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
