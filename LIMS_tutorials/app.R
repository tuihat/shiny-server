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
        h4("Overview", style = 'font-weight: bold;'), #subset of applications
        fluidRow(
          column(width = 6, 
                 box(title = "An Introduction to LIMS",
                     status = "primary",
                     solidHeader = T,
                     collapsible = F,
                     h5("LIMS is the Laboratory Information Management System used to organize operations 
                            and scientific data collected by expeditions of the JOIDES Resolution. LORE is the 
                            LIMS Online Report portal used to access the data stored in LIMS."),
                                     h5("This tutorial is a companion to the JRSO Laboratory Manuals, Guides, and Resources 
                               and offers a step-by-step tour through the interface, as well as some examples of common LIMS usage."))),
          column(width = 6,
                 tags$iframe(width="560", height="315", src="https://www.youtube.com/watch?v=hZjOvfSlo3c", 
                             frameborder="0", allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture", allowfullscreen=NA))),
        ########################################################################
        ########################################################################
        tags$hr(style="border-color: purple;"),
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        h4("Common LIMS searches", style = 'font-weight: bold;'), #subset of applications
        fluidRow(
            column(width = 6,
        box(title = "Find your samples",
            status = "primary",
            solidHeader = T,
            collapsible = F,
            width = 12,
            fluidRow(column(width = 4, style = "height:350px;padding:50px;", 
                            h5("How to locate samples collected shipboard or at a repository that are assigned to you."),
                            tags$a(href="https://shinylaurel.com/shiny/JRhydrocarbon/", 
                                   "Watch the tutorial.",
                                   target="_blank")),
                     # column(width = 8, 
                     #        tags$video(id="video1", type = "video/mp4", src = "Tutorial-HowToFindYourSamples.mp4", controls = "controls", width = 500)),
                     column(width = 8, align = "center",
                            img(src="find_your_samples_icon.png", height=195))))),
        column(width = 6,
               box(title = "Add CCSF (composite) depths to LIMS",
                   status = "primary",
                   solidHeader = T,
                   collapsible = F,
                   width = 12,
                   fluidRow(column(width = 4, style = "height:200px;padding:50px;", 
                                   h5("How to add composite depth scales (CCSF) to LIMS data and your own sample lists."),
                                   tags$a(href="https://shinylaurel.com/shiny/JRhydrocarbon/", 
                                          "Watch the tutorial.",
                                          target="_blank")),
                            # column(width = 8, 
                            #        tags$video(id="video1", type = "video/mp4", src = "Tutorial-HowToFindYourSamples.mp4", controls = "controls", width = 500)),
                            column(width = 8, align = "center",
                                   img(src="CCSF_depths_icon.png", height=195)))))),
        ########################################################################
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        ########################################################################
        hr(style = "border-top: 1px solid #000000;"), #horizontal line

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
##########DOWNLOAD overview tutorial############################################
    output$download1 <- downloadHandler(
        filename <- function() {
            paste("Tutorial-LIMS_Overview", "mp4", sep=".")
        },
        
        content <- function(file) {
            file.copy("Tutorial-LIMS_Overview.mp4", file)
        })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
