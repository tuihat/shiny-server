# JOIDES Resolution: The Itsy Bitsy Interval
# Features: divides all sections on a cm by cm basis
# created: 24 October 2019
# last updated: 2 December 2021
# Laurel Childress
# International Ocean Discovery Program

###############################################################################
# To facilitate the implementation of post-cruise sample parties this script 
# takes input from the user in the form of .csv data files from the LIMS
# database and produces a new section summary file where each section is split
# into cm by cm intervals.
###############################################################################

if(!require(rmarkdown)){
    install.packages("rmarkdown")
    library(rmarkdown) #rmarkdown
}

if(!require(shiny)){ #check if the package is installed and sourced
    install.packages("shiny") #if not, install the package
    library(shiny) #and source the package
}

if(!require(shinyjs)){
    install.packages("shinyjs")
    library(shinyjs) #shinyjs
}

if(!require(shinyWidgets)){
    install.packages("shinyWidgets")
    library(shinyWidgets) #fancy buttons
}

if(!require(shinybusy)){
    install.packages("shinybusy")
    library(shinybusy) #ocupado; come back later
}

# Define UI for application that draws a histogram
ui <- fluidPage(navbarPage("The Itsy Bitsy Interval", #App title
                           tabPanel("cm by cm", #Tab Title
                                    titlePanel("cm by cm intervals"),
                                    h4("Folks, this is the JRSO Core-O-Matic! It slices, it 
                                    dices in teeny, tiny splices. It makes mounds of sample 
                                    party tables in just seconds."),
                                    h5("To facilitate the implementation of post-cruise 
                                       sample parties this script takes input from the user 
                                       in the form of .csv data files from the LIMS database 
                                       and produces a new section summary file where each 
                                       section is split into cm by cm intervals."),
                                    hr(),
                                    sidebarLayout( #page layout
                                        sidebarPanel( #content of the sidebar
                                            tags$b("1. Gather the Section Summary", style = "font-size: 20px;"),
                                            br(),
                                            h5("Go to the LIMS Online Report Portal:"),
                                            tags$a(href="https://web.iodp.tamu.edu/LORE/", 
                                                   "https://web.iodp.tamu.edu/LORE/"),
                                            h5("Select report, Summaries -> Section Summary and pick your expedition."), 
                                            h5("Click 'View data' and a table will appear."),
                                            h5("Click 'Download tabular data' and save the csv file."),
                                            br(),
                                            tags$b("2. Upload the .csv file.", style = "font-size: 20px;"),
                                            fileInput("file1", "",#user file upload
                                                      accept = c( 
                                                          "text/csv",
                                                          "text/comma-separated-values,text/plain",
                                                          ".csv")),
                                            tags$b("3. Process the uploaded data.", style = "font-size: 20px;"),
                                            br(),
                                            actionButton("goButton1", "Process my sections!",
                                                         style="color: #000; background-color: #edf8b1; border-color: #2e6da4"),
                                            width = 3
                                            ),
                                        mainPanel(downloadButton("download1.1", "Download the entire 
                                                                 expedition as a single file",
                                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                  downloadButton("download1.2", "Download a zip file
                                                                 containing a file for each site",
                                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                  h5("This is a preview of your new file. Click
                                                     download (above) to get the file."),
                                                  h5("The first 18 columns are from the original section summary. The final
                                                     three columns are the newly derived cm-by-cm data."),
                                                  DT::dataTableOutput("data_preview1"),)
                                        ),
                                    tags$i("This is not an official IODP-JRSO application and
                                       functionality is not guaranteed. User assumes all risk.")),
                           
                           tabPanel("Name of second tab.",
                                    titlePanel("The second tab."),
                                    sidebarLayout(
                                        sidebarPanel(
                                            h5("Some sidebar instructions.")),
                                        mainPanel(br())
                                    )),
                           tabPanel("Name of third tab.",
                                    titlePanel("The third tab."),
                                    sidebarLayout(
                                        sidebarPanel(
                                            h5("Some sidebar instructions.")),
                                        mainPanel(br())
                                    )))

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
####APPLICATION 1 - cm by cm ###################################################    
    #################################################
    ####PREPARE DATA####
    data_prep1 <- eventReactive(input$goButton1, { #when user clicks Go Button
        show_modal_progress_line(text = "Please be patient - higher recovery expeditions may take more time.") # show the modal window
        file1 <- input$file1 # get user section summary file
        req(file1) #section summary file is required for operation
        #read in section summary file from user chosen location
        section_summary <- read.csv(file = file1$datapath, stringsAsFactors = FALSE)
        #Remove final row of pre-totaled information
        section_summary <- head(section_summary, -1)
        #Number of columns original to a LIMS site summary
        LORE_cols <- ncol(section_summary)
        update_modal_progress(0.1) # update progress bar value
        #Add a section ID to uniquely identify each section
        section_summary$ID_Section <- paste0(section_summary$Site,section_summary$Hole,"-",section_summary$Core, section_summary$Type,"-", section_summary$Sect)
        section_summary$ID_SiteHole <- paste0(section_summary$Site,section_summary$Hole)
        section_summary$ID_SiteHoleCore <- paste0(section_summary$Site,section_summary$Hole,"-",section_summary$Core)
        #Create a column of curated length in centimeters
        section_summary$cm_length <- section_summary$Curated.length..m.*100
        update_modal_progress(0.65) # update progress bar value
        ####PROCESS DATA####
        #Use the length of curated cm to determine how many times to duplicate each row
        subsection_summary <- section_summary[rep(seq(nrow(section_summary)), section_summary$cm_length),]
        #section_summary <- rep(section_summary, each = section_summary$cm_length)
        
        thelist <- list() #make an empty list
        for(i in unique(subsection_summary$ID_Section)){ #step through the BIG dataframe by section
            df_obj <- subset(subsection_summary, ID_Section == i) #make each set of section rows a dataframe
            df_obj$top_cm <- 0:(nrow(df_obj)-1) #add a column for the top cm measurement in section
            df_obj$bottom_cm <- 1:nrow(df_obj) #add a column for the bottom cm measurement in section
            thelist[[i]] <- df_obj #store the section-based dataframe to a list
        }
        update_modal_progress(0.8) # update progress bar value
        #Smash all the section-based dataframes together
        summary_all_subsections <- do.call("rbind", thelist)
        #Make sure the newly generated bottom column is type 'numeric'
        summary_all_subsections$bottom_cm <- as.numeric(summary_all_subsections$bottom_cm)
        #Add a column for the CSF-A depths based on your new top cm intervals
        summary_all_subsections$Top_CSF_A_m <- summary_all_subsections$Top.depth.CSF.A..m. + (summary_all_subsections$top_cm/100)
        #Clean it all up
        summary_all_subsections$Sample_ID <- paste0(section_summary$Site,
                                                    section_summary$Hole,"-",
                                                    section_summary$Core, 
                                                    section_summary$Type,"-", 
                                                    section_summary$Sect,"-",
                                                    summary_all_subsections$top_cm)
        remove_modal_progress() # remove it when done
        summary_all_subsections
        #################################################
    })#end of eventReactive goButton1
    #################################################
    #################################################
    ####MAKE IT SMALLER SO YOUR COMPUTER DOESN'T BLOWUP####
    site_hole_list <- reactive({ #Break apart by Site-Hole
        list()
        for(i in unique(data_prep1()$ID_SiteHole)){
        site_hole <- subset(data_prep1(), ID_SiteHole == i)
        site_hole_list[[i]] <- site_hole
        }
    site_hole_list
    })
    #################################################
    output$download1.1 <- downloadHandler( # Downloadable csv (single file) ----
        filename = function() {
            paste("cm_by_cm", ".csv", sep = "")
        },
        content = function(file) {
            write.csv(data_prep1(), file, row.names = FALSE)
        })
    #################################################
    output$download1.2 <- downloadHandler( # Downloadable zip (by hole) ----
            filename = 'pdfs.zip',
            content = function(fname) {
            fs <- c()
            tmpdir <- tempdir()
            setwd(tempdir())
           print (tempdir())
                                               
           for (i in 1:length(site_hole_list)) {
            path <- paste("plot_", i, ".csv", sep="")
            fs <- c(fs, path)
            write.csv(site_hole_list[[i]], fname, row.names = FALSE)
            }
            print (fs)
            zip(zipfile="pdfs.zip", files=fs)
            },
            contentType = "application/zip"
    )
    #################################################
    ##Preview data to user##
    output$data_preview1 <- DT::renderDataTable({
        pretty_table <- data_prep1()
        pretty_table <- pretty_table[,c(1:18,23, 24, 25)]
        names(pretty_table)[7] <- "Recovered length (m)"
        names(pretty_table)[8] <- "Curated length (m)"
        names(pretty_table)[9] <- "Top depth (CSF-A m)"
        names(pretty_table)[10] <- "Bottom depth (CSF-A m)"
        names(pretty_table)[11] <- "Top depth (CSF-B m)"
        names(pretty_table)[12] <- "Bottom depth (CSF-B m)"
        names(pretty_table)[13] <- "Text ID, Section"
        names(pretty_table)[14] <- "Text ID, Archive half"
        names(pretty_table)[15] <- "Text ID, Working half"
        names(pretty_table)[16] <- "# catwalk samples"
        names(pretty_table)[17] <- "# section half samples"
        names(pretty_table)[18] <- "Comment"
        names(pretty_table)[19] <- "Top (cm)"
        names(pretty_table)[20] <- "Bottom (cm)"
        names(pretty_table)[21] <- "Top depth-cm (CSF-A m)"
        DT::datatable(pretty_table, rownames= FALSE, options = list(pageLength = 5, 
                                                     language = list(
                                                         zeroRecords = "Select single depth request values for Expedition, Site, Hole, and mbsf.")))
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
