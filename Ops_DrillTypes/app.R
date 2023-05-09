#Data Mining - DSDP, ODP, IODP Coring Stats; Glomar Challenger & JR
#started:  25 March 2020
#updated: 13 October 2022
#Laurel Childress; childress@iodp.tamu.edu

library(ggplot2)
library(dplyr)
library(shiny)
library(cowplot)
library(shinyWidgets)

exp_stats <- read.csv("DSDP-ODP-IODP_core_summaries_HLAPCcorrected.csv", stringsAsFactors = FALSE)
#######EXP LIST ORDERFOR USE BELOW#############################################
all_exp <- c("1","2","3","4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "100", "101", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "301", "303", "304", "305", "306", "307", "308", "309", "311", "312", "320T", "320", "321", "323", "324", "317", "318", "327", "328", "329", "330", "334", "335", "336", "339", "340T", "340", "342", "344", "345", "341", "346", "349", "350", "351", "352", "353", "354", "355", "356", "359", "360", "361", "362T", "362", "363", "366", "367", "368", "371", "369", "372", "374", "375", "376", "368X", "379", "382", "383", "379T", "385", "378", "384", "390C", "395E", "395C", "396","391","392", "390", "393")
DSDP_only <- c("1","2","3","4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96")
JOIDES_only <- c("100", "101", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "301", "303", "304", "305", "306", "307", "308", "309", "311", "312", "317", "318", "320", "320T", "321", "323", "324", "327", "328", "329", "330", "334", "335", "336", "339", "340", "340T", "341", "342", "344", "345", "346", "349", "350", "351", "352", "353", "354", "355", "356", "359", "360", "361", "362", "362T", "363", "366", "367", "368", "368X", "369", "371", "372", "374", "375", "376", "378", "379", "379T", "382", "383", "384", "385", "390C", "395C", "395E", "396","391","392", "390", "393")
ODP <- c("100", "101", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210")
IODP_1 <- c("301", "303", "304", "305", "306", "307", "308", "309", "311", "312", "320T", "320", "321", "323", "324", "317", "318", "327", "328", "329", "330", "334", "335", "336", "339", "340T", "340", "342", "344", "345", "341", "346")
IODP_2 <- c("349", "350", "351", "352", "353", "354", "355", "356", "359", "360", "361", "362T", "362", "363", "366", "367", "368", "371", "369", "372", "374", "375", "376", "368X", "379", "382", "383", "379T", "385", "378", "384", "390C", "395E", "395C", "396","391","392", "390", "393")

###############################################################################

#height: 900px; ##IN CASE YOU WANT THIS BACK LATER IN THE HTML FOR THE SIDEBAR!
ui <- fluidPage(tags$head(tags$style(HTML("
                                 .multicol { 
                                   
                                   -webkit-column-count: 10; /* Chrome, Safari, Opera */ 
                                   -moz-column-count: 10;    /* Firefox */ 
                                   column-count: 10; 
                                   -moz-column-fill: auto;
                                   -column-fill: auto;
                                 } 
                                 "))),
                titlePanel("DSDP, ODP, IODP Coring Type Stats"),
                sidebarLayout(
                  sidebarPanel(
                    fluidRow(
                      splitLayout(cellWidths = c("18%", "18%", "20%", "20%", "15%"), align="center",
                                  switchInput(inputId = "DSDPswitch", label = "DSDP", value = TRUE),
                                  switchInput(inputId = "ODPswitch", label = "ODP", value = TRUE),
                                  switchInput(inputId = "IODP1switch", label = "IODP-1", value = TRUE, handleWidth = 50),
                                  switchInput(inputId = "IODP2switch", label = "IODP-2", value = TRUE, handleWidth = 50),
                                  actionButton("selectall", label="All/None"))),
                    br(),
                    h6("DSDP"),
                    tags$div(align = 'left', 
                             class = 'multicol',
                    checkboxGroupInput(inputId = "checkDSDPInput", label = NULL, inline = FALSE,
                                       choices = DSDP_only, 
                                       selected = DSDP_only)),
                    br(),
                    h6("ODP"),
                    tags$div(align = 'left', 
                             class = 'multicol',
                             checkboxGroupInput(inputId = "checkODPInput", label = NULL, inline = FALSE,
                                                choices = ODP, 
                                                selected = ODP)),
                    br(),
                    h6("IODP (Integrated Ocean Drilling Program)"),
                    tags$div(align = 'left', 
                             class = 'multicol',
                             checkboxGroupInput(inputId = "checkIODP1Input", label = NULL, inline = FALSE,
                                                choices = IODP_1, 
                                                selected = IODP_1)),
                    br(),
                    h6("IODP (International Ocean Discovery Program)"),
                    tags$div(align = 'left', 
                             class = 'multicol',
                             checkboxGroupInput(inputId = "checkIODP2Input", label = NULL, inline = FALSE,
                                                choices = IODP_2, 
                                                selected = IODP_2)),
                    width = 4),
                  mainPanel(tabsetPanel(type = "tabs",
                                        tabPanel("% Recovery Counts",
                                                 radioButtons("scaled1", "", 
                                                              list("Scaled","Unscaled"), inline = TRUE, selected = "Scaled"),
                                                 conditionalPanel(
                                                   condition = "input.scaled1 == 'Scaled'", plotOutput("recoveryPlot1S", width = 1400, height = 900)),
                                                 conditionalPanel(
                                                   condition = "input.scaled1 == 'Unscaled'", plotOutput("recoveryPlot1U", width = 1400, height = 900))),
                                        tabPanel("% Recovery Counts - Program",
                                                 radioButtons("scaled2", "", 
                                                              list("Scaled","Unscaled"), inline = TRUE, selected = "Scaled"),
                                                 conditionalPanel(
                                                   condition = "input.scaled2 == 'Scaled'", plotOutput("recoveryPlotProgram2S", width = 1400, height = 900)),
                                                 conditionalPanel(
                                                   condition = "input.scaled2 == 'Unscaled'", plotOutput("recoveryPlotProgram2U", width = 1400, height = 900))),
                                        tabPanel("% Recovery Counts - Expedition",
                                                 h5("Note: graph only displays when 10 or fewer expeditions are selected."),
                                                 radioButtons("scaled3", "", 
                                                              list("Scaled","Unscaled"), inline = TRUE, selected = "Scaled"),
                                                 conditionalPanel(
                                                   condition = "input.scaled3 == 'Scaled'", plotOutput("recoveryPlotExp3S", width = 1400, height = 900)),
                                                 conditionalPanel(
                                                   condition = "input.scaled3 == 'Unscaled'", plotOutput("recoveryPlotExp3U", width = 1400, height = 900))),
                                                 #plotOutput("recoveryPlotExpedition", width = 1400, height = 950)),
                                        tabPanel("Depth and Recovery",
                                                 plotOutput("depthPlot", width = 1400, height = 800)),
                                        tabPanel("Depth and Recovery - Program",
                                                 plotOutput("depthPlotProgram", width = 1400, height = 800)),
                                        tabPanel("Depth and Recovery - Expedition",
                                                 h5("Note: graph only displays when 10 or fewer expeditions are selected."),
                                                 plotOutput("depthPlotExp", width = 1400, height = 800))))
                ),
                tags$i("These are not official IODP-JRSO applications and functionality is 
         not guaranteed. User assumes all risk.") #italic disclaimer
                )

server <- function(input, output, session) {
  ########REACTIVE SEARCHED DATAFRAME#############################################
  chosen_exps <- reactive({
    df1 <- exp_stats[exp_stats$Exp %in% input$checkDSDPInput,]
    df2 <- exp_stats[exp_stats$Exp %in% input$checkODPInput,]
    df3 <- exp_stats[exp_stats$Exp %in% input$checkIODP1Input,]
    df4 <- exp_stats[exp_stats$Exp %in% input$checkIODP2Input,]
    last <- do.call("rbind", list(df1, df2, df3, df4))
  })
  ########OBSERVE USER SEARCH CHANGES####################################
  observeEvent(input$DSDPswitch, {
    if(input$DSDPswitch == "TRUE"){
      updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
                               choices = DSDP_only,
                               selected = DSDP_only)
    }else{}
  })
    
    observeEvent(input$DSDPswitch, {
      if(input$DSDPswitch == "FALSE"){
        updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
                                 choices = DSDP_only,
                                 selected = c())
      }else{}
    
  })
    observeEvent(input$ODPswitch, {
      if(input$ODPswitch == "TRUE"){
        updateCheckboxGroupInput(session=session, inputId="checkODPInput",
                                 choices = ODP,
                                 selected = ODP)
      }else{}
    })
    
    observeEvent(input$ODPswitch, {
      if(input$ODPswitch == "FALSE"){
        updateCheckboxGroupInput(session=session, inputId="checkODPInput",
                                 choices = ODP,
                                 selected = c())
      }else{}
      
    })
    observeEvent(input$IODP1switch, {
      if(input$IODP1switch == "TRUE"){
        updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
                                 choices = IODP_1,
                                 selected = IODP_1)
      }else{}
    })
    
    observeEvent(input$IODP1switch, {
      if(input$IODP1switch == "FALSE"){
        updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
                                 choices = IODP_1,
                                 selected = c())
      }else{}
      
    })
    observeEvent(input$IODP2switch, {
      if(input$IODP2switch == "TRUE"){
        updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
                                 choices = IODP_2,
                                 selected = IODP_2)
      }else{}
    })
    
    observeEvent(input$IODP2switch, {
      if(input$IODP2switch == "FALSE"){
        updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
                                 choices = IODP_2,
                                 selected = c())
      }else{}
      
    })
  observe({
    if (input$selectall > 0) {
      if (input$selectall %% 2 == 0){
        updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
                                 choices = DSDP_only,
                                 selected = DSDP_only)
        updateCheckboxGroupInput(session=session, inputId="checkODPInput",
                                 choices = ODP,
                                 selected = ODP)
        updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
                                 choices = IODP_1,
                                 selected = IODP_1)
        updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
                                 choices = IODP_2,
                                 selected = IODP_2)
        updateSwitchInput(session = session, inputId = "DSDPswitch", value = TRUE)
        updateSwitchInput(session = session, inputId = "ODPswitch", value = TRUE)
        updateSwitchInput(session = session, inputId = "IODP1switch", value = TRUE)
        updateSwitchInput(session = session, inputId = "IODP2switch", value = TRUE)
      }
      else {
        updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
                                 choices = DSDP_only,
                                 selected = c())
        updateCheckboxGroupInput(session=session, inputId="checkODPInput",
                                 choices = ODP,
                                 selected = c())
        updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
                                 choices = IODP_1,
                                 selected = c())
        updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
                                 choices = IODP_2,
                                 selected = c())
        updateSwitchInput(session = session, inputId = "DSDPswitch", value = FALSE)
        updateSwitchInput(session = session, inputId = "ODPswitch", value = FALSE)
        updateSwitchInput(session = session, inputId = "IODP1switch", value = FALSE)
        updateSwitchInput(session = session, inputId = "IODP2switch", value = FALSE)
      }}
  })
  
  ##DSDP
  # observe({
  #   if (input$selectDSDP > 0) {
  #     if (input$selectDSDP %% 2 == 0){
  #       updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
  #                                choices = DSDP_only,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkODPInput",
  #                                choices = ODP,
  #                                selected = ODP)
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
  #                                choices = IODP_1,
  #                                selected = IODP_1)
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
  #                                choices = IODP_2,
  #                                selected = IODP_2)
  #     }
  #     else {
  #       updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
  #                                choices = DSDP_only,
  #                                selected = DSDP_only)
  #       updateCheckboxGroupInput(session=session, inputId="checkODPInput",
  #                                choices = ODP,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
  #                                choices = IODP_1,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
  #                                choices = IODP_2,
  #                                selected = c())
  #     }}
  # })
  # 
  # ##ODP
  # observe({
  #   if (input$selectODP > 0) {
  #     if (input$selectODP %% 2 == 0){
  #       updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
  #                                choices = DSDP_only,
  #                                selected = DSDP_only)
  #       updateCheckboxGroupInput(session=session, inputId="checkODPInput",
  #                                choices = ODP,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
  #                                choices = IODP_1,
  #                                selected = IODP_1)
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
  #                                choices = IODP_2,
  #                                selected = IODP_2)
  #     }
  #     else {
  #       updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
  #                                choices = DSDP_only,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkODPInput",
  #                                choices = ODP,
  #                                selected = ODP)
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
  #                                choices = IODP_1,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
  #                                choices = IODP_2,
  #                                selected = c())
  #     }}
  # })
  # 
  # ##IODP-1
  # observe({
  #   if (input$selectIODP1 > 0) {
  #     if (input$selectIODP1 %% 2 == 0){
  #       updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
  #                                choices = DSDP_only,
  #                                selected = DSDP_only)
  #       updateCheckboxGroupInput(session=session, inputId="checkODPInput",
  #                                choices = ODP,
  #                                selected = ODP)
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
  #                                choices = IODP_1,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
  #                                choices = IODP_2,
  #                                selected = IODP_2)
  #     }
  #     else {
  #       updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
  #                                choices = DSDP_only,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkODPInput",
  #                                choices = ODP,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
  #                                choices = IODP_1,
  #                                selected = IODP_1)
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
  #                                choices = IODP_2,
  #                                selected = c())
  #     }}
  # })
  # 
  # ##IODP-2
  # observe({
  #   if (input$selectIODP2 > 0) {
  #     if (input$selectIODP2 %% 2 == 0){
  #       updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
  #                                choices = DSDP_only,
  #                                selected = DSDP_only)
  #       updateCheckboxGroupInput(session=session, inputId="checkODPInput",
  #                                choices = ODP,
  #                                selected = ODP)
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
  #                                choices = IODP_1,
  #                                selected = IODP_1)
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
  #                                choices = IODP_2,
  #                                selected = c())
  #     }
  #     else {
  #       updateCheckboxGroupInput(session=session, inputId="checkDSDPInput",
  #                                choices = DSDP_only,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkODPInput",
  #                                choices = ODP,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP1Input",
  #                                choices = IODP_1,
  #                                selected = c())
  #       updateCheckboxGroupInput(session=session, inputId="checkIODP2Input",
  #                                choices = IODP_2,
  #                                selected = IODP_2)
  #     }}
  # })
  ########TAB1 - RECOVERY PLOTS - UNSCALED######################################
  output$recoveryPlot1U <- renderPlot({
    APC1 <- chosen_exps()
    APC1 <- subset(APC1, Expanded_Core_Type == "APC")
    t2_p1 <- ggplot() +
      geom_histogram(data = APC1,
                     aes(x = Recovery....),
                     binwidth = 2, fill = "mediumturquoise", color = "gray40") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("APC; n = ", nrow(APC1))) +
      theme(axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    HLAPC1 <- chosen_exps()
    HLAPC1 <- subset(HLAPC1, Expanded_Core_Type == "HLAPC")
    t2_p2 <- ggplot() +
      geom_histogram(data = HLAPC1,
                     aes(x = Recovery....),
                     binwidth = 2, fill = "royalblue4", color = "gray40") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("HLAPC; n = ", nrow(HLAPC1))) +
      theme(axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    XCB1 <- chosen_exps()
    XCB1 <- subset(XCB1, Expanded_Core_Type == "XCB")
    t2_p3 <- ggplot() +
      geom_histogram(data = XCB1,
                     aes(x = Recovery....),
                     binwidth = 2, fill = "palevioletred3", color = "gray40") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("XCB; n = ", nrow(XCB1))) +
      theme(axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    RCB1 <- chosen_exps()
    RCB1 <- subset(RCB1, Expanded_Core_Type == "RCB")
    t2_p4 <- ggplot() +
      geom_histogram(data = RCB1,
                     aes(x = Recovery....),
                     binwidth = 2, fill = "orange", color = "gray40") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(RCB1))) +
      theme(axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    

    plot_grid(t2_p1, t2_p2, t2_p3, t2_p4, nrow = 2)
  })
  ########TAB1 - RECOVERY PLOTS - SCALED########################################    
  output$recoveryPlot1S <- renderPlot({
    APC1 <- chosen_exps()
    APC1 <- subset(APC1, Expanded_Core_Type == "APC")
    t2_p1 <- ggplot() +
      geom_histogram(data = APC1,
                     aes(x = Recovery....),
                     binwidth = 2, fill = "mediumturquoise", color = "gray40") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("APC; n = ", nrow(APC1))) +
      theme(axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    HLAPC1 <- chosen_exps()
    HLAPC1 <- subset(HLAPC1, Expanded_Core_Type == "HLAPC")
    t2_p2 <- ggplot() +
      geom_histogram(data = HLAPC1,
                     aes(x = Recovery....),
                     binwidth = 2, fill = "royalblue4", color = "gray40") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("HLAPC; n = ", nrow(HLAPC1))) +
      theme(axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    XCB1 <- chosen_exps()
    XCB1 <- subset(XCB1, Expanded_Core_Type == "XCB")
    t2_p3 <- ggplot() +
      geom_histogram(data = XCB1,
                     aes(x = Recovery....),
                     binwidth = 2, fill = "palevioletred3", color = "gray40") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("XCB; n = ", nrow(XCB1))) +
      theme(axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    RCB1 <- chosen_exps()
    RCB1 <- subset(RCB1, Expanded_Core_Type == "RCB")
    t2_p4 <- ggplot() +
      geom_histogram(data = RCB1,
                     aes(x = Recovery....),
                     binwidth = 2, fill = "orange", color = "gray40") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(RCB1))) +
      theme(axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    #empty hold graph for scaling
    fake_legend <- chosen_exps()
    fake_legend <- subset(fake_legend, Expanded_Core_Type == "APC" | Expanded_Core_Type == "HLAPC" | Expanded_Core_Type == "XCB" | Expanded_Core_Type == "RCB")
    empty1 <- ggplot() +
      geom_histogram(data = fake_legend,
                     aes(x = Recovery....),
                     binwidth = 2, fill = "orange", color = "gray40") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(fake_legend))) +
      theme(axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    t2_p1 <- t2_p1 + scale_y_continuous(expand = c(0,0),
                                        limits=c(0,max(ggplot_build(empty1)$data[[1]]$count)*1.01))
    t2_p2 <- t2_p2 + scale_y_continuous(expand = c(0,0),
                                        limits=c(0,max(ggplot_build(empty1)$data[[1]]$count)*1.01))
    t2_p3 <- t2_p3 + scale_y_continuous(expand = c(0,0),
                                        limits=c(0,max(ggplot_build(empty1)$data[[1]]$count)*1.01))
    t2_p4 <- t2_p4 + scale_y_continuous(expand = c(0,0),
                                        limits=c(0,max(ggplot_build(empty1)$data[[1]]$count)*1.01))

    
    plot_grid(t2_p1, t2_p2, t2_p3, t2_p4, nrow = 2)
  })
  
  ########TAB2 - RECOVERY PLOTS - PROGRAM - UNSCALED#####################################
  program_colors <- c("DSDP" = "darkorange2", "ODP" = "darkseagreen3", "IODP-1" = "maroon2", "IODP-2" = "royalblue2")
  output$recoveryPlotProgram2U <- renderPlot({
    APC1 <- chosen_exps()
    APC1 <- subset(APC1, Expanded_Core_Type == "APC")
    t2_p1 <- ggplot() +
      geom_histogram(data = APC1,
                     aes(x = Recovery...., fill = Program),
                     binwidth = 2, color = "gray40", size = 0.01) +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("APC; n = ", nrow(APC1))) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    HLAPC1 <- chosen_exps()
    HLAPC1 <- subset(HLAPC1, Expanded_Core_Type == "HLAPC")
    t2_p2 <- ggplot() +
      geom_histogram(data = HLAPC1,
                     aes(x = Recovery...., fill = Program),
                     binwidth = 2, color = "gray40", size = 0.01) +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("HLAPC; n = ", nrow(HLAPC1))) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    XCB1 <- chosen_exps()
    XCB1 <- subset(XCB1, Expanded_Core_Type == "XCB")
    t2_p3 <- ggplot() +
      geom_histogram(data = XCB1,
                     aes(x = Recovery...., fill = Program),
                     binwidth = 2, color = "gray40", size = 0.01) +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("XCB; n = ", nrow(XCB1))) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    RCB1 <- chosen_exps()
    RCB1 <- subset(RCB1, Expanded_Core_Type == "RCB")
    t2_p4 <- ggplot() +
      geom_histogram(data = RCB1,
                     aes(x = Recovery...., fill = Program),
                     binwidth = 2, color = "gray40", size = 0.01) +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(RCB1))) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    temp_rec2 <- plot_grid(t2_p1, t2_p2, t2_p3, t2_p4, nrow = 2)
    
    #empty hold graph for legend
    fake_legend <- chosen_exps()
    fake_legend <- subset(fake_legend, Expanded_Core_Type == "APC" | Expanded_Core_Type == "HLAPC" | Expanded_Core_Type == "XCB" | Expanded_Core_Type == "RCB")
    empty2 <- ggplot() +
      geom_histogram(data = fake_legend,
                     aes(x = Recovery...., fill = Program),
                     binwidth = 2, color = "gray40", size = 0.01) +
      theme_classic() +
      scale_fill_manual(values = program_colors, breaks = c("DSDP", "ODP", "IODP-1", "IODP-2")) +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(fake_legend))) +
      theme(legend.position = "bottom",
            legend.title = element_blank(),
            legend.text=element_text(size=15),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))

    legend2 <- get_legend(
      empty2 + 
        guides(color = guide_legend(nrow = 1)) +
        theme(legend.position = "bottom")
    )

    plot_grid(temp_rec2, legend2, ncol = 1, rel_heights = c(1,.1))
  })
  
  ########TAB2 - RECOVERY PLOTS - PROGRAM - SCALED#####################################
  program_colors <- c("DSDP" = "darkorange2", "ODP" = "darkseagreen3", "IODP-1" = "maroon2", "IODP-2" = "royalblue2")
  output$recoveryPlotProgram2S <- renderPlot({
    APC1 <- chosen_exps()
    APC1 <- subset(APC1, Expanded_Core_Type == "APC")
    t2_p1 <- ggplot() +
      geom_histogram(data = APC1,
                     aes(x = Recovery...., fill = Program),
                     binwidth = 2, color = "gray40", size = 0.01) +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("APC; n = ", nrow(APC1))) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    HLAPC1 <- chosen_exps()
    HLAPC1 <- subset(HLAPC1, Expanded_Core_Type == "HLAPC")
    t2_p2 <- ggplot() +
      geom_histogram(data = HLAPC1,
                     aes(x = Recovery...., fill = Program),
                     binwidth = 2, color = "gray40", size = 0.01) +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("HLAPC; n = ", nrow(HLAPC1))) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    XCB1 <- chosen_exps()
    XCB1 <- subset(XCB1, Expanded_Core_Type == "XCB")
    t2_p3 <- ggplot() +
      geom_histogram(data = XCB1,
                     aes(x = Recovery...., fill = Program),
                     binwidth = 2, color = "gray40", size = 0.01) +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("XCB; n = ", nrow(XCB1))) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    RCB1 <- chosen_exps()
    RCB1 <- subset(RCB1, Expanded_Core_Type == "RCB")
    t2_p4 <- ggplot() +
      geom_histogram(data = RCB1,
                     aes(x = Recovery...., fill = Program),
                     binwidth = 2, color = "gray40", size = 0.01) +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(RCB1))) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    #empty hold graph for legend
    fake_legend <- chosen_exps()
    fake_legend <- subset(fake_legend, Expanded_Core_Type == "APC" | Expanded_Core_Type == "HLAPC" | Expanded_Core_Type == "XCB" | Expanded_Core_Type == "RCB")
    empty2 <- ggplot() +
      geom_histogram(data = fake_legend,
                     aes(x = Recovery...., fill = Program),
                     binwidth = 2, color = "gray40", size = 0.01) +
      theme_classic() +
      scale_fill_manual(values = program_colors, breaks = c("DSDP", "ODP", "IODP-1", "IODP-2")) +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(fake_legend))) +
      theme(legend.position = "bottom",
            legend.title = element_blank(),
            legend.text=element_text(size=15),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    #another fake for scale
    empty3 <- ggplot() +
      geom_histogram(data = fake_legend,
                     aes(x = Recovery....),
                     binwidth = 2, color = "gray40", size = 0.01) +
      theme_classic() +
      scale_fill_manual(values = program_colors, breaks = c("DSDP", "ODP", "IODP-1", "IODP-2")) +
      scale_x_continuous(breaks = seq(0, 150, by = 20)) +
      coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(fake_legend))) +
      theme(legend.position = "bottom",
            legend.title = element_blank(),
            legend.text=element_text(size=15),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    t2_p1 <- t2_p1 + scale_y_continuous(expand = c(0,0),
                                        limits=c(0,max(ggplot_build(empty3)$data[[1]]$count)*1.01))
    t2_p2 <- t2_p2 + scale_y_continuous(expand = c(0,0),
                                        limits=c(0,max(ggplot_build(empty3)$data[[1]]$count)*1.01))
    t2_p3 <- t2_p3 + scale_y_continuous(expand = c(0,0),
                                        limits=c(0,max(ggplot_build(empty3)$data[[1]]$count)*1.01))
    t2_p4 <- t2_p4 + scale_y_continuous(expand = c(0,0),
                                        limits=c(0,max(ggplot_build(empty3)$data[[1]]$count)*1.01))
    
    temp_rec2 <- plot_grid(t2_p1, t2_p2, t2_p3, t2_p4, nrow = 2)
    
    legend2 <- get_legend(
      empty2 + 
        guides(color = guide_legend(nrow = 1)) +
        theme(legend.position = "bottom")
    )
    
    plot_grid(temp_rec2, legend2, ncol = 1, rel_heights = c(1,.1))
  })
  
  ########TAB3 - RECOVERY PLOTS - EXPEDITION - UNSCALED####################################
  output$recoveryPlotExp3U <- renderPlot({
  if(length(unique(chosen_exps()$Exp)) > 10){
    
  }
  else{
  temp_colors <- c("dodgerblue2", "tomato2", "seagreen3", "goldenrod2", "magenta4",
                   "darkorange", "thistle1", "pink", "darkcyan", "black")
  temp_colors1 <- temp_colors[1:length(unique(chosen_exps()$Exp))]
  names(temp_colors1) = as.character(unique(chosen_exps()$Exp))
  
  APC1 <- chosen_exps()
  APC1 <- subset(APC1, Expanded_Core_Type == "APC")
  t2_p1 <- ggplot() +
    geom_histogram(data = APC1,
                   aes(x = Recovery...., fill = Exp),
                   binwidth = 2, color = "gray40", size = 0.01) +
    theme_classic() +
    scale_fill_manual(values = temp_colors1) +
    scale_x_continuous(breaks = seq(0, 150, by = 20)) +
    coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
    labs(x = "recovery (%)", y = "Count", title = paste0("APC; n = ", nrow(APC1))) +
    theme(legend.position = "none",
          axis.text=element_text(size=12),
          axis.ticks.length = unit(0.25, "cm"),
          axis.title=element_text(size=15,face="bold"),
          plot.margin = margin(20, 50, 20, 20))
  
  HLAPC1 <- chosen_exps()
  HLAPC1 <- subset(HLAPC1, Expanded_Core_Type == "HLAPC")
  t2_p2 <- ggplot() +
    geom_histogram(data = HLAPC1,
                   aes(x = Recovery...., fill = Exp),
                   binwidth = 2, color = "gray40", size = 0.01) +
    theme_classic() +
    scale_fill_manual(values = temp_colors1) +
    scale_x_continuous(breaks = seq(0, 150, by = 20)) +
    coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
    labs(x = "recovery (%)", y = "Count", title = paste0("HLAPC; n = ", nrow(HLAPC1))) +
    theme(legend.position = "none",
          axis.text=element_text(size=12),
          axis.ticks.length = unit(0.25, "cm"),
          axis.title=element_text(size=15,face="bold"),
          plot.margin = margin(20, 50, 20, 20))
  
  XCB1 <- chosen_exps()
  XCB1 <- subset(XCB1, Expanded_Core_Type == "XCB")
  t2_p3 <- ggplot() +
    geom_histogram(data = XCB1,
                   aes(x = Recovery...., fill = Exp),
                   binwidth = 2, color = "gray40", size = 0.01) +
    theme_classic() +
    scale_fill_manual(values = temp_colors1) +
    scale_x_continuous(breaks = seq(0, 150, by = 20)) +
    coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
    labs(x = "recovery (%)", y = "Count", title = paste0("XCB; n = ", nrow(XCB1))) +
    theme(legend.position = "none",
          axis.text=element_text(size=12),
          axis.ticks.length = unit(0.25, "cm"),
          axis.title=element_text(size=15,face="bold"),
          plot.margin = margin(20, 50, 20, 20))
  
  RCB1 <- chosen_exps()
  RCB1 <- subset(RCB1, Expanded_Core_Type == "RCB")
  t2_p4 <- ggplot() +
    geom_histogram(data = RCB1,
                   aes(x = Recovery...., fill = Exp),
                   binwidth = 2, color = "gray40", size = 0.01) +
    theme_classic() +
    scale_fill_manual(values = temp_colors1) +
    scale_x_continuous(breaks = seq(0, 150, by = 20)) +
    coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
    labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(RCB1))) +
    theme(legend.position = "none",
          axis.text=element_text(size=12),
          axis.ticks.length = unit(0.25, "cm"),
          axis.title=element_text(size=15,face="bold"),
          plot.margin = margin(20, 50, 20, 20))
  
  #empty hold graph for legend
  fake_legend <- chosen_exps()
  fake_legend <- subset(fake_legend, Expanded_Core_Type == "APC" | Expanded_Core_Type == "HLAPC" | Expanded_Core_Type == "XCB" | Expanded_Core_Type == "RCB")
  
  empty3 <- ggplot() +
    geom_histogram(data = fake_legend,
                   aes(x = Recovery...., fill = Exp),
                   binwidth = 2, color = "gray40", size = 0.01) +
    theme_classic() +
    scale_fill_manual(values = temp_colors1) +
    scale_x_continuous(breaks = seq(0, 150, by = 20)) +
    coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
    labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(fake_legend))) +
    theme(legend.position = "bottom",
          legend.title = element_blank(),
          legend.text=element_text(size=12),
          axis.ticks.length = unit(0.25, "cm"),
          axis.title=element_text(size=15,face="bold"),
          plot.margin = margin(20, 50, 20, 20))
  
  legend3 <- get_legend(
    empty3 + 
      guides(fill = guide_legend(nrow = 2)) +
      theme(legend.position = "bottom"))
  
  temp_rec3 <- plot_grid(t2_p1, t2_p2, t2_p3, t2_p4, nrow = 2)
  plot_grid(temp_rec3, legend3, ncol = 1, rel_heights = c(1, 0.1))
  
}
  })
  
  ########TAB3 - RECOVERY PLOTS - EXPEDITION - SCALED###########################
  output$recoveryPlotExp3S <- renderPlot({
    if(length(unique(chosen_exps()$Exp)) > 10){
      
    }
    else{
      temp_colors <- c("dodgerblue2", "tomato2", "seagreen3", "goldenrod2", "magenta4",
                       "darkorange", "thistle1", "pink", "darkcyan", "black")
      temp_colors1 <- temp_colors[1:length(unique(chosen_exps()$Exp))]
      names(temp_colors1) = as.character(unique(chosen_exps()$Exp))
      
      APC1 <- chosen_exps()
      APC1 <- subset(APC1, Expanded_Core_Type == "APC")
      t2_p1 <- ggplot() +
        geom_histogram(data = APC1,
                       aes(x = Recovery...., fill = Exp),
                       binwidth = 2, color = "gray40", size = 0.01) +
        theme_classic() +
        scale_fill_manual(values = temp_colors1) +
        scale_x_continuous(breaks = seq(0, 150, by = 20)) +
        coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
        labs(x = "recovery (%)", y = "Count", title = paste0("APC; n = ", nrow(APC1))) +
        theme(legend.position = "none",
              axis.text=element_text(size=12),
              axis.ticks.length = unit(0.25, "cm"),
              axis.title=element_text(size=15,face="bold"),
              plot.margin = margin(20, 50, 20, 20))
      
      HLAPC1 <- chosen_exps()
      HLAPC1 <- subset(HLAPC1, Expanded_Core_Type == "HLAPC")
      t2_p2 <- ggplot() +
        geom_histogram(data = HLAPC1,
                       aes(x = Recovery...., fill = Exp),
                       binwidth = 2, color = "gray40", size = 0.01) +
        theme_classic() +
        scale_fill_manual(values = temp_colors1) +
        scale_x_continuous(breaks = seq(0, 150, by = 20)) +
        coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
        labs(x = "recovery (%)", y = "Count", title = paste0("HLAPC; n = ", nrow(HLAPC1))) +
        theme(legend.position = "none",
              axis.text=element_text(size=12),
              axis.ticks.length = unit(0.25, "cm"),
              axis.title=element_text(size=15,face="bold"),
              plot.margin = margin(20, 50, 20, 20))
      
      XCB1 <- chosen_exps()
      XCB1 <- subset(XCB1, Expanded_Core_Type == "XCB")
      t2_p3 <- ggplot() +
        geom_histogram(data = XCB1,
                       aes(x = Recovery...., fill = Exp),
                       binwidth = 2, color = "gray40", size = 0.01) +
        theme_classic() +
        scale_fill_manual(values = temp_colors1) +
        scale_x_continuous(breaks = seq(0, 150, by = 20)) +
        coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
        labs(x = "recovery (%)", y = "Count", title = paste0("XCB; n = ", nrow(XCB1))) +
        theme(legend.position = "none",
              axis.text=element_text(size=12),
              axis.ticks.length = unit(0.25, "cm"),
              axis.title=element_text(size=15,face="bold"),
              plot.margin = margin(20, 50, 20, 20))
      
      RCB1 <- chosen_exps()
      RCB1 <- subset(RCB1, Expanded_Core_Type == "RCB")
      t2_p4 <- ggplot() +
        geom_histogram(data = RCB1,
                       aes(x = Recovery...., fill = Exp),
                       binwidth = 2, color = "gray40", size = 0.01) +
        theme_classic() +
        scale_fill_manual(values = temp_colors1) +
        scale_x_continuous(breaks = seq(0, 150, by = 20)) +
        coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
        labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(RCB1))) +
        theme(legend.position = "none",
              axis.text=element_text(size=12),
              axis.ticks.length = unit(0.25, "cm"),
              axis.title=element_text(size=15,face="bold"),
              plot.margin = margin(20, 50, 20, 20))
      
      #empty hold graph for legend
      fake_legend <- chosen_exps()
      fake_legend <- subset(fake_legend, Expanded_Core_Type == "APC" | Expanded_Core_Type == "HLAPC" | Expanded_Core_Type == "XCB" | Expanded_Core_Type == "RCB")
      
      empty3 <- ggplot() +
        geom_histogram(data = fake_legend,
                       aes(x = Recovery...., fill = Exp),
                       binwidth = 2, color = "gray40", size = 0.01) +
        theme_classic() +
        scale_fill_manual(values = temp_colors1) +
        scale_x_continuous(breaks = seq(0, 150, by = 20)) +
        coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
        labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(fake_legend))) +
        theme(legend.position = "bottom",
              legend.title = element_blank(),
              legend.text=element_text(size=12),
              axis.ticks.length = unit(0.25, "cm"),
              axis.title=element_text(size=15,face="bold"),
              plot.margin = margin(20, 50, 20, 20))
      
      #empty hold graph for scale
      fake_legend <- chosen_exps()
      fake_legend <- subset(fake_legend, Expanded_Core_Type == "APC" | Expanded_Core_Type == "HLAPC" | Expanded_Core_Type == "XCB" | Expanded_Core_Type == "RCB")
      
      empty4 <- ggplot() +
        geom_histogram(data = fake_legend,
                       aes(x = Recovery....),
                       binwidth = 2, color = "gray40", size = 0.01) +
        theme_classic() +
        scale_fill_manual(values = temp_colors1) +
        scale_x_continuous(breaks = seq(0, 150, by = 20)) +
        coord_cartesian(expand = c(0,0), xlim = c(-5, 125)) +
        labs(x = "recovery (%)", y = "Count", title = paste0("RCB; n = ", nrow(fake_legend))) +
        theme(legend.position = "bottom",
              legend.title = element_blank(),
              legend.text=element_text(size=12),
              axis.ticks.length = unit(0.25, "cm"),
              axis.title=element_text(size=15,face="bold"),
              plot.margin = margin(20, 50, 20, 20))
      
      legend3 <- get_legend(
        empty3 + 
          guides(fill = guide_legend(nrow = 2)) +
          theme(legend.position = "bottom"))
      
      t2_p1 <- t2_p1 + scale_y_continuous(expand = c(0,0),
                                          limits=c(0,max(ggplot_build(empty4)$data[[1]]$count)*1.01))
      t2_p2 <- t2_p2 + scale_y_continuous(expand = c(0,0),
                                          limits=c(0,max(ggplot_build(empty4)$data[[1]]$count)*1.01))
      t2_p3 <- t2_p3 + scale_y_continuous(expand = c(0,0),
                                          limits=c(0,max(ggplot_build(empty4)$data[[1]]$count)*1.01))
      t2_p4 <- t2_p4 + scale_y_continuous(expand = c(0,0),
                                          limits=c(0,max(ggplot_build(empty4)$data[[1]]$count)*1.01))
      
      temp_rec3 <- plot_grid(t2_p1, t2_p2, t2_p3, t2_p4, nrow = 2)
      plot_grid(temp_rec3, legend3, ncol = 1, rel_heights = c(1, 0.1))
      
    }
  })
  
  ########TAB4 - DEPTH PLOTS###########################################
  output$depthPlot <- renderPlot({
    APC1 <- chosen_exps()
    APC1 <- subset(APC1, Expanded_Core_Type == "APC")
    t2_p5 <- ggplot() +
      geom_point(data = APC1,
                 aes(y = Top.depth.cored.CSF..m., x = Recovery....),
                 fill = "mediumturquoise", size = 3, shape = 21, color = "grey50") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 25)) +
      scale_y_reverse() +
      coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "mbsf", title = "APC") +
      annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
               label = paste0("max = ", max(APC1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    HLAPC1 <- chosen_exps()
    HLAPC1 <- subset(HLAPC1, Expanded_Core_Type == "HLAPC")
    t2_p6 <- ggplot() +
      geom_point(data = HLAPC1,
                 aes(y = Top.depth.cored.CSF..m., x = Recovery....),
                 fill = "royalblue4", size = 3, shape = 21, color = "grey50") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 25)) +
      scale_y_reverse() +
      coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "mbsf", title = "HLAPC") +
      annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
               label = paste0("max = ", max(HLAPC1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    XCB1 <- chosen_exps()
    XCB1 <- subset(XCB1, Expanded_Core_Type == "XCB")
    t2_p7 <- ggplot() +
      geom_point(data = XCB1,
                 aes(y = Top.depth.cored.CSF..m., x = Recovery....),
                 fill = "palevioletred3", size = 3, shape = 21, color = "grey50") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 25)) +
      scale_y_reverse() +
      coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "mbsf", title = "XCB") +
      annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
               label = paste0("max = ", max(XCB1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    RCB1 <- chosen_exps()
    RCB1 <- subset(RCB1, Expanded_Core_Type == "RCB")
    t2_p8 <- ggplot() +
      geom_point(data = RCB1,
                 aes(y = Top.depth.cored.CSF..m., x = Recovery....),
                 fill = "orange", size = 3, shape = 21, color = "grey50") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 25)) +
      scale_y_reverse() +
      coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "mbsf", title = "RCB") +
      annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
               label = paste0("max = ", max(RCB1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    plot_grid(t2_p5, t2_p6, t2_p7, t2_p8, nrow = 1)
  })
  
  ########TAB5 - DEPTH PLOTS - PROGRAM###########################################
  program_colors <- c("DSDP" = "darkorange2", "ODP" = "darkseagreen3", "IODP-1" = "maroon2", "IODP-2" = "royalblue2")
  program_shapes <- c("DSDP" = 21, "ODP" = 22, "IODP-1" = 23, "IODP-2" = 24)
  output$depthPlotProgram <- renderPlot({
    APC1 <- chosen_exps()
    APC1 <- subset(APC1, Expanded_Core_Type == "APC")
    t2_p5 <- ggplot() +
      geom_point(data = APC1,
                 aes(y = Top.depth.cored.CSF..m., x = Recovery...., fill = Program, shape = Program),
                 size = 3, color = "grey50") +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_shape_manual(values = program_shapes) +
      scale_x_continuous(breaks = seq(0, 150, by = 25)) +
      scale_y_reverse() +
      coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "mbsf", title = "APC") +
      annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
               label = paste0("max = ", max(APC1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    HLAPC1 <- chosen_exps()
    HLAPC1 <- subset(HLAPC1, Expanded_Core_Type == "HLAPC")
    t2_p6 <- ggplot() +
      geom_point(data = HLAPC1,
                 aes(y = Top.depth.cored.CSF..m., x = Recovery...., fill = Program, shape = Program),
                 size = 3, color = "grey50") +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_shape_manual(values = program_shapes) +
      scale_x_continuous(breaks = seq(0, 150, by = 25)) +
      scale_y_reverse() +
      coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "mbsf", title = "HLAPC") +
      annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
               label = paste0("max = ", max(HLAPC1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    XCB1 <- chosen_exps()
    XCB1 <- subset(XCB1, Expanded_Core_Type == "XCB")
    t2_p7 <- ggplot() +
      geom_point(data = XCB1,
                 aes(y = Top.depth.cored.CSF..m., x = Recovery...., fill = Program, shape = Program),
                 size = 3, color = "grey50") +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_shape_manual(values = program_shapes) +
      scale_x_continuous(breaks = seq(0, 150, by = 25)) +
      scale_y_reverse() +
      coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "mbsf", title = "XCB") +
      annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
               label = paste0("max = ", max(XCB1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    RCB1 <- chosen_exps()
    RCB1 <- subset(RCB1, Expanded_Core_Type == "RCB")
    t2_p8 <- ggplot() +
      geom_point(data = RCB1,
                 aes(y = Top.depth.cored.CSF..m., x = Recovery...., fill = Program, shape = Program),
                 size = 3, color = "grey50") +
      theme_classic() +
      scale_fill_manual(values = program_colors) +
      scale_shape_manual(values = program_shapes) +
      scale_x_continuous(breaks = seq(0, 150, by = 25)) +
      scale_y_reverse() +
      coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "mbsf", title = "RCB") +
      annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
               label = paste0("max = ", max(RCB1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
      theme(legend.position = "none",
            axis.text=element_text(size=12),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    temp_rec4 <- plot_grid(t2_p5, t2_p6, t2_p7, t2_p8, nrow = 1)
    
    #empty hold graph for legend
    fake_legend <- chosen_exps()
    fake_legend <- subset(fake_legend, Expanded_Core_Type == "APC" | Expanded_Core_Type == "HLAPC" | Expanded_Core_Type == "XCB" | Expanded_Core_Type == "RCB")
    empty4 <- ggplot() +
      geom_point(data = fake_legend,
                 aes(y = Top.depth.cored.CSF..m., x = Recovery...., fill = Program, shape = Program),
                 size = 5, color = "grey50") +
      theme_classic() +
      scale_x_continuous(breaks = seq(0, 150, by = 25)) +
      scale_y_reverse() +
      scale_fill_manual(values = program_colors, breaks = c("DSDP", "ODP", "IODP-1", "IODP-2")) +
      scale_shape_manual(values = program_shapes, breaks = c("DSDP", "ODP", "IODP-1", "IODP-2")) +
      coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
      labs(x = "recovery (%)", y = "mbsf", title = "RCB") +
      theme(legend.position = "bottom",
            legend.title = element_blank(),
            legend.text=element_text(size=15),
            axis.ticks.length = unit(0.25, "cm"),
            axis.title=element_text(size=15,face="bold"),
            plot.margin = margin(20, 50, 20, 20))
    
    legend4 <- get_legend(
      empty4 + 
        guides(color = guide_legend(nrow = 1)) +
        theme(legend.position = "bottom")
    )
    
    plot_grid(temp_rec4, legend4, ncol = 1, rel_heights = c(1,.1))
  })
  
  ########TAB6 - DEPTH PLOTS - EXPEDITION####################################
  output$depthPlotExp <- renderPlot({
    if(length(unique(chosen_exps()$Exp)) > 10){
      
    }
    else{
      temp_colors <- c("dodgerblue2", "tomato2", "seagreen3", "goldenrod2", "magenta4",
                       "darkorange", "thistle1", "pink", "darkcyan", "black")
      temp_colors1 <- temp_colors[1:length(unique(chosen_exps()$Exp))]
      names(temp_colors1) = as.character(unique(chosen_exps()$Exp))
      
      temp_shapes <- c(21, 22, 23, 24, 25, 21, 22, 23, 24, 25)
      temp_shapes1 <- temp_shapes[1:length(unique(chosen_exps()$Exp))]
      names(temp_shapes1) = as.character(unique(chosen_exps()$Exp))
      
      APC1 <- chosen_exps()
      APC1 <- subset(APC1, Expanded_Core_Type == "APC")
      t2_p5 <- ggplot() +
        geom_point(data = APC1,
                   aes(y = Top.depth.cored.CSF..m., x = Recovery...., fill = Exp, shape = Exp),
                   size = 3, color = "grey50") +
        theme_classic() +
        scale_fill_manual(values = temp_colors1) +
        scale_shape_manual(values = temp_shapes1) +
        scale_x_continuous(breaks = seq(0, 150, by = 25)) +
        scale_y_reverse() +
        coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
        labs(x = "recovery (%)", y = "mbsf", title = "APC") +
        annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
                 label = paste0("max = ", max(APC1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
        theme(legend.position = "none",
              axis.text=element_text(size=12),
              axis.ticks.length = unit(0.25, "cm"),
              axis.title=element_text(size=15,face="bold"),
              plot.margin = margin(20, 50, 20, 20))
      
      HLAPC1 <- chosen_exps()
      HLAPC1 <- subset(HLAPC1, Expanded_Core_Type == "HLAPC")
      t2_p6 <- ggplot() +
        geom_point(data = HLAPC1,
                   aes(y = Top.depth.cored.CSF..m., x = Recovery...., fill = Exp, shape = Exp),
                   size = 3, color = "grey50") +
        theme_classic() +
        scale_fill_manual(values = temp_colors1) +
        scale_shape_manual(values = temp_shapes1) +
        scale_x_continuous(breaks = seq(0, 150, by = 25)) +
        scale_y_reverse() +
        coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
        labs(x = "recovery (%)", y = "mbsf", title = "HLAPC") +
        annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
                 label = paste0("max = ", max(HLAPC1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
        theme(legend.position = "none",
              axis.text=element_text(size=12),
              axis.ticks.length = unit(0.25, "cm"),
              axis.title=element_text(size=15,face="bold"),
              plot.margin = margin(20, 50, 20, 20))
      
      XCB1 <- chosen_exps()
      XCB1 <- subset(XCB1, Expanded_Core_Type == "XCB")
      t2_p7 <- ggplot() +
        geom_point(data = XCB1,
                   aes(y = Top.depth.cored.CSF..m., x = Recovery...., fill = Exp, shape = Exp),
                   size = 3, color = "grey50") +
        theme_classic() +
        scale_fill_manual(values = temp_colors1) +
        scale_shape_manual(values = temp_shapes1) +
        scale_x_continuous(breaks = seq(0, 150, by = 25)) +
        scale_y_reverse() +
        coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
        labs(x = "recovery (%)", y = "mbsf", title = "XCB") +
        annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
                 label = paste0("max = ", max(XCB1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
        theme(legend.position = "none",
              axis.text=element_text(size=12),
              axis.ticks.length = unit(0.25, "cm"),
              axis.title=element_text(size=15,face="bold"),
              plot.margin = margin(20, 50, 20, 20))
      
      RCB1 <- chosen_exps()
      RCB1 <- subset(RCB1, Expanded_Core_Type == "RCB")
      t2_p8 <- ggplot() +
        geom_point(data = RCB1,
                   aes(y = Top.depth.cored.CSF..m., x = Recovery...., fill = Exp, shape = Exp),
                   size = 3, color = "grey50") +
        theme_classic() +
        scale_fill_manual(values = temp_colors1) +
        scale_shape_manual(values = temp_shapes1) +
        scale_x_continuous(breaks = seq(0, 150, by = 25)) +
        scale_y_reverse() +
        coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
        labs(x = "recovery (%)", y = "mbsf", title = "RCB") +
        annotate("text", x = 70, y = max(chosen_exps()$Bottom.depth.recovered..m.) - 20, 
                 label = paste0("max = ", max(RCB1$Bottom.depth.recovered..m.)), hjust = 0, vjust = 1) +
        theme(legend.position = "none",
              axis.text=element_text(size=12),
              axis.ticks.length = unit(0.25, "cm"),
              axis.title=element_text(size=15,face="bold"),
              plot.margin = margin(20, 50, 20, 20))
      
      temp_rec4 <- plot_grid(t2_p5, t2_p6, t2_p7, t2_p8, nrow = 1)
      
      #empty hold graph for legend
      fake_legend <- chosen_exps()
      fake_legend <- subset(fake_legend, Expanded_Core_Type == "APC" | Expanded_Core_Type == "HLAPC" | Expanded_Core_Type == "XCB" | Expanded_Core_Type == "RCB")
      empty4 <- ggplot() +
        geom_point(data = fake_legend,
                   aes(y = Top.depth.cored.CSF..m., x = Recovery...., fill = Exp, shape = Exp),
                   size = 3, color = "grey50") +
        theme_classic() +
        scale_x_continuous(breaks = seq(0, 150, by = 25)) +
        scale_y_reverse() +
        scale_fill_manual(values = temp_colors1) +
        scale_shape_manual(values = temp_shapes1) +
        coord_cartesian(expand = c(0,0), ylim = c(max(chosen_exps()$Bottom.depth.recovered..m.) + 20, -20), xlim = c(-5, 125)) +
        labs(x = "recovery (%)", y = "mbsf", title = "RCB") +
        theme(legend.position = "bottom",
              legend.title = element_blank(),
              legend.text=element_text(size=15),
              axis.ticks.length = unit(0.25, "cm"),
              axis.title=element_text(size=15,face="bold"),
              plot.margin = margin(20, 50, 20, 20))
      
      legend4 <- get_legend(
        empty4 + 
          guides(color = guide_legend(nrow = 1)) +
          theme(legend.position = "bottom")
      )
      
      plot_grid(temp_rec4, legend4, ncol = 1, rel_heights = c(1,.1))
    }
  })
}

shinyApp(ui = ui, server = server)