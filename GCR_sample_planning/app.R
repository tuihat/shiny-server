#GCR Sample Planning Applications
#started: 23 January 2021
#updated: 7 December 2021
#Laurel Childress; childress@iodp.tamu.edu

###############################################################################
# This application provides several tools for sample planning
# purposes. (1) The user provides, singularly or in batch, sample
# requests by 'mbsf' scale (m CSF-A) and the application returns a
# samples list with appropriate sample IDs. (2) The user supplies a
# range of cores and sample interval and the application returns a 
# sample list of repetitive sampling. (3) The user provides a density
# and either a volume or mass and the alternative is returned.
###############################################################################

if(!require(dplyr)){
    install.packages("dplyr")
    library(dplyr) #pipes
}

if(!require(shiny)){
    install.packages("shiny")
    library(shiny) #shiny
}


if(!require(shinyjs)){
    install.packages("shinyjs")
    library(shinyjs) #shinyjs
}
###############################################################################
#Data needed for App1 and App2
#read in DSDP, ODP, and IODP files - separated only due to GitHub file size 
#...upload limit. Can be combined locally.
import_DSDP <- read.csv("Section Summary_DSDP.csv", stringsAsFactors = FALSE)
import_ODP <- read.csv("Section Summary_ODP.csv", stringsAsFactors = FALSE)
import_IODP <- read.csv("Section Summary_IODP.csv", stringsAsFactors = FALSE)
section_summary <- do.call("rbind", list(import_DSDP, import_ODP, import_IODP))
section_summary$Hole[section_summary$Hole == "*"] <- "NONE"
###############################################################################
#user interface appearance and assets
ui <- fluidPage(useShinyjs(), #to use shinyjs
                navbarPage("GCR Sample Planning Apps", #title of the whole app
                           tabPanel("SampleID from Depth Value", #App 1
                                    h3("Single Sample"), #single sample mbsf feature
                                    h6("Use this tool for manual entry of a single depth request."),
                                    br(),
                                    fluidRow( #get user input of Exp, Site, Hole, mbsf
                                        column(2,
                                            selectInput('var1', 'Expedition', choices = c("choose Expedition first" = "", unique(section_summary$Exp))),
                                            selectInput('var2', 'Site', 'placeholder1'),
                                            selectInput('var3', 'Hole', 'placeholder2'),
                                            textInput("depth", "Enter mbsf (CSF-A m):")
                                        ),
                                        column(10, #return result to user
                                                  h2("The sample ID is:"),
                                                  br(),
                                                  textOutput("testing2"), #sample ID output
                                                  tags$head(tags$style(HTML("#testing2 {font-size: 30px;}"))),
                                                  br(), br(),
                                                  h4("The LORE Section Summary row is shown here for convenience."),
                                                  DT::dataTableOutput("results") #display the results
                                                  )),
                                    hr(),
                                    h3("Batch Processing"), #allow user to batch process
                                    h6("Use this tool to process multiple depth requests."),
                                    br(),
                                    h6("1. Download the template and enter data for all columns."),
                                      fluidRow( #user must comply with template use
                                          column(2,
                                               downloadButton("downloadtemplate1", "Download samples template", style='padding:4px; font-size:80%'),
                                               br(),
                                               hr(), #user enters data then uploads template
                                               h6("2. Upload the template after data entry. Keep the file in .csv format."),
                                               fileInput("file", "Upload your file",
                                                         accept = c(
                                                             "text/csv",
                                                             "text/comma-separated-values,text/plain",
                                                             ".csv")),
                                               #same as above but for a batch; user can download table
                                               h6("3. Process the uploaded data."),
                                               actionButton("goButton1", "Make my list!"),
                                               br(), br(),
                                               h6("4. Download the Sample IDs for uploaded depths."),
                                               downloadButton("downloadapp1", "Download the goodies!"),
                                               ),
                                          column(10,
                                                 DT::dataTableOutput("results_batch") #display the results
                                                 )), br(),
                                    tags$i("These are not official IODP-JRSO applications 
                                    and functionality is not guaranteed. User assumes all risk.")), #italic disclaimer
                           tabPanel("Repetitive Sample Intervals", #App 2
                                    tags$i("Please note that there are very few guardrails
                                          in this application. If changing values causes
                                          disruptions, refresh the app.",
                                           style = "color: red;"), br(),
                                    fluidRow(
                                      column(3, #user supplies Exp Site Hole
                                             h4("Expedition-Site-Hole"),
                                             selectInput('var11', 'Select Expedition', 
                                                         choices = c("choose Expedition first" = "", unique(section_summary$Exp))),
                                             selectInput('var22', 'Select Site', 'placeholder11'),
                                             selectInput('var33', 'Select Hole', 'placeholder22')),
                                      column(3, #user supplies interval top
                                             h4("Interval Top"),
                                             selectInput('var44', 'Select Core', 
                                                         choices = c("choose Expedition first" = "", unique(section_summary$Core))),
                                             selectInput('var55', 'Select Section', 
                                                         choices = c("choose" = "", unique(section_summary$Sect))),
                                             numericInput("range1", "Enter start cm:", value = NULL)),
                                      column(3, #user supplies interval bottom
                                             h4("Interval Bottom"),
                                             selectInput('var66', 'Select Core', 
                                                         choices = c("choose" = "", unique(section_summary$Core))),
                                             selectInput('var77', 'Select Section', 
                                                         choices = c("choose" = "", unique(section_summary$Sect))),
                                             numericInput("range2", "Enter final cm:", value = NULL)),
                                      column(3, #user supplies interval settings
                                             h4("Sample Frequency/Size"),
                                             numericInput("interval", "Enter sampling interval (cm):", value = 10),
                                             numericInput("interval2", "Enter sample length (cm):", value = 2),
                                             numericInput("interval3", "Enter sample volume (cc):", value = 20))),
                                    br(), #downloadable results for user
                                    downloadButton("downloadtable2", "Download results", style='padding:4px; font-size:80%'),
                                    h2("Table of repetitive samples at interval:"),
                                    br(), br(),
                                    DT::dataTableOutput("results2"), #display the results
                                    width = 10,
                                    tags$i("These are not official IODP-JRSO applications 
                                    and functionality is not guaranteed. User assumes all risk.")), #italic disclaimer
                           tabPanel("Volume-Mass Calculator", #App 3
                                    h2("Determine mass from volume:"),
                                    numericInput("volume1", "Enter volume (cc):", value = 20),
                                    numericInput("density1", HTML(paste0("Enter density (g/cm",tags$sup("3"),"):")), value = 1.7),
                                    textOutput("mass1"),
                                    tags$head(tags$style(HTML("#mass1 {font-size: 30px;}"))),
                                    hr(),
                                    h2("Determine volume from mass:"),
                                    numericInput("mass", "Enter mass (g):", value = 20),
                                    numericInput("density2", HTML(paste0("Enter density (g/cm",tags$sup("3"),"):")), value = 2.9),
                                    textOutput("volume2"),
                                    tags$head(tags$style(HTML("#volume2 {font-size: 30px;}"))),
                                    hr(),
                                    h4("Density references:"),
                                    h4(HTML(paste0("basalt = 2.9 g/cm",tags$sup("3")))),
                                    h4(HTML(paste0("clay = 1.7 g/cm",tags$sup("3")))), br(),
                                    tags$i("These are not official IODP-JRSO applications 
                                    and functionality is not guaranteed. User assumes all risk.") #italic disclaimer
                           )
))

server <- function(input, output, session) {
#######Application 1############################################################
  ##Limit site choices based on Expedition choice  
  observe({
        updateSelectInput(session, "var2", choices = with(section_summary, Site[Exp == input$var1])) 
    })
  ##Limit hole choices based on Site choice  
    observeEvent(input$var2, {
        column_levels <- with(section_summary, Hole[Site == input$var2])
        updateSelectInput(session, "var3", choices = column_levels)
    })

    #The central part: determines which Sample ID row is correct
    filtered <- reactive({
      #get the rows that match the Exp, Site, Hole
        the_chosen <- subset(section_summary, Exp == input$var1 & Site == input$var2 & Hole == input$var3)
      #convert to numeric values
        the_chosen$Top.depth.CSF.A..m. <- as.numeric(the_chosen$Top.depth.CSF.A..m.)
        the_chosen$Bottom.depth.CSF.A..m. <- as.numeric(the_chosen$Bottom.depth.CSF.A..m.)
      #limit our results to a Section that contains the desired mbsf
        tmp <- the_chosen %>%
            filter(Top.depth.CSF.A..m. <= as.numeric(input$depth), as.numeric(input$depth) < Bottom.depth.CSF.A..m.)
    })
    #Calculate the cm from meters
    cm <- reactive({
        winner <- filtered()
        cm_sect <- (as.numeric(input$depth) - as.numeric(winner$Top.depth.CSF.A..m.))*100
    })
    #Table output of results; not necessary but makes you feel good and see meters
    output$results <- DT::renderDataTable({ #print the table to feel successful
      pretty_table <- filtered()
      pretty_table <- pretty_table[,1:18]
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
      DT::datatable(pretty_table, options = list(pageLength = 5, 
                                                 language = list(
                                                   zeroRecords = "Select single depth request values for Expedition, Site, Hole, and mbsf.")))
    })
    #String output of desired Sample ID
    output$testing2 <- renderText({
        tmp2 <- filtered()
        paste0(tmp2$Exp,"-",tmp2$Site,tmp2$Hole,"-",tmp2$Core,tmp2$Type,"-",tmp2$Sect,", ", format(round(cm(), 2), nsmall = 2), " cm")
    }) 
    ######################BATCH#########################
    #GET the template file
    output$downloadtemplate1 <- downloadHandler(
        filename <- function() {
            paste("mbsf_transform_template", "csv", sep=".")
        },
        
        content <- function(file) {
            file.copy("mbsf_transform_template.csv", file)
        }) 
    
    yourbatch <- eventReactive(input$goButton1, {
        file1upload <- input$file
        req(file1upload)
        file1 <- read.csv(file = file1upload$datapath, stringsAsFactors = FALSE)
        
        app1_batchlist <- list()
        for(i in 1:nrow(file1)){
            df_obj <- file1[i,]
            tmp2 <- section_summary %>%
                filter(Exp == df_obj$Exp, Site == df_obj$Site, Hole == df_obj$Hole,
                       Top.depth.CSF.A..m. <= df_obj$mbsf, df_obj$mbsf < Bottom.depth.CSF.A..m.)
            tmp2$requested_mbsf <- df_obj$mbsf
            app1_batchlist[[i]] <- tmp2}
        
        #Smash all the section-based dataframes together
        batched <- do.call("rbind", app1_batchlist)
        
        batched$top_cm <- (as.numeric(batched$requested_mbsf) - as.numeric(batched$Top.depth.CSF.A..m.))*100
        batched$top_cm <- round(batched$top_cm, 2)
        batched <- batched[,c(1:6, 21, 20)]
        names(batched)[names(batched) == "top_cm"] <- "Top offset"
        names(batched)[names(batched) == "requested_mbsf"] <- "Requested mbsf"
        batched <- batched

    })
    
    #Table output of results; not necessary but makes you feel good and see meters
    output$results_batch <- DT::renderDataTable({ #print the table to feel successful
        DT::datatable(yourbatch(), options = list(pageLength = 100))
    })
    
    # Downloadable csv of batch dataset ----
    output$downloadapp1 <- downloadHandler(
        filename = function() {
            paste("batched_mbsf", ".csv", sep = "")
        },
        content = function(file) {
            write.csv(yourbatch(), file, row.names = FALSE)
        })
################################################################################
################################################################################
###Application 2###
    
    toListen <- reactive({
      list(input$var11, input$var22, input$var33)
    })
    
    toListen2 <- reactive({
      list(input$var11, input$var22, input$var33, input$var44)
    })
    
    toListen3 <- reactive({
      list(input$var11, input$var22, input$var33, input$var66)
    })
    
    observe({ #use Exp to limit Site choices
      updateSelectInput(session, "var22", choices = with(section_summary, Site[Exp == input$var11]))
      reset("range1")
      reset("range2")
    })
    
    observeEvent(input$var22, { #use Site to limit Hole choices
      column_levels <- with(section_summary, Hole[Site == input$var22])
      updateSelectInput(session, "var33", choices = column_levels)
      reset("range1")
      reset("range2")
    })
    ## limit the core and section choices for the top
    observeEvent(toListen(), { #use Site and Hole to limit Core choices
      column_levels <- with(section_summary, Core[Site == input$var22 & Hole == input$var33])
      updateSelectInput(session, "var44", choices = column_levels)
      reset("range1")
      reset("range2")
    })
    
    observeEvent(toListen2(), { #use Site and Hole and Core to limit section choices
      column_levels <- with(section_summary, Sect[Site == input$var22 & Hole == input$var33 & Core == input$var44])
      updateSelectInput(session, "var55", choices = column_levels)
      reset("range1")
      reset("range2")
    })
    ## limit the core and section choices for the bottom
    observeEvent(toListen(), { #use Site and Hole to limit Core choices
      column_levels <- with(section_summary, Core[Site == input$var22 & Hole == input$var33])
      updateSelectInput(session, "var66", choices = column_levels)
      reset("range1")
      reset("range2")
    })
    
    observeEvent(toListen3(), { #use Site and Hole and Core to limit section choices
      column_levels <- with(section_summary, Sect[Site == input$var22 & Hole == input$var33 & Core == input$var66])
      updateSelectInput(session, "var77", choices = column_levels)
      reset("range1")
      reset("range2")
    })
    
    filtered2 <- reactive({
      req(input$range1, input$range2, input$interval)
      #Add a section ID to uniquely identify each section
      section_summary$ID_Section <- paste0(section_summary$Site,section_summary$Hole,"-",section_summary$Core, section_summary$Type,"-", section_summary$Sect)
      
      rowcutoff1 <- with(section_summary, which(Exp == input$var11 & Site == input$var22 & 
                                                  Hole == input$var33 & Core == input$var44 & Sect == input$var55))
      rowcutoff2 <- with(section_summary, which(Exp == input$var11 & Site == input$var22 & 
                                                  Hole == input$var33 & Core == input$var66 & Sect == input$var77))
      chosen_interval1 <- section_summary[c(rowcutoff1:rowcutoff2),]
      
      #Create a column of curated length in centimeters
      chosen_interval1$cm_length <- chosen_interval1$Curated.length..m.*100
      #Use the length of curated cm to determine how many times to duplicate each row
      subsection_summary <- chosen_interval1[rep(seq(nrow(chosen_interval1)), chosen_interval1$cm_length),]
      
      thelist <- list() #make an empty list
      for(i in unique(subsection_summary$ID_Section)){ #step through the BIG dataframe by section
        df_obj <- subset(subsection_summary, ID_Section == i) #make each set of section rows a dataframe
        df_obj$top_cm <- 0:(nrow(df_obj)-1) #add a column for the top cm measurement in section
        df_obj$bottom_cm <- 1:nrow(df_obj) #add a column for the bottom cm measurement in section
        thelist[[i]] <- df_obj #store the section-based dataframe to a list
      }
      #Smash all the section-based dataframes together
      chosen_interval2 <- do.call("rbind", thelist)
      #Make sure the newly generated bottom column is type 'numeric'
      chosen_interval2$bottom_cm <- as.integer(chosen_interval2$bottom_cm)
      chosen_interval2 <- chosen_interval2[with(chosen_interval2, order(Core, Sect, top_cm)), ]
      row.names(chosen_interval2) <- 1:nrow(chosen_interval2)
      #chosen_interval2 <- chosen_interval2
      rowcutoff3 <- with(chosen_interval2, which(Exp == input$var11 & Site == input$var22 &
                                                   Hole == input$var33 & Core == input$var44 & Sect == input$var55 & top_cm == input$range1))
      rowcutoff4 <- with(chosen_interval2, which(Exp == input$var11 & Site == input$var22 &
                                                   Hole == input$var33 & Core == input$var66 & Sect == input$var77 & bottom_cm == input$range2))
      chosen_interval3 <- chosen_interval2[c(rowcutoff3:rowcutoff4),]
      
      final_chosen_interval <- chosen_interval3[seq(1, nrow(chosen_interval3), input$interval), ]
      
      row.names(final_chosen_interval) <- 1:nrow(final_chosen_interval)
      final_chosen_interval <- final_chosen_interval[,c(1:6,21)]
      final_chosen_interval$bottom_offset <- final_chosen_interval$top_cm + input$interval2
      final_chosen_interval$Volume <- input$interval3
      names(final_chosen_interval)[names(final_chosen_interval) == "top_cm"] <- "Top offset"
      names(final_chosen_interval)[names(final_chosen_interval) == "bottom_offset"] <- "Bottom offset"
      final_chosen_interval <- final_chosen_interval
      
      
    })
    
    # Downloadable csv of selected dataset ----
    output$downloadtable2 <- downloadHandler(
      filename = function() {
        paste("GCR_sample_interval", ".csv", sep = "")
      },
      content = function(file) {
        write.csv(filtered2(), file, row.names = FALSE)
      })
    
    #Table output of results; not necessary but makes you feel good and see meters
    output$results2 <- DT::renderDataTable({ #print the table to feel successful
      DT::datatable(filtered2(),
                    rownames = FALSE,
                    options = list(pageLength = 100,
                                   columnDefs = list(list(className = 'dt-center', targets = "_all")))
      )
    })
################################################################################
################################################################################
###Application 3###
    calc_mass <- reactive({
        mass <- input$volume1 * input$density1
    })
    #String output of desired Sample ID
    output$mass1 <- renderText({
        paste0("Mass = ", calc_mass(), " g")
    }) 
    
    calc_vol <- reactive({
        vol <- input$mass / input$density2
        vol <- signif(vol, digits = 2)
    })
    #String output of desired Sample ID
    output$volume2 <- renderText({
        paste0("Volume = ", calc_vol(), " cc")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
