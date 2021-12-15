#DSDP, ODP, IODP Expedition Map
#started: 9 December 2021
#updated: 10 December 2021
#Laurel Childress; childress@iodp.tamu.edu

###############################################################################
# A very basic map making tool for ocean drilling sites.
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

if(!require(shinyjs)){ #check if the package is installed and sourced
  install.packages("shinyjs") #if not, install the package
  library(shinyjs) #and source the package
}

if(!require(shinyWidgets)){ #check if the package is installed and sourced
  install.packages("shinyWidgets") #if not, install the package
  library(shinyWidgets) #and source the package
}

if(!require(shinydashboard)){ #check if the package is installed and sourced
  install.packages("shinydashboard") #if not, install the package
  library(shinydashboard) #and source the package
}

if(!require(shinydashboardPlus)){ #check if the package is installed and sourced
  install.packages("shinydashboardPlus") #if not, install the package
  library(shinydashboardPlus) #and source the package
}

volumes <- read.csv("sample_volume.csv")

ui <- dashboardPage(
  title = "Sample Volume Calculations", #website title
  header = dashboardHeader(title = "Easy Sample Volume Calculations"),
  sidebar = dashboardSidebar(width = "0px"),
  body = dashboardBody(
    fluidRow(
      box(width = 5,
          fluidRow(
            column(width = 6, 
                   numericInput("slen1", label = "Enter sample length(s) in cm:", value = 1,
                                min = 1, max = 150, step = 1), br(),
                   numericInput("slen2", label = NULL, value = 2,
                                min = 1, max = 150, step = 1), br(),
                   numericInput("slen3", label = NULL, value = 3,
                                min = 1, max = 150, step = 1),
                   "Use integers only, please."),
            column(width = 6,
                   selectInput("tool1", "Choose your tool:",
                               c("WRND", "SHLF", "QRND"),
                               multiple = FALSE), br(),
                   selectInput("tool2", label = NULL,
                               c("WRND", "SHLF", "QRND"),
                               multiple = FALSE), br(),
                   selectInput("tool3", label = NULL,
                               c("WRND", "SHLF", "QRND"),
                               multiple = FALSE))
          )),
      box(width = 2, 
          img(src="U4T.gif")),
      box(width = 5,
          fluidRow(
            column(width = 6, align="center",
                   tags$b("Sediment (APC, XCB) volume (cc)"),
                   textOutput('sed1'), br(), br(), br(),
                   textOutput('sed2'), br(), br(), br(),
                   textOutput('sed3')
                    ),
            column(width = 6, align="center",
                   tags$b("Rock (RCB) volume (cc)"),
                   textOutput('rcb1'),br(), br(), br(),
                   textOutput('rcb2'), br(), br(), br(),
                   textOutput('rcb3'))
          ))
    ),
    "--------------------------------------------------------------------------", br(),
    "Will add some sort of thing that is either a batch processor or if I can figure it
    out a table that you can paste into (fancy fancy).", br(),
    br(),
    tags$i("These are not official IODP-JRSO applications and functionality is 
           not guaranteed. User assumes all risk."), #italic disclaimer
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
        /* main sidebar */
        .skin-blue .main-sidebar {
                              background-color: #325669;
                              }
         .box-header{ display: none}
                           '))),
    tags$script("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';")
  )
)

server <- function(input, output, session) {
#########---Results FIRST row---####################################  
  the_first <- reactive({
    df <- subset(volumes, length_cm == as.integer(input$slen1))
    df2 <- df[grepl(input$tool1, names(df))]
    df2
  })
  
  output$sed1 <- renderText({ 
    df <- the_first()
    as.character(df[1,1]) })
  output$rcb1 <- renderText({ 
    df <- the_first()
  as.character(df[1,2]) })

#########---Results SECOND row---####################################  
  the_second <- reactive({
    df <- subset(volumes, length_cm == as.integer(input$slen2))
    df2 <- df[grepl(input$tool2, names(df))]
    df2
  })
  
  output$sed2 <- renderText({ 
    df <- the_second()
    as.character(df[1,1]) })
  output$rcb2 <- renderText({ 
    df <- the_second()
    as.character(df[1,2]) })
#########---Results SECOND row---####################################  
  the_third <- reactive({
    df <- subset(volumes, length_cm == as.integer(input$slen3))
    df2 <- df[grepl(input$tool3, names(df))]
    df2
  })
  
  output$sed3 <- renderText({ 
    df <- the_third()
    as.character(df[1,1]) })
  output$rcb3 <- renderText({ 
    df <- the_third()
    as.character(df[1,2]) })
}

shinyApp(ui = ui, server = server)