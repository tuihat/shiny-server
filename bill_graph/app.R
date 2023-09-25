#Quick Gas Reports for Bill
#started:  17 September 2023
#updated: 17 September 2023
#Laurel Childress; childress@iodp.tamu.edu

library(ggplot2)
library(dplyr)
library(readxl)
library(shiny)

technote30 <- read.csv("anomalous_gradient.csv", #LIMS file
                       stringsAsFactors = FALSE)
technote_normal <- read.csv("normal_lines.csv", #LIMS file
                            stringsAsFactors = FALSE)
technote30 <- technote30[order(technote30$temp_C),]

ui <- fluidPage(titlePanel("Bill's Quick Gas Grapher"),
                sidebarLayout(
                  sidebarPanel(
                    h6("Add the column with temperatures to the gas report. Keep the file in .csv format."),
                    fileInput("file", "Upload your Excel file with the 'temp' column.",
                              accept = c(".xlsx")),
                    #same as above but for a batch; user can download table
                    actionButton("goButton1", "Make my graphs!"),
                    br(), br(),
                    tags$i("These are not official IODP-JRSO applications 
                                    and functionality is not guaranteed. User assumes all risk.") #italic disclaimer
                    ),
                  mainPanel(plotOutput("coolplot")
                )))

server <- function(input, output, session) {
  yesterday <- eventReactive(input$goButton1, { #when user clicks Go Button
    req(input$file) #core summary file is required for operation
    getBillfile <- input$file
    thefile <- read_excel(getBillfile$datapath, 1)
  })
  
  lastwins <- reactive({
    temp <- yesterday()
    temp2 <- temp[c(nrow(temp)),]
  })
  
  output$coolplot <- renderPlot({
    ggplot() +
      geom_path(data = technote30, aes(x = anom_C1.C2, y = temp_C),
                color = "grey20", linewidth = 2) +
      geom_area(data = technote30, aes(x = anom_C1.C2, y = temp_C),
                fill = "grey80") +
      geom_path(data = technote_normal, aes(x = dashed_x, y = dashed_y),
                linewidth = 0.5, color = "gray20", linetype = 2) +
      geom_path(data = technote_normal, aes(x = left_norm_x, y = left_norm_y),
                linewidth = 0.5, color = "gray20") +
      geom_path(data = technote_normal, aes(x = right_norm_x, y = right_norm_y),
                linewidth = 0.5, color = "gray20") +
      geom_polygon(data=technote_normal,
                   aes(x = shade_x, y = shade_y), fill="blue", alpha=0.2) +
      geom_point(data = yesterday(), aes(x = `c1_c2_nga % NGA-FID`, y = temp),
                 shape = 24, color = "black", fill = "red", size = 5, stroke = 1) +
      geom_point(data = lastwins(), aes(x = `c1_c2_nga % NGA-FID`, y = temp),
                 shape = 24, color = "black", fill = "blue", size = 5, stroke = 1) +
      scale_y_reverse(breaks = c(seq(100, 0, by = -5))) +
      scale_x_log10(position = "top", labels = function(x) format(x, scientific = FALSE)) +
      annotation_logticks(sides = "t", short = unit(0.2, "cm"),
                          mid = unit(0.30, "cm"),
                          long = unit(0.40,"cm")) +
      annotate("text", x=40, y=10, size = 5, label= "Anomalous") +
      annotate("text", x=800, y=45, size = 5, label= "Normal") +
      annotate("text", x=40, y=75, size = 5, angle = 70, label= "High TOC (2%)") +
      annotate("text", x=450, y=80, size = 5, angle = 72, label= "Low TOC (0.5%)") +
      coord_cartesian(expand = FALSE, xlim = c(10, 100000), ylim = c(100,0)) +
      theme_classic() +
      labs(x = "Methane/Ethane (C1/C2)", y = "temperature (C)") +
      theme(axis.ticks.length = unit(0.18, "cm"),
            panel.border = element_rect(colour = "black", fill=NA, linewidth=2),
            axis.line = element_blank(),
            axis.text = element_text(size = 14),
            axis.title = element_text(size = 16),
            plot.margin = margin(10,25,10,10))
  }, height = 900, width = 800)
  
}

shinyApp(ui = ui, server = server)