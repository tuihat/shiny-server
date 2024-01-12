#EPM Resources - Daily Report Maker
#started: 25 March 2020
#updated: 22 November 2021
#Laurel Childress; childress@iodp.tamu.edu
###############################################################################
# This application will provide a summary of information from LIMS to provide
#...numeric coring/drilling information in the Daily Report. 
# This application comes without guarantees and has been minimally tested. More
#...testing by other EPMs is encouraged. Please report any issues.

##----------------------Packages------------------------------------------------
if(!require(rmarkdown)){ #check if the package is installed and sourced
  install.packages("rmarkdown") #if not, install the package
  library(rmarkdown) #and source the package 
}

if(!require(dplyr)){ #check if the package is installed and sourced
  install.packages("dplyr") #if not, install the package
  library(dplyr) #and source the package 
}

if(!require(gtools)){ #check if the package is installed and sourced
  install.packages("gtools") #if not, install the package
  library(gtools) #and source the package 
}

if(!require(shiny)){ #check if the package is installed and sourced
  install.packages("shiny") #if not, install the package
  library(shiny) #and source the package 
}

if(!require(shinyjs)){ #check if the package is installed and sourced
  install.packages("shinyjs") #if not, install the package
  library(shinyjs) #and source the package 
}

#
##----------------------Application---------------------------------------------
tz_source <- read.csv("R_timezones.csv", stringsAsFactors = FALSE)

ui <- fluidPage(useShinyjs(),
  titlePanel("Coring Summary for EPM Daily Report"),
              h5("This application is no substitute for actual daily report writing and being diligent. 
                 Results are not guaranteed and the application has not been rigorously tested. User accepts all risk."),
              br(),
                sidebarLayout(
                  sidebarPanel(
                    #GET the date from the user
                    h3("Step 1: choose a date"),
                    h6("(usually this will be yesterday...)"),
                    dateInput("date", label = "Select date", value = "2022-02-16"),
                    hr(),
                    #GET the timezone from the user
                    h3("Step 2: choose a timezone relative to UTC"),
                    h6("(download and consult the timezone guide below if want more information)"),
                    selectInput("UTCzone", "Select UTC of JR position:",
                                unique(tz_source$UTC.offset.hh_mm), 
                                selected = "+02:00"),
                    selectInput("timezone", "Select closest match to current position:",
                                'placeholder1'), #no default
                    downloadButton("downloadtz", "Download timezone guide", style='padding:4px; font-size:80%'),
                    br(),
                    hr(),
                    #GET the LIMS file from the user
                    h3("Step 3: get LIMS data"),
                    h6("(upload the entire Core Summary for your expedition)"),
                    fileInput("file", "Choose LIMS Core Summary File",
                              accept = c(
                                "text/csv",
                                "text/comma-separated-values,text/plain",
                                ".csv")),
                    #User must initiate action after all selections
                    actionButton("goButton", "Apply uploaded dataset..."),
                    br(),
                    hr()),
                  mainPanel(hr(), #output results for user
                            textOutput("chosen_date"),
                            h4("-------------------------------------CORES-------------------------------------"),
                            br(),
                            h4("Totals of cores by hole:"),
                            tableOutput("total_cores"),
                            hr(),
                            h4("The cores on deck:"),
                            DT::dataTableOutput("COD_df"),
                            br(),
                            hr(),
                            h4("------------------------------------ADVANCE------------------------------------"),
                            br(),
                            tableOutput("advance_df"))
                ))

server <- function(input, output, session) {
##----Update TZ database from UTC input-----------------------------------------  
  observe({
    updateSelectInput(session, "timezone", choices = with(tz_source, TZ.database.name[UTC.offset.hh_mm == input$UTCzone])) 
  })
##----Apply Date & TZ to Core Summary-------------------------------------------  
  yesterday <- eventReactive(input$goButton, { #when user clicks Go Button
    
    date <- input$date #get user date input
    tzlocal1 <- input$timezone #get user timezone input
    file1 <- input$file # get user core summary file
    req(file1) #core summary file is required for operation
    #read in core summary file from user chosen location
    core_summary <- read.csv(file = file1$datapath, stringsAsFactors = FALSE)
    #set boundaries of day
    lims <- as.POSIXct(strptime(c(paste0(date," 00:00"), paste0(date," 23:59")),
                                format = "%Y-%m-%d %H:%M", tz = tzlocal1))
    
    #Setup time handling columns
    #Convert LIMS file to R readable time format
    core_summary$TimeOnDeckUTC <- as.POSIXct(strptime(core_summary$Time.on.deck.UTC.,
                                                      format = "%m/%d/%Y %H:%M", tz = "UTC"))
    #Create a placeholder for local JR time
    core_summary$TimeOnDeckJR <- as.POSIXct(strptime(core_summary$Time.on.deck.UTC.,
                                                     format = "%m/%d/%Y %H:%M", tz = "UTC"))
    #Convert UTC time to local JR time based on provided timezone
    attributes(core_summary$TimeOnDeckJR)$tzone <- tzlocal1
    
    #Use date limit to extract only those rows of data from LIMS file
    yesterday <- subset(core_summary, TimeOnDeckJR > lims[1] & TimeOnDeckJR < lims[2])
    
    #Only keep legitimate drilled cores (no ghost cores, no drilled intervals)
    yesterday <- subset(yesterday, Type == "H" | Type == "F" | Type == "X" | Type == "R")
    
    #Determine number of different holes for day
    #Create a new column, concatenating the unique Site-Hole label
    yesterday$SiteHole <- paste0(yesterday$Site, yesterday$Hole)
    
    #Repeat it so last man wins
    yesterday <- yesterday
  })
  
  holesday <- eventReactive(input$goButton, {
    #Determine the unique Site-Holes for the user defined date
    unique(yesterday()$SiteHole) 
  })
  
  holelist <- eventReactive(input$goButton, {  
    #Parse out data by holes (in case multiple in a single day)
    hole_list <- list() #make an empty list to hold the dataframes
    for(i in holesday()){ #loop through each unique Site-Hole
      df <- subset(yesterday(), SiteHole == i) #create a dataframe for each Site-Hole
      hole_list[[i]] <- assign(i, df) #make list of the dataframes
    }
    hole_list <- hole_list
  })
  
  COD <- eventReactive(input$goButton, {  
    #Subset to useful core level information
    COD <- yesterday()[,c("Site","Hole","Core","Type")]
    #Recalculate row numbers, for clarity and prettiness
    rownames(COD) <- seq(length=nrow(COD))
    COD <- COD
  })
  
  tot_cores <- eventReactive(input$goButton, { 
    #Determine total number of cores for the day
    tot_cores <- as.data.frame(lapply(holelist(), function(x) nrow(x)))
  })
  
  advance <- eventReactive(input$goButton, {
    COD <- COD()
    hole_list <- holelist()
    #DETERMINE DAILY REPORT BASICS
    #Gather needed columns
    COD$advance1 <- unlist(sapply(hole_list, `[[`, 8))
    COD$top_drill <- unlist(sapply(hole_list, `[[`, c("Top.depth.drilled.DSF..m.")))
    COD$bot_drill <- unlist(sapply(hole_list, `[[`, c("Bottom.depth.drilled.DSF..m.")))
    COD$recovery <- unlist(sapply(hole_list, `[[`, 9))
    COD$recovery_pct <- unlist(sapply(hole_list, `[[`, c("Recovery....")))
    #get rows where drilling type changes
    change_type <- as.data.frame(which(COD$Type != lag(COD$Type)))
    #make the column name better
    names(change_type)[names(change_type) == "which(COD$Type != lag(COD$Type))"] <- "change"
    #make sure to start with row 1
    change_type_df <- data.frame("change" = 1)
    #get row 1 together with the other data change point
    change_type_df <- rbind(change_type_df, change_type)
    #The last row will throw an NAN error because it lacks a row for the bottom
    #Technically that could be written in the same way "1" was with nrow() but I 
    #was tired and the second loop will handle the issue.
    valid_rows <- nrow(change_type_df) -1
    
    #Note: if only one drilling type you will see an error here, but never fear
    #The next block will handle it for you and you will still get the right answer.
    subset_list <- list()
    if(valid_rows > 0){
    for(i in 1:valid_rows){
      top_core_row <- change_type_df$change[i]
      bot_core_row <- change_type_df$change[i+1]
      bot_core_row <- bot_core_row - 1
      new_df <- COD[top_core_row:bot_core_row,]
      subset_list[[i]] <- new_df
    }}
    
    #handle the final set of core types for the day
    for(i in nrow(change_type_df)){
      top_core_row <- change_type_df$change[i]
      bot_core_row <- nrow(COD)
      new_df <- COD[top_core_row:bot_core_row,]
      subset_list[[i]] <- new_df
    }
    
    #Make the summary advance/recovery table
    advance_list <- list()
    advance_list2 <- list()
    for(i in 1:length(subset_list)){
      df1 <- subset_list[[i]]
      df1$SiteHole <- paste0(df1$Site,df1$Hole)
      for(j in unique(df1$SiteHole)){
        df <- subset(df1, SiteHole == j)
        advance_sum <- sum(df$advance1)
        recovery_sum <- sum(df$recovery)
        recovery_pct_avg <- mean(df$recovery_pct)
        df$core_type <- paste0(df$Core,df$Type)
        new_df <- data.frame("Site-Hole" = c(df$SiteHole[1]),
                             "Top Core" = c(df$core_type[1]),
                             "Bottom Core" = c(df$core_type[nrow(df)]),
                             "Advance" = c(advance_sum),
                             "From (mbsf)" = c(df$top_drill[1]),
                             "To (mbsf)" = c(df$bot_drill[nrow(df)]),
                             "Recovered (m)" = c(recovery_sum),
                             "Recovered (pct)" = c(recovery_pct_avg))
        advance_list[[j]] <- new_df
        }
        advance_summary_pre <- do.call(smartbind,advance_list)
      advance_list2[[i]] <- advance_summary_pre
    }
    
    #Concatenate advances, recovery by time-drill type
    advance_summary <- do.call(smartbind,advance_list2)
    
    names(advance_summary)[1:8] <- c("Site-Hole", "Top Core", "Bottom Core", "Advance (m)", "From (mbsf)", "To (mbsf)", "Recovered (m)", "Recovered (pct)")
    
    advance_summary <- advance_summary
  })
  
  output$chosen_date <- renderText({
    paste0("Information for ", input$date)
  })
  
  output$total_cores <- renderTable({
    tot_cores()
  })
  
  output$COD_df <- DT::renderDataTable({
    DT::datatable(COD(), options = list(pageLength = 5))
  })
  
  output$advance_df <- renderTable({
    advance()
  })

}

shinyApp(ui = ui, server = server)