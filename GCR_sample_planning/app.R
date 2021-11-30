#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#

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

#Data needed for App1 and App2
section_summary <- read.csv("Section Summary_allExp.csv", stringsAsFactors = FALSE)
section_summary$Hole[section_summary$Hole == "*"] <- "NONE"
#app1batch <- read.csv("mbsf_transform_template.csv", stringsAsFactors = FALSE)

#user interface appearance and assets
ui <- fluidPage(navbarPage("GCR Sample Planning Apps",
                           tabPanel("SampleID from Depth Value", #App 1
                                    h3("Single Sample"),
                                    h6("Use this tool for manual entry of a single depth request."),
                                    br(),
                                    fluidRow(
                                        column(2,
                                            selectInput('var1', 'Expedition', choices = c("choose Expedition first" = "", unique(section_summary$Exp))),
                                            selectInput('var2', 'Site', 'placeholder1'),
                                            selectInput('var3', 'Hole', 'placeholder2'),
                                            textInput("depth", "Enter mbsf:")
                                        ),
                                        column(10,
                                                  h2("The sample ID is:"),
                                                  br(),
                                                  #span(textOutput("testing2"), style="size:10"),
                                                  textOutput("testing2"),
                                                  tags$head(tags$style(HTML("#testing2 {font-size: 30px;}"))),
                                                  br(), br(),
                                                  h4("The LORE Section Summary row is shown here for convenience."),
                                                  DT::dataTableOutput("results") #display the results
                                                  )),
                                    hr(),
                                    h3("Batch Processing"),
                                    h6("Use this tool to process multiple depth requests."),
                                    br(),
                                    h6("1. Download the template and enter data for all columns."),
                                      fluidRow(
                                          column(2,
                                               downloadButton("downloadtemplate1", "Download samples template", style='padding:4px; font-size:80%'),
                                               br(),
                                               hr(),
                                               h6("2. Upload the template after data entry. Keep the file in .csv format."),
                                               fileInput("file", "Upload your file",
                                                         accept = c(
                                                             "text/csv",
                                                             "text/comma-separated-values,text/plain",
                                                             ".csv")),
                                               #br(),
                                               h6("3. Process the uploaded data."),
                                               actionButton("goButton1", "Make my list!"),
                                               br(), br(),
                                               h6("4. Download the Sample IDs for uploaded depths."),
                                               downloadButton("downloadapp1", "Download the goodies!"),
                                               ),
                                          column(10,
                                                 DT::dataTableOutput("results_batch") #display the results
                                                 ))),
                           tabPanel("Repetitive Sample Intervals", #App 2
                                    fluidRow(
                                      column(3,
                                             h4("Expedition-Site-Hole"),
                                             selectInput('var11', 'Select Expedition', 
                                                         choices = c("choose" = "", unique(section_summary$Exp)), selected = "341"),
                                             selectInput('var22', 'Select Site', 
                                                         choices = c("choose" = "", unique(section_summary$Site)), selected = "U1417"),
                                             selectInput('var33', 'Select Hole', 
                                                         choices = c("choose" = "", unique(section_summary$Hole)), selected = "A")),
                                      column(3,
                                             h4("Interval Top"),
                                             selectInput('var44', 'Select Core', 
                                                         choices = c("choose" = "", unique(section_summary$Core)), selected = 1),
                                             selectInput('var55', 'Select Section', 
                                                         choices = c("choose" = "", unique(section_summary$Sect)), selected = "2"),
                                             numericInput("range1", "Enter start cm:", value = NULL)),
                                      column(3,
                                             h4("Interval Bottom"),
                                             selectInput('var66', 'Select Core', 
                                                         choices = c("choose" = "", unique(section_summary$Core)), selected = 2),
                                             selectInput('var77', 'Select Section', 
                                                         choices = c("choose" = "", unique(section_summary$Sect)), selected = "3"),
                                             numericInput("range2", "Enter final cm:", value = NULL)),
                                      column(3,
                                             h4("Sample Frequency/Size"),
                                             numericInput("interval", "Enter sampling interval (cm):", value = 10),
                                             numericInput("interval2", "Enter sample length (cm):", value = 2),
                                             numericInput("interval3", "Enter sample volume (cc):", value = 20))),
                                    br(),
                                    downloadButton("downloadtable2", "Download results", style='padding:4px; font-size:80%'),
                                    h2("Table of repetitive samples at interval:"),
                                    br(), br(),
                                    DT::dataTableOutput("results2"), #display the results
                                    width = 10),
                           tabPanel("Volume-Mass Calculator", #App 3
                                    h2("Determine mass from volume:"),
                                    numericInput("volume1", "Enter volume (cc):", value = 20),
                                    numericInput("density1", HTML(paste0("Enter density (g/cm",tags$sup("3"),"):")), value = 1.7),
                                    textOutput("mass1"),
                                    tags$head(tags$style(HTML("#mass1 {font-size: 30px;}"))),
                                    hr(),
                                    h2("Determine volume from mass:"),
                                    numericInput("mass", "Enter mass (mg):", value = 20),
                                    numericInput("density2", HTML(paste0("Enter density (g/cm",tags$sup("3"),"):")), value = 2.9),
                                    textOutput("volume2"),
                                    tags$head(tags$style(HTML("#volume2 {font-size: 30px;}"))),
                                    hr(),
                                    h4("Density references:"),
                                    h4(HTML(paste0("basalt = 2.9 g/cm",tags$sup("3")))),
                                    h4(HTML(paste0("clay = 1.7 g/cm",tags$sup("3"))))
                           )
))

server <- function(input, output, session) {
#######Application 1############################################################
    observe({
        updateSelectInput(session, "var2", choices = with(section_summary, Site[Exp == input$var1])) 
    })
    
    observeEvent(input$var2, {
        column_levels <- with(section_summary, Hole[Site == input$var2])
        updateSelectInput(session, "var3", choices = column_levels)
    })
    
    output$table <- renderTable({
        subset(dataset(), dataset()[[input$column]] == input$level)
    })

    #The central part: determines which Sample ID row is correct
    filtered <- reactive({
        the_chosen <- subset(section_summary, Exp == input$var1 & Site == input$var2 & Hole == input$var3)
        the_chosen$Top.depth.CSF.A..m. <- as.numeric(the_chosen$Top.depth.CSF.A..m.)
        the_chosen$Bottom.depth.CSF.A..m. <- as.numeric(the_chosen$Bottom.depth.CSF.A..m.)
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
    # Selectize 2 choice's list <---
    var22.choice <- reactive({
        section_summary %>% 
            filter(Exp == input$var11) %>%
            pull(Site)
    })
    
    # Selectize 3 choice's list <---
    var33.choice <- reactive({
        section_summary %>% 
            filter(Exp == input$var11) %>%
            filter(Site == input$var22) %>% 
            pull(Hole)
    })
    
    # Selectize 4 choice's list <---
    var44.choice <- reactive({
        section_summary %>% 
            filter(Exp == input$var11) %>%
            filter(Site == input$var22) %>%
            filter(Hole == input$var33) %>%
            pull(Core)
    })
    
    # Selectize 5 choice's list <---
    var55.choice <- reactive({
        section_summary %>% 
            filter(Exp == input$var11) %>%
            filter(Site == input$var22) %>%
            filter(Hole == input$var33) %>%
            filter(Core == input$var44) %>%
            pull(Sect)
    })
    
    # Observe <---
    observe({
        updateSelectizeInput(session, "var22", choices = var22.choice())
        updateSelectizeInput(session, "var33", choices = var33.choice())
        updateSelectizeInput(session, "var44", choices = var44.choice())
        updateSelectizeInput(session, "var55", choices = var55.choice())
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
      final_chosen_interval <- final_chosen_interval[,c(1:6,22)]
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
        paste0("Mass = ", calc_mass(), " mg")
    }) 
    
    calc_vol <- reactive({
        vol <- input$mass * input$density2
    })
    #String output of desired Sample ID
    output$volume2 <- renderText({
        paste0("Volume = ", calc_vol(), " cc")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
