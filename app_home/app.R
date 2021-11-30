#Shiny Laurel Homepage
#started: 29 November 2021
#updated: 29 November 2021
#Laurel Childress; childress@iodp.tamu.edu

###############################################################################
# Navigation interface for ocean drilling related R Shiny applications.
###############################################################################

#Packages
if(!require(rmarkdown)){
  install.packages("rmarkdown")
  library(rmarkdown) #rmarkdown
}

if(!require(shiny)){ #check if the package is installed and sourced
  install.packages("shiny") #if not, install the package
  library(shiny) #and source the package
}


ui <- fluidPage(
  title = "R Shiny Applications for Ocean Drilling", #website title
  tags$style('.container-fluid {
                             background-color:   #f5f5f0 ;
              }'), #background page color
  tags$i("These are not official IODP-JRSO applications and functionality is 
         not guaranteed. User assumes all risk."), #italic disclaimer
  hr(style = "border-top: 1px solid #000000;"), #horizontal line
  h4("General Applications", style = 'font-weight: bold;'), #subset of applications
  br(),
  fluidRow(
  column(3,
         img(src='ops_app_image.jpg', height="100%", width="100%", 
             style="display: block; margin-left: auto; margin-right: auto; border: solid 2px black;")
  ), #app image with border
  column(3,
         tags$a(href="http://shinylaurel.com/shiny/Ops_DrillTypes/", 
                "DSDP, ODP, IODP Coring Type Statistics:",
                style = 'font-weight: bold; font-size: 15px',
                target="_blank"), #app link
         h5("This application provides a graphic 
         summary of drilling types including APC (advanced piston corer), 
         HLAPC (half-length advanced piston corer), RCB (rotary core barrel), and 
         XCB (extended core barrel). Recovery counts are available 
         by program and expedition. Recovery with depth is also available by 
         program and expedition. Scaled and unscaled graphs are available."), #app text
         tags$a(href="http://shinylaurel.com/shiny/Ops_DrillTypes/", 
                "Visit the application page.",
                style = 'font-style: italic;',
                target="_blank"), #another app link
         style='border-right: 2px solid #3c3769; padding:5px' 
  ), #add the vertical border and nudge the text down a bit
  column(3,
         " "
  ),
  column(3,
         " "
  )),
  hr(style = "border-top: 1px solid #000000;"),
  #############--At Sea Applications--##########################################
  h4("At Sea Applications", style = 'font-weight: bold;'),
  br(),
  fluidRow(
    column(3,
           img(src='daily_report_maker_image.jpg', height="80%", width="80%", 
               style="display: block; margin-left: auto; margin-right: auto; border: solid 2px black;")
    ),
    column(3,
           "It will be best to run the EPM Daily Report Maker locally while at sea.
           Please get this installed locally on your machine. If you don't know
           who to ask, I'm not sure how you got to this page.",
           style='border-right: 2px solid #3c3769; padding:60px'
    ),
    column(3,
           img(src='hydrocarbon_image.jpg', height="80%", width="80%", 
               style="display: block; margin-left: auto; margin-right: auto;border: solid 2px black;")
    ),
    column(3,
           tags$a(href="http://shinylaurel.com/shiny/JRhydrocarbon/", 
                  "Hydrocarbon Safety Monitoring:",
                  style = 'font-weight: bold; font-size: 15px',
                  target="_blank"),
           h5("This application provides two sub-applications to assist with
              hydrocarbon safety monitoring. One assists in the construction of
              a thermal gradient. The other provides a graphic summary of 
              hydrocarbon and temperature data, with guides for anomalous and
              normal measurements. This application is not a replacement for 
              geochemical knowledge or approval from appropriate drilling panels.
              This application will also work better at sea if run locally."),
           tags$a(href="http://shinylaurel.com/shiny/JRhydrocarbon/", 
                  "Visit the application page.",
                  style = 'font-style: italic;',
                  target="_blank"),
           style= 'padding:5px'
    )),
  hr(style = "border-top: 1px solid #000000;"),
  #############--Post Expedition Applications--##########################################
  h4("Post-Expedition Applications", style = 'font-weight: bold;'),
  br(),
  fluidRow(
    column(3,
           img(src='coming_soon.png', height="60%", width="60%", 
               style="display: block; margin-left: auto; margin-right: auto;")
    ),
    column(3,
           "The 'cm-by-cm' tool: Convert section summaries to tables with rows
           cm-by-cm. Add in splice and alternate depth scale information as desired. ",
           tags$a(href="https://web.iodp.tamu.edu/LORE/", 
                  "Visit the application page.",
                  style = 'font-style: italic;',
                  target="_blank"),
           style='border-right: 2px solid #3c3769; padding:50px'
    ),
    column(3,
           " "
    ),
    column(3,
           " "
    )),
  hr(style = "border-top: 1px solid #000000;"),
  #############--GCR Applications--##########################################
  h4("GCR Applications", style = 'font-weight: bold;'),
  br(),
  fluidRow(
    column(3,
           img(src='GCR_app_image.jpg', height="100%", width="100%", 
               style="display: block; margin-left: auto; margin-right: auto; border: solid 2px black;")
    ),
    column(3,
           tags$a(href="https://web.iodp.tamu.edu/LORE/", 
                  "GCR Sample Planning:",
                  style = 'font-weight: bold; font-size: 15px',
                  target="_blank"),
           h5("This application provides several tools for sample planning
              purposes. (1) The user provides, singularly or in batch, sample
              requests by 'mbsf' scale (m CSF-A) and the application returns a
              samples list with appropriate sample IDs. (2) The user supplies a
              range of cores and sample interval and the application returns a 
              sample list of repetitive sampling. (3) The user provides a density
              and either a volume or mass and the alternative is returned."),
           tags$a(href="https://web.iodp.tamu.edu/LORE/", 
                  "Visit the application page.",
                  style = 'font-style: italic;',
                  target="_blank"),
           style='border-right: 2px solid #3c3769; padding:5px'
    ),
    column(3,
           " "
    ),
    column(3,
           " "
    )),
  br(),
  tags$i("These are not official IODP-JRSO applications and functionality is 
         not guaranteed. User assumes all risk.") #italic disclaimer
)

server <- function(input, output) {
  
}

shinyApp(ui = ui, server = server)