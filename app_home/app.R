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
    title = "R Shiny Applications for Ocean Drilling", #website title
    header = dashboardHeader(title = "R Shiny Applications for Ocean Drilling"),
    sidebar = dashboardSidebar(width = "0px"),
    body = dashboardBody(
        tags$i("These are not official IODP-JRSO applications and functionality is 
         not guaranteed. User assumes all risk."), #italic disclaimer
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        ########################################################################
        h4("General Applications", style = 'font-weight: bold;'), #subset of applications
        fluidRow(
        userBox(
            title = userDescription(
                title = "DSDP, ODP, IODP Coring Type Statistics",
                subtitle = "",
                image = "ops_app_image.jpg"
            ),
            status = "teal",
            closable = FALSE,
            maximizable = TRUE,
            tags$a(href="https://shinylaurel.com/shiny/Ops_DrillTypes/", 
                   "Visit the application page.",
                   target="_blank"), #another app link,
            footer = "This application provides a graphic summary of drilling types including 
            APC (advanced piston corer), HLAPC (half-length advanced piston corer), 
            RCB (rotary core barrel), and XCB (extended core barrel). Recovery counts 
            are available by program and expedition. Recovery with depth is also 
            available by program and expedition. Scaled and unscaled graphs are available."
        ),
        userBox(
            title = userDescription(
                title = "Scientific Ocean Drilling Map",
                subtitle = "",
                image = "map_app_image.jpg"
            ),
            status = "teal",
            closable = FALSE,
            maximizable = TRUE,
            tags$a(href="https://shinylaurel.com/shiny/drilling_map/", 
                   "Visit the application page.",
                   target="_blank"), #another app link,
            footer = "This application provides a visualization of all ocean drilling
            sites for DSDP, ODP, and IODP. The map is interactive and holes can be
            clicked on to learn further information. The map is subsettable by a
            range of expeditions using the slider. A table is provided at the bottom
            for additional reference."
        )),
        ########################################################################
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        h4("Outreach Applications", style = 'font-weight: bold;'), #subset of applications
        fluidRow(
            userBox(
                title = userDescription(
                    title = "Ocean Drilling Movie Database",
                    subtitle = "",
                    image = "JR_icon.jpg"
                ),
                status = "maroon",
                closable = FALSE,
                maximizable = TRUE,
                tags$a(href="https://shinylaurel.com/shiny/outreach_videos/", 
                       "Visit the application page.",
                       target="_blank"), #another app link,
                footer = "Search the ocean drilling movie database by expedition
                and keywords/terms. Links to video content provided where available."
            )),
        ########################################################################
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        h4("GCR Applications", style = 'font-weight: bold;'), #subset of applications
        fluidRow(
            userBox(
                title = userDescription(
                    title = "GCR Sample Planning",
                    subtitle = "",
                    image = "GCR_app_image.jpg"
                ),
                status = "purple",
                closable = FALSE,
                maximizable = TRUE,
                tags$a(href="https://shinylaurel.com/shiny/GCR_sample_planning/", 
                       "Visit the application page.",
                       target="_blank"), #another app link,
                footer = "This application provides several tools for sample planning
              purposes. (1) The user provides, singularly or in batch, sample
              requests by 'mbsf' scale (m CSF-A) and the application returns a
              samples list with appropriate sample IDs. (2) The user supplies a
              range of cores and sample interval and the application returns a 
              sample list of repetitive sampling. (3) The user provides a density
              and either a volume or mass and the alternative is returned. (4) The
              user provides samples by sample type and material volumes are provided."
            )),
        ########################################################################
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        h4("At Sea Applications", style = 'font-weight: bold;'),
        fluidRow(
        userBox(
            title = userDescription(
                title = "EPM Daily Report",
                subtitle = "",
                image = "JR_icon.jpg"
            ),
            status = "orange",
            closable = FALSE,
            maximizable = TRUE,
            tags$a(href="https://shinylaurel.com/shiny/daily_report_maker/", 
                   "Visit the application page.",
                   target="_blank"), #another app link,
            footer = "This application assists with the summary of coring information
              for the EPM daily report. While at sea it will be better to run
              this application locally, however you may preview it here."
        ),
        userBox(
            title = userDescription(
                title = "Hydrocarbon Safety Monitoring",
                subtitle = "",
                image = "JR_icon.jpg"
            ),
            status = "orange",
            closable = FALSE,
            maximizable = TRUE,
            tags$a(href="https://shinylaurel.com/shiny/JRhydrocarbon/", 
                   "Visit the application page.",
                   target="_blank"), #another app link,
            footer = "This application provides two sub-applications to assist with
              hydrocarbon safety monitoring. One assists in the construction of
              a thermal gradient. The other provides a graphic summary of 
              hydrocarbon and temperature data, with guides for anomalous and
              normal measurements. This application is not a replacement for 
              geochemical knowledge or approval from appropriate drilling panels.
              This application will also work better at sea if run locally."
        )),
        ########################################################################
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        h4("Post-Expedition Applications", style = 'font-weight: bold;'), #subset of applications
        fluidRow(
            userBox(
                title = userDescription(
                    title = "The 'cm-by-cm' Tool",
                    subtitle = "",
                    image = "coming_soon.jpg"
                ),
                status = "navy",
                closable = FALSE,
                maximizable = TRUE,
                tags$a(href="https://web.iodp.tamu.edu/LORE/", 
                       "Visit the application page.",
                       target="_blank"), #another app link,
                footer = "Convert section summaries to tables with rows
           cm-by-cm. Add in splice and alternate depth scale information as desired."
            )),
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
