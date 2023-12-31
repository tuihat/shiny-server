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
        fluidRow(
          column(width = 3,
        h4("General Applications", style = 'font-weight: bold;'), #subset of applications
        userBox(width = 12,
                title = userDescription(
                  title = h4("Scientific Ocean Drilling Map"),
                  subtitle = "",
                  image = "map_app_image.jpg"
                ),
                status = "teal",
                closable = FALSE,
                maximizable = TRUE,
                tags$a(href="https://shinylaurel.com/shiny/drilling_map/", 
                       "Visit the app.",
                       target="_blank"), #another app link,
                footer = "This application provides a visualization of all ocean drilling
            sites for DSDP, ODP, and IODP. The map is interactive and holes can be
            clicked on to learn further information. The map is subsettable by drilling
            program, expedition, water depth, and seafloor penetration. A table and severl
            graphs are provided at the bottom for additional reference."
        ),
        userBox(width = 12,
                title = userDescription(
                  title = h4("JOIDES Resolution Drilling Stats"),
                  subtitle = "",
                  image = "JR_drill_stat_image.jpg"
                ),
                status = "teal",
                closable = FALSE,
                collapsed = TRUE,
                maximizable = TRUE,
                tags$a(href="https://shinylaurel.com/shiny/JR_drilling_stats/", 
                       "Visit the app.",
                       target="_blank"), #another app link,
                footer = "This application provides a visualization of some JOIDES
            Resolution drilling statistics and offers several filters for parameters
            such as core recovery and water depth. The entire
            database or the selected expeditions can be downloaded. Glomar Challenger
            statistics are available as well but should be used with caution."
        ),
        userBox(width = 12,
            title = userDescription(
                title = h4("Coring Type Statistics"),
                subtitle = "",
                image = "ops_app_image.jpg"
            ),
            status = "teal",
            closable = FALSE,
            collapsed = TRUE,
            maximizable = TRUE,
            tags$a(href="https://shinylaurel.com/shiny/Ops_DrillTypes/", 
                   "Visit the app.",
                   target="_blank"), #another app link,
            footer = "This application provides a graphic summary of drilling types including 
            APC (advanced piston corer), HLAPC (half-length advanced piston corer), 
            RCB (rotary core barrel), and XCB (extended core barrel). Recovery counts 
            are available by program and expedition. Recovery with depth is also 
            available by program and expedition. Scaled and unscaled graphs are available."
        ),
        userBox(width = 12,
                title = userDescription(
                  title = h4("Scientific Ocean Drilling Ages"),
                  subtitle = "",
                  image = "timescale.jpg"
                ),
                status = "teal",
                closable = FALSE,
                collapsed = TRUE,
                maximizable = TRUE,
                tags$a(href="https://shinylaurel.com/shiny/SOD_ages/", 
                       "Visit the app.",
                       target="_blank"), #another app link,
                footer = "This application provides epoch and period ages for
                scientific ocean drilling sites of DSDP, ODP, and IODP. Data should
                not be considered complete or exhaustive and is based on http://iodp.tamu.edu/database/ages_dsdp.html"
        )),
        ########################################################################
        # hr(style = "border-top: 1px solid #000000;"), #horizontal line
          column(width = 3,
            h4("Outreach Applications", style = 'font-weight: bold;'), #subset of applications
            userBox(width = 12,
                title = userDescription(
                    title = h4("Ocean Drilling Movie Database"),
                    subtitle = "",
                    image = "JR_icon.jpg"
                ),
                status = "maroon",
                closable = FALSE,
                maximizable = TRUE,
                tags$a(href="https://shinylaurel.com/shiny/outreach_videos/", 
                       "Visit the app.",
                       target="_blank"), #another app link,
                footer = "Search the ocean drilling movie database by expedition
                and keywords/terms. Links to video content provided where available."
            ),
            userBox(width = 12,
                title = userDescription(
                    title = h4("JOIDES Resolution Locator"),
                    subtitle = "",
                    image = "map_app_image.jpg"
                ),
                status = "maroon",
                closable = FALSE,
                maximizable = TRUE,
                tags$a(href="https://shinylaurel.com/shiny/JRLocator/", 
                       "Visit the app.",
                       target="_blank"), #another app link,
                footer = "This application provides a visualization of the current
                location of the JOIDES Resolution and the midnight position for 
                the past 100 days."
            ),
            #############################
            hr(), br(), br(),
                   h4("At Sea Applications", style = 'font-weight: bold;'),
                   userBox(width = 12,
                     title = userDescription(
                       title = h4("EPM Daily Report"),
                       subtitle = "",
                       image = "JR_icon.jpg"
                     ),
                     status = "orange",
                     closable = FALSE,
                     collapsed = TRUE,
                     maximizable = TRUE,
                     tags$a(href="https://shinylaurel.com/shiny/daily_report_maker/", 
                            "Visit the app.",
                            target="_blank"), #another app link,
                     footer = "This application assists with the summary of coring information
              for the EPM daily report. While at sea it will be better to run
              this application locally, however you may preview it here."
                   ),
                   userBox(width = 12,
                     title = userDescription(
                       title = h4("Hydrocarbon Safety Monitoring"),
                       subtitle = "",
                       image = "JR_icon.jpg"
                     ),
                     status = "orange",
                     closable = FALSE,
                     collapsed = TRUE,
                     maximizable = TRUE,
                     tags$a(href="https://shinylaurel.com/shiny/JRhydrocarbon/", 
                            "Visit the app.",
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
        # hr(style = "border-top: 1px solid #000000;"), #horizontal line
          column(width = 3,
          h4("GCR & Data Access Applications", style = 'font-weight: bold;'), #subset of applications
          userBox(width = 12,
                  title = userDescription(
                    title = h4("LIMS2 - A Database of Databases"),
                    subtitle = "",
                    image = "LIMS2_disco_ball.jpg"
                  ),
                  status = "purple",
                  closable = FALSE,
                  maximizable = TRUE,
                  tags$a(href="https://shinylaurel.com/shiny/LIMS2/", 
                         "Visit the app.",
                         target="_blank"), #another app link,
                  footer = "This application provides quick access to data from the Deep 
              Sea Drilling Project (DSDP), the Ocean Drilling Program (ODP), and beyond 
              that is not stored in the Laboratory Information Management System (LIMS).
              DSDP (Deep Sea Drilling Project) and ODP (Ocean Drilling Program) data are 
              stored at the NOAA National Centers for Environmental Information (NCEI) 
              formerly known as NGDC (National Geophysical Data Center)."),  
          userBox(width = 12,
                title = userDescription(
                    title = h4("GCR Sample Planning"),
                    subtitle = "",
                    image = "GCR_app_image.jpg"
                ),
                status = "purple",
                closable = FALSE,
                collapsed = TRUE,
                maximizable = TRUE,
                tags$a(href="https://shinylaurel.com/shiny/GCR_sample_planning/", 
                       "Visit the app.",
                       target="_blank"), #another app link,
                footer = "This application provides several tools for sample planning
              purposes. (1) The user provides, singularly or in batch, sample
              requests by 'mbsf' scale (m CSF-A) and the application returns a
              samples list with appropriate sample IDs. (2) The user supplies a
              range of cores and sample interval and the application returns a 
              sample list of repetitive sampling. (3) The user provides a density
              and either a volume or mass and the alternative is returned. (4) The
              user provides samples by sample type and material volumes are provided."),
            userBox(width = 12,
              title = userDescription(
                title = h4("GCR Display Cores"),
                subtitle = "",
                image = "GCR_app_image.jpg"
              ),
              status = "purple",
              closable = FALSE,
              collapsed = TRUE,
              maximizable = TRUE,
              tags$a(href="https://shinylaurel.com/shiny/GCR_displaycores/", 
                     "Visit the app.",
                     target="_blank"), #another app link,
              footer = "This site previews core sections in the GCR that ready for quick 
              display to students, visitors, and scientists. A preview image is provided, as
              well as a brief overview of the location, science, and age of the material. Links
              to the digital core image, the Initial Report/Proceedings Volume, and the visual core description (VCD)
              are also provided.")
            ),
        ########################################################################
        # hr(style = "border-top: 1px solid #000000;"), #horizontal line
        column(width = 3,
        h4("LILY Applications (coming soon)", style = 'font-weight: bold;'),
        userBox(width = 12,
            title = userDescription(
                title = h4("Lithology Search"),
                subtitle = "",
                image = "LILY_logo.jpg"
            ),
            status = "orange",
            closable = FALSE,
            collapsed = TRUE,
            maximizable = TRUE,
            # tags$a(href="https://shinylaurel.com/shiny/daily_report_maker/", 
            #        "Visit the app.",
            #        target="_blank"), #another app link,
            footer = "This application searches LILY based on text entry."
        ),
        userBox(width = 12,
            title = userDescription(
                title = h4("Lithology/Coring Type"),
                subtitle = "",
                image = "LILY_logo.jpg"
            ),
            status = "orange",
            closable = FALSE,
            collapsed = TRUE,
            maximizable = TRUE,
            # tags$a(href="https://shinylaurel.com/shiny/JRhydrocarbon/", 
            #        "Visit the app.",
            #        target="_blank"), #another app link,
            footer = "This application graphs core recovery in relation to 
            lithology."
        ))),
        ########################################################################
        br(),
        tags$i("Questions, comments, concerns, compliments: shinylaurelwebmaster@gmail.com"),
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
                              }
            google_analytics.html'))),
        tags$script("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';") 
    )

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

}

# Run the application 
shinyApp(ui = ui, server = server)
