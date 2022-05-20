# JOIDES Resolution: The Itsy Bitsy Interval
# Features: divides all sections on a cm by cm basis
# created: 24 October 2019
# last updated: 20 May 2022
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

if(!require(shinyFeedback)){
    install.packages("shinyFeedback")
    library(shinyFeedback) #ocupado; come back later
}

if(!require(dplyr)){
    install.packages("dplyr")
    library(dplyr) #dplyr
}

# Define UI for application that draws a histogram
ui <- fluidPage(navbarPage("The Itsy Bitsy Interval", #App title
                           tabPanel("cm by cm", #Tab Title
                                    titlePanel("cm by cm intervals"),
                                    h4("Folks, this is the Core-O-Matic! It slices, it 
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
                                        mainPanel(h4("4. After the data is processed:"),
                                                  downloadButton("download1.1", "Download the entire 
                                                                 expedition as a single file",
                                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                  downloadButton("download1.2", "Download a zip file
                                                                 containing a file for each site!",
                                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                  textOutput('text1.1'),
                                                  tags$style("#text1.1 {color:red;}"),
                                                  textOutput('text1.2'),
                                                  textOutput('text1.3'),
                                                  DT::dataTableOutput("data_preview1"))
                                        ),
                                    tags$i("This is not an official IODP-JRSO application and
                                       functionality is not guaranteed. User assumes all risk.")),
                           
                           tabPanel("sections in the splice",
                                    titlePanel("Oh, the Splices You'll See!"),
                                    h4("Folks, this is the Core-O-Matic! It slices, it 
                                    dices in teeny, tiny splices. It makes mounds of sample 
                                    party tables in just seconds."),
                                    h5("To facilitate the implementation of post-cruise 
                                       sample parties this script takes input from the user 
                                       in the form of .csv data files from the LIMS database 
                                       and produces two new section summary files that are
                                       modified versions of the splice interval table. The 
                                       first is a version of the section summary containing
                                       only sections that are in the splice. The second is a 
                                       section summary denoting whether each section is in the 
                                       splice and if so, which cm interval."),
                                    sidebarLayout(
                                        sidebarPanel(
                                            tags$b("1. Gather the Splice interval table", style = "font-size: 20px;"),
                                            br(),
                                            h5("Go to the LIMS Online Report Portal:"),
                                            tags$a(href="https://web.iodp.tamu.edu/LORE/", 
                                                   "https://web.iodp.tamu.edu/LORE/"),
                                            h5("Select report, Stratigraphic Correlation -> 
                                               Splice Interval Table and pick your expedition."), 
                                            h5("Click 'View data' and a table will appear."),
                                            h5("Click 'Download tabular data' and save the csv file."),
                                            br(),
                                            tags$b("2. Upload the .csv file.", style = "font-size: 20px;"),
                                            fileInput("file2.1", "",#user file upload
                                                      accept = c( 
                                                          "text/csv",
                                                          "text/comma-separated-values,text/plain",
                                                          ".csv")),
                                            tags$b("3. Gather the section summary with splice", style = "font-size: 20px;"),
                                            br(),
                                            h5("Go to the LIMS Online Report Portal:"),
                                            tags$a(href="https://web.iodp.tamu.edu/LORE/", 
                                                   "https://web.iodp.tamu.edu/LORE/"),
                                            h5("Select report, Summaries -> Section Summary and pick your expedition. Pick
                                               a site from your expedition that contains a splice. Under 'Additional filters'
                                               select the alternate depth scale associated with your site."), 
                                            h5("Click 'View data' and a table will appear."),
                                            h5("Click 'Download tabular data' and save the csv file."),
                                            tags$b("5. Upload the .csv file.", style = "font-size: 20px;"),
                                            fileInput("file2.2", "",#user file upload
                                                      accept = c( 
                                                          "text/csv",
                                                          "text/comma-separated-values,text/plain",
                                                          ".csv")),
                                            tags$b("7. Enter your Site name.", style = "font-size: 20px;"),
                                            "This will be used in the generation of filenames at the end 
                                                                  of this data processing.",
                                            textInput("siteName", ""),
                                            actionButton("goButton2", "Process the files",
                                                         style="color: #000; background-color: #edf8b1; border-color: #2e6da4"),
                                            width = 3),
                                        mainPanel(fluidRow(
                                                  h4("8. After the data is processed:"),
                                                  downloadButton("download2.1", "Download only sections in the splice",
                                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                                                  downloadButton("download2.2", "Download all sections with splice marked",
                                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4")),
                                        DT::dataTableOutput("data_preview2"), br(),
                                        h4("9. IF YOU PLAN TO GET A CM-BY-CM version of your splice data (next tab):"),
                                        downloadButton("download2.3", "Download assist file for cm-by-cm splice",
                                                       style="color: #fff; background-color: #337ab7; border-color: #2e6da4"))
                                    )),
                           
                           tabPanel("cm by cm - SPLICE version",
                                    titlePanel("cm by cm - SPLICE version"),
                                    h4("Folks, this is the Core-O-Matic! It slices, it 
                                    dices in teeny, tiny splices. It makes mounds of sample 
                                    party tables in just seconds."),
                                    h5("To facilitate the implementation of post-cruise 
                                       sample parties this script takes input from the user 
                                       in the form of .csv data files from the LIMS database 
                                       and generates a new file where the splice is divided
                                       in cm-by-cm intervals."),
                                    sidebarLayout(
                                        sidebarPanel(
                                            tags$b("BEFORE USING THIS TOOL: Be sure you have
                                                   stepped through all parts of the 'sections in the splice' tab.
                                                   Data files generated during that process will be used here.", style = "font-size: 20px;"),
                                            br(), br(),
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
                                            fileInput("file3.1", "",#user file upload
                                                      accept = c( 
                                                          "text/csv",
                                                          "text/comma-separated-values,text/plain",
                                                          ".csv")),
                                            br(),
                                            tags$b("3. Upload additional files.", style = "font-size: 20px;"),
                                            br(),
                                            h5("Upload the csv files generated in Step 9 of the 'sections in the splice' tab.
                                               Select all files generated in Step 9."),
                                            fileInput("file3.2", "",#user file upload
                                                      multiple = TRUE,
                                                      accept = c( 
                                                          "text/csv",
                                                          "text/comma-separated-values,text/plain",
                                                          ".csv")),
                                            actionButton("goButton3", "Let's get splicin'",
                                                         style="color: #000; background-color: #edf8b1; border-color: #2e6da4"),
                                            width = 3),
                                        mainPanel(br(), h4("4. After the data is processed:"),
                                                    downloadButton("download3.1", "Download a zip file
                                                                 containing a file for each site",
                                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4"))
                                    )))

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
####APPLICATION 1 - cm by cm ###################################################    
    #################################################
    ####PREPARE DATA####
    data_prep1 <- eventReactive(input$goButton1, { #when user clicks Go Button
        file1 <- input$file1 # get user section summary file
        req(file1) #section summary file is required for operation
        #read in section summary file from user chosen location
        show_modal_progress_line(text = "Please be patient - higher recovery expeditions may take more time.") # show the modal window
        section_summary <- read.csv(file = file1$datapath, stringsAsFactors = FALSE)
        update_modal_progress(0.15) # update progress bar value
        #Remove final row of pre-totaled information
        section_summary <- head(section_summary, -1)
        #Number of columns original to a LIMS site summary
        LORE_cols <- ncol(section_summary)
        update_modal_progress(0.25) # update progress bar value
        #Add a section ID to uniquely identify each section
        section_summary$ID_Section <- paste0(section_summary$Site,section_summary$Hole,"-",section_summary$Core, section_summary$Type,"-", section_summary$Sect)
        section_summary$ID_SiteHole <- paste0(section_summary$Site,section_summary$Hole)
        section_summary$ID_SiteHoleCore <- paste0(section_summary$Site,section_summary$Hole,"-",section_summary$Core)
        #Create a column of curated length in centimeters
        section_summary$cm_length <- section_summary$Curated.length..m.*100
        section_summary$cm_char <- as.character(section_summary$cm_length) #don't ask me why the number makes the wrong integer
        section_summary$cm_length <- as.integer(section_summary$cm_char)
        section_summary <- section_summary[1:(length(section_summary)-1)] #drop temporary column
        update_modal_progress(0.45) # update progress bar value
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
    #hide everything else until they hit GO
    observeEvent(input$goButton1,{
        output$text1.1 <- renderText({"ONLY PRESS THE DOWNLOAD BUTTON ONCE! Then wait. Our servers are
                                                     shiny but they are also tiny!"})
        output$text1.2 <- renderText({"This is a preview of your new file. Click
                                                     download (above) to get the file."})
        output$text1.3 <- renderText({"The first 18 columns are from the original section summary. The final
                                                     three columns are the newly derived cm-by-cm data."})
    })
    #################################################
    ####MAKE IT SMALLER SO YOUR COMPUTER DOESN'T BLOWUP####
    site_hole_list <- reactive({ #when user clicks Go Button
        site_hole_list <- list()
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
                           filename = function(){
                               paste0("sites.zip")
                               
                           },
                           content = function(file){
                               #go to a temp dir to avoid permission issues
                               owd <- setwd(tempdir())
                               on.exit(setwd(owd))
                               files <- NULL;
                               
                               #loop through the sheets
                               # graph_tax<-site_hole_list()
                               # graph_tax<-unlist(graph_tax)
                               for (i in names(site_hole_list())){
                                   #write each sheet to a csv file, save the name
                                   fileName <- paste(i,".csv",sep = "")
                                   write.table(site_hole_list()[[i]],fileName,sep = ',', row.names = F, col.names = T)
                                   files <- c(fileName,files)
                               }
                               #create the zip file
                               zip(file,files)
                           }
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
####APPLICATION 2 - sections in the splice##################################    
    #################################################
    ####PREPARE DATA####
    data_prep2 <- eventReactive(input$goButton2, { #when user clicks Go Button
        file2.1 <- input$file2.1 # get user section summary file
        req(file2.1) #section summary file is required for operation
        #read in section summary file from user chosen location
        file2.2 <- input$file2.2 # get user section summary file
        req(file2.2) #section summary file is required for operation
        #read in section summary file from user chosen location
        site <- input$siteName # get user section summary file
        req(site) #section summary file is required for operation
        #read in section summary file from user chosen location
        show_modal_progress_line(text = "Please be patient - higher recovery expeditions may take more time.") # show the modal window
        section_summary <- read.csv(file = file2.2$datapath, stringsAsFactors = FALSE)
        update_modal_progress(0.15) # update progress bar value
        #Remove final row of pre-totaled information
        section_summary <- head(section_summary, -1)
        splice_summary <- read.csv(file = file2.1$datapath, stringsAsFactors = FALSE)
        ####DETERMINE SITE AND CREATE SECTION IDs####
        splice_summary_site <- subset(splice_summary, Site == site_name) # just one site
        splice_summary_site$ID <- paste0(splice_summary_site$Site, #Core ID
                                         splice_summary_site$Hole,"-",
                                         splice_summary_site$Core,
                                         splice_summary_site$Type)
        splice_summary_site$ID_top <- paste0(splice_summary_site$Site, #Top splice section ID
                                             splice_summary_site$Hole,"-",
                                             splice_summary_site$Core,
                                             splice_summary_site$Type,"-",
                                             splice_summary_site$Top.section)
        splice_summary_site$ID_bottom <- paste0(splice_summary_site$Site, #Bottom splice section ID
                                                splice_summary_site$Hole,"-",
                                                splice_summary_site$Core,
                                                splice_summary_site$Type,"-",
                                                splice_summary_site$Bottom.section)
        section_summary$ID <- paste0(section_summary$Site, #Master section ID
                                     section_summary$Hole,"-",
                                     section_summary$Core,
                                     section_summary$Type,"-",
                                     section_summary$Sect)
        update_modal_progress(0.25) # update progress bar value
        ####GATHER SECTION IDs FROM SPLICE INTERVALS####
        section_select <- c() #empty vector to fill
        for(i in 1:nrow(splice_summary_site)){ #loop through each splice interval
            top_sect <- splice_summary_site$Top.section[i] #get the top section
            bot_sect <- splice_summary_site$Bottom.section[i] #get the bottom section
            sect_range <- top_sect:bot_sect #determine all sections in interval
            for(j in seq_along(sect_range)){ #loop through sections in interval
                section_select <- append(section_select, #concatenate Core ID and sections
                                         paste0(splice_summary_site$ID[[i]],"-",sect_range[j]))
            }
        }
        update_modal_progress(0.8) # update progress bar value
        ####IDENTIFY SPLICE SECTIONS IN SECTION SUMMARY####
        section_summary$sect_cm_length <- section_summary$Curated.length..m.*100
        section_summary$in_splice <- NA #empty column for later
        #check if Section ID is from the splice and mark it
        section_summary$in_splice <- ifelse(section_summary$ID %in% section_select,"yes", NA)
        #for everything not in the splice, make it 'no'
        #this was an afterthought...should combine with above instead of NA
        section_summary$in_splice[is.na(section_summary$in_splice)] <- c("no")
        #Gather the section that defines the top of each splice interval, and the matching
        #...top cm offset for that section within the splice interval.
        top_intervals <- splice_summary_site[,c("ID_top","Top.offset..cm.")]
        #Add this splice top offset cm to the section summary, using the section ID to
        #...place the data in the appropriate row. NAs will be added for all other rows.
        section_summary <- left_join(section_summary, top_intervals,by = c("ID" = "ID_top"))
        #Gather the section that defines the bottom of each splice interval, and the matching
        #...bottom cm offset for that section within the splice interval.
        bottom_intervals <- splice_summary_site[,c("ID_bottom","Bottom.offset..cm.")]
        #Add this splice bottom offset cm to the section summary, using the section ID to
        #...place the data in the appropriate row. NAs will exist for all non-splice sections.
        section_summary <- left_join(section_summary, bottom_intervals,by = c("ID" = "ID_bottom"))
        #For section intervals not included in the splice, set the top offset cm to zero
        section_summary$Top.offset..cm.[is.na(section_summary$Top.offset..cm.)] <- 0
        #For section intervals not included in the splice, set the bottom offset cm to
        #...the length of the section.
        section_summary$Bottom.offset..cm.[is.na(section_summary$Bottom.offset..cm.)] <- section_summary$sect_cm_length[is.na(section_summary$Bottom.offset..cm.)]
        remove_modal_progress() # remove it when done
        section_summary
        #################################################
    })#end of eventReactive goButton2
    
    #################################################
    ####get the SPLICE ONLY one####
    splice_only <- reactive({ #when user clicks Go Button
        section_summary <- data_prep2()
        section_summary_splice_only <- subset(section_summary, in_splice == "yes")
        section_summary_splice_only
    })
    
    #################################################
    ####get ready for the next tab####
    next_section <- reactive({ #when user clicks Go Button
        section_summary <- data_prep2()
        ##Fix the upper part of sections with intervals outside of the splice##
        unmatched_section_tops <- section_summary[section_summary$Top.offset..cm. != 0,]
        unmatched_section_tops$Bottom.offset..cm. <- unmatched_section_tops$Top.offset..cm.
        unmatched_section_tops$Top.offset..cm. <- 0
        unmatched_section_tops$in_splice <- "no"
        section_summary_inclusive <- rbind(section_summary,unmatched_section_tops)
        section_summary_inclusive <- section_summary_inclusive[order(section_summary_inclusive$ID,section_summary_inclusive$Top.offset..cm.),]
        
        ##Fix the lower part of sections with intervals out of the splice
        unmatched_section_ends <- section_summary[section_summary$sect_cm_length != section_summary$Bottom.offset..cm.,]
        unmatched_section_ends$Top.offset..cm. <- unmatched_section_ends$Bottom.offset..cm.
        unmatched_section_ends$Bottom.offset..cm. <- unmatched_section_ends$sect_cm_length
        unmatched_section_ends$in_splice <- "no"
        section_summary_inclusive <- rbind(section_summary_inclusive,unmatched_section_ends)
        section_summary_inclusive <- section_summary_inclusive[order(section_summary_inclusive$ID,section_summary_inclusive$Top.offset..cm.),]
        section_summary_inclusive
    })
    #################################################
    output$download2.1 <- downloadHandler( # Downloadable csv (single file) ----
                                           filename = function() {
                                               paste(input$siteName,"_spliceonly_sectionIDs", ".csv", sep = "")
                                           },
                                           content = function(file) {
                                               write.csv(splice_only(), file, row.names = FALSE)
                                           })
    #################################################
    output$download2.2 <- downloadHandler( # Downloadable csv (single file) ----
                                           filename = function() {
                                               paste(input$siteName,"_splice_sectionIDs", ".csv", sep = "")
                                           },
                                           content = function(file) {
                                               write.csv(data_prep2(), file, row.names = FALSE)
                                           })
    #################################################
    output$download2.3 <- downloadHandler( # Downloadable csv (single file) ----
                                           filename = function() {
                                               paste(input$siteName,"_splice_prep_cmbycm", ".csv", sep = "")
                                           },
                                           content = function(file) {
                                               write.csv(next_section(), file, row.names = FALSE)
                                           })
####APPLICATION 3 - cm by cm splice##################################    
    #################################################
    ####HANDLE UPLOAD OF MULTIPLE HELPER FILES####
    splice_import<-reactive({
        lapply(setNames(input$file3.2$datapath, make.names(gsub("*.csv$","", input$file3.2$datapath))), read.csv, header = TRUE, 
               stringsAsFactors = FALSE) #import all lithology csv files
        # rbindlist(lapply(input$file3.2$datapath, fread),
        #           use.names = TRUE, fill = TRUE)
    })
    #################################################
    ####PREPARE DATA####
    data_prep3 <- eventReactive(input$goButton3, { #when user clicks Go Button
        file3.1 <- input$file3.1 # get user section summary file
        req(file3.1) #section summary file is required for operation
        #read in section summary file from user chosen location
        file3.2 <- splice_import # get user uploaded helpfer files
        req(file3.2) #helper file is required for operation

        show_modal_progress_line(text = "Please be patient - higher recovery expeditions may take more time.") # show the modal window
        ####PREPARE DATA - STANDARD SECTION SUMMARY####
        section_summary <- read.csv(file = file3.1$datapath, stringsAsFactors = FALSE)
        #Remove final row of pre-totaled information
        section_summary <- head(section_summary, -1)
        #Number of columns original to a LIMS site summary
        LORE_cols <- ncol(section_summary)
        #Add a section ID to uniquely identify each section
        section_summary$ID_Section <- paste0(section_summary$Site,section_summary$Hole,"-",section_summary$Core, section_summary$Type,"-", section_summary$Sect)
        section_summary$ID_SiteHole <- paste0(section_summary$Site,section_summary$Hole)
        section_summary$ID_SiteHoleCore <- paste0(section_summary$Site,section_summary$Hole,"-",section_summary$Core)
        #Create a column of curated length in centimeters
        section_summary$cm_length <- section_summary$Curated.length..m.*100
        update_modal_progress(0.15) # update progress bar value
        
        ####PREPARE DATA - SPLICED SUMMARIES####
        splice_col_list <-list()
        for(i in 1:length(splice_import)){
            df_obj <- splice_import[[i]]
            df_obj$Top_depth_CCSF_m <- df_obj[,11]
            df_obj$Bottom_depth_CCSF_m <- df_obj[,12]
            splice_name <- df_obj$Site[1]
            number_cols <- ncol(df_obj)
            splice_cols <- df_obj[,c((number_cols-6):number_cols)]
            splice_col_list[[splice_name]] <- splice_cols #store the section-based dataframe to a list
        }
        #Bind those together
        all_splice <- do.call(rbind, splice_col_list)
        #Prepare rounded columns for cm interval scale
        all_splice$Top.offset..cm._round <- floor(all_splice$Top.offset..cm.)
        all_splice$Bottom.offset..cm._round <- floor(all_splice$Bottom.offset..cm.)
        all_splice$rounded_length <- all_splice$Bottom.offset..cm._round - all_splice$Top.offset..cm._round
        #################################################
       
        update_modal_progress(0.25) # update progress bar value
        
        ####PROCESS DATA - SPLICED SUMMARIES####
        #Use the length of curated cm to determine how many times to duplicate each row
        sub_all_splice <- all_splice[rep(seq(nrow(all_splice)), all_splice$rounded_length),]
        #section_summary <- rep(section_summary, each = section_summary$cm_length)
        
        thelist1 <- list() #make an empty list
        for(i in unique(sub_all_splice$ID)){ #step through the BIG dataframe by section
            df_obj1 <- subset(sub_all_splice, ID == i) #make each set of section rows a dataframe
            for(j in unique(df_obj1$Top.offset..cm._round)){
                df_obj2 <- subset(df_obj1, Top.offset..cm._round == j)
                df_obj2$splice_top_cm <- (df_obj2$Top.offset..cm._round[1]):(df_obj2$Bottom.offset..cm._round[1]-1) #add a column for the top cm measurement in section
                df_obj2$splice_bottom_cm <- df_obj2$splice_top_cm + 1 #add a column for the bottom cm measurement in section
                name_holder <- paste0(i,j)
                thelist1[[name_holder]] <- df_obj2 #store the section-based dataframe to a list
            }
        }
        summary_all_splice <- do.call("rbind", thelist1)
        summary_all_splice$Top_CCSF_A_m <- summary_all_splice$Top_depth_CCSF_m + (summary_all_splice$splice_top_cm/100)
        summary_all_splice$throwawaycm <- summary_all_splice$splice_top_cm
        
        ####PROCESS DATA - STANDARD SECTION SUMMARY####
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
        
        #Smash all the section-based dataframes together
        summary_all_subsections <- do.call("rbind", thelist)
        #Make sure the newly generated bottom column is type 'numeric'
        summary_all_subsections$bottom_cm <- as.numeric(summary_all_subsections$bottom_cm)
        #Add a column for the CSF-A depths based on your new top cm intervals
        summary_all_subsections$Top_CSF_A_m <- summary_all_subsections$Top.depth.CSF.A..m. + (summary_all_subsections$top_cm/100)
        #Add the columns of splice information
        temp_master_merge <- left_join(summary_all_subsections, summary_all_splice,by = c("ID_Section" = "ID", "top_cm" = "throwawaycm"))
        
        update_modal_progress(0.5) # update progress bar value
        
        #Clean it all up
        master_merge <- temp_master_merge[,1:LORE_cols]
        master_merge$SampleID <- paste0(master_merge$Site,master_merge$Hole,"-",
                                        master_merge$Core, master_merge$Type,"-",
                                        master_merge$Sect,"-", temp_master_merge$top_cm)
        master_merge$ID_SiteHole <- paste0(master_merge$Site,master_merge$Hole)
        master_merge$top_interval_cm <- temp_master_merge$top_cm
        master_merge$bottom_interval_cm <- temp_master_merge$bottom_cm
        master_merge$Top_CSF_A_m <- temp_master_merge$Top_CSF_A_m
        master_merge$in_splice <- temp_master_merge$in_splice
        master_merge$in_splice[is.na(master_merge$in_splice)] <- "no"
        master_merge$splice_top_interval_cm <- temp_master_merge$splice_top_cm
        master_merge$splice_bottom_interval_cm <- temp_master_merge$splice_bottom_cm
        master_merge$Top_CCSF_A_m <- temp_master_merge$Top_CCSF_A_m
        
        update_modal_progress(0.8) # update progress bar value
        
        ####MAKE IT SMALLER SO YOUR COMPUTER DOESN'T BLOWUP####
        #Break apart by Site-Hole
        site_hole_list <- list()
        for(i in unique(master_merge$ID_SiteHole)){
            site_hole <- subset(master_merge, ID_SiteHole == i)
            site_hole_cols <- as.numeric(ncol(site_hole))
            # site_hole <- site_hole[, - site_hole_cols]
            site_hole_list[[i]] <- site_hole
        }
        remove_modal_progress() # remove it when done
        #################################################
    })#end of eventReactive goButton3
    #################################################
    output$download3.1 <- downloadHandler( # Downloadable zip (by hole) ----
                               filename = function(){
                                   paste0("sites.zip")
                                   
                               },
                               content = function(file){
                                   #go to a temp dir to avoid permission issues
                                   owd <- setwd(tempdir())
                                   on.exit(setwd(owd))
                                   files <- NULL;
                                   
                                   #loop through the sheets
                                   # graph_tax<-site_hole_list()
                                   # graph_tax<-unlist(graph_tax)
                                   for (i in names(data_prep3())){
                                       #write each sheet to a csv file, save the name
                                       fileName <- paste(i,".csv",sep = "")
                                       write.table(data_prep3()[[i]],fileName,sep = ',', row.names = F, col.names = T)
                                       files <- c(fileName,files)
                                   }
                                   #create the zip file
                                   zip(file,files)
                               }
    )
    #################################################
    
}

# Run the application 
shinyApp(ui = ui, server = server)
