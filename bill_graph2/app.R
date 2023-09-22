#More Quick Gas Reports for Bill
#started:  17 September 2023
#updated: 17 September 2023
#Laurel Childress; childress@iodp.tamu.edu

library(ggplot2)
library(dplyr)
library(plyr)
library(scales)
library(cowplot)
library(shiny)

ytop <- -1

ui <- fluidPage(titlePanel("Bill's Quick Gas Grapher - Downhole"),
                    sidebarLayout(
                      sidebarPanel(width = 2,
                        h6("Download the gas report from LIMS. Keep the file in .csv format. Upload it here."),
                        fileInput("file", "Upload your file",
                                  accept = c(
                                    "text/csv",
                                    "text/comma-separated-values,text/plain",
                                    ".csv")),
                        #same as above but for a batch; user can download table
                        actionButton("goButton1", "Make my graphs!"),
                        br()),
                      mainPanel(fluidRow(
                        column(2, numericInput("scalex1", "Change x-axis max", value = 100000)),
                        column(2, numericInput("scalex2", "Change x-axis max", value = 800)),
                        column(2, numericInput("scalex3", "Change x-axis max", value = 800)),
                        column(2, numericInput("scalex4", "Change x-axis max", value = 150)),
                        column(2, numericInput("scalex5", "Change x-axis max", value = 115)),
                        column(2, numericInput("scalex6", "Change x-axis max", value = 80))),
                        fluidRow(
                          column(width = 2, plotOutput("coolplot")),
                          column(width = 2, plotOutput("coolplot2")),
                          column(width = 2, plotOutput("coolplot3")),
                          column(width = 2, plotOutput("coolplot4")),
                          column(width = 2, plotOutput("coolplot5")),
                          column(width = 2, plotOutput("coolplot6")))
                      )
                      ))

server <- function(input, output, session) {
  yesterday <- eventReactive(input$goButton1, { #when user clicks Go Button
    getBillfile <- input$file
    req(getBillfile) #core summary file is required for operation
    file1 <- read.csv(file = getBillfile$datapath, stringsAsFactors = FALSE)
  })
  
  
  ybottom <- reactive({
    gasmonitor <- yesterday()
    gas_bot <- round_any(max(gasmonitor$X.Top.depth.CSF.A..m.) + (max(gasmonitor$X.Top.depth.CSF.A..m.)*0.10), 10)
  })
  
  observe({
    #update values from user chosen for plot width, heigh, size of point, 
    # scales of x- and y-axis
    updateNumericInput(session, 'scalex1')
    updateNumericInput(session, 'scalex2')
    updateNumericInput(session, 'scalex3')
    updateNumericInput(session, 'scalex4')
    updateNumericInput(session, 'scalex5')
    updateNumericInput(session, 'scalex6')
    #updateNumericInput(session, 'scalex7')
  })
  
  output$coolplot <- renderPlot({
    gasmonitor <- yesterday()
    ybottom <- ybottom()
    xtop1 <- input$scalex1
    ggplot(data = gasmonitor, aes(x = Methane..ppmv..NGA.FID, y = X.Top.depth.CSF.A..m.)) +
      geom_path() +
      geom_point(shape = 21, color = "black", fill = "goldenrod4", size = 2.5, stroke = 0.5) +
      scale_y_reverse(breaks = c(seq(ybottom,ytop, by = -10))) +
      scale_x_continuous(breaks = c(seq(0,xtop1, by = round_any(xtop1*0.25,100))), labels = scales::comma) +
      geom_vline(aes(xintercept = 92000),
                 size = 1, linetype = 2, alpha=0.3, color = "red") +
      coord_cartesian(expand = FALSE, xlim = c(-10, xtop1), ylim = c(ybottom,ytop)) +
      theme_classic() +
      labs(x = "Methane (ppmv, NGA-FID)", y = "depth (m)") +
      theme(axis.ticks.length = unit(0.18, "cm"),
            plot.margin = margin(15,15,15,15))
  }, height = 900, width = 250)
  
  output$coolplot2 <- renderPlot({
    gasmonitor <- yesterday()
    ybottom <- ybottom()
    xtop2 <- input$scalex2
    ggplot(data = gasmonitor, aes(x = Ethane..ppmv..NGA.FID, y = X.Top.depth.CSF.A..m.)) +
      geom_path() +
      geom_point(shape = 21, color = "black", fill = "orange2", size = 2.5, stroke = 0.5) +
      scale_y_reverse(breaks = c(seq(ybottom,ytop, by = -10))) +
      scale_x_continuous(breaks = c(seq(0,xtop2, by = round_any(xtop2*0.25,25)))) +
      geom_vline(aes(xintercept = 400),
                 size = 1, linetype = 2, alpha=0.3, color = "red") +
      coord_cartesian(expand = FALSE, xlim = c(-10, xtop2), ylim = c(ybottom,ytop)) +
      theme_classic() +
      labs(x = "Ethane (ppmv, NGA-FID)", y = "depth (m)") +
      theme(axis.ticks.length = unit(0.18, "cm"),
            plot.margin = margin(15,15,15,15))
  }, height = 900, width = 250)
  
  output$coolplot3 <- renderPlot({
    gasmonitor <- yesterday()
    ybottom <- ybottom()
    xtop3 <- input$scalex3
    ggplot(data = gasmonitor, aes(x = Propane..ppmv..NGA.FID, y = X.Top.depth.CSF.A..m.)) +
      geom_path() +
      geom_point(shape = 21, color = "black", fill = "magenta", size = 2.5, stroke = 0.5) +
      scale_y_reverse(breaks = c(seq(ybottom,ytop, by = -10))) +
      scale_x_continuous(breaks = c(seq(0,xtop3, by = round_any(xtop3*0.25,25)))) +
      geom_vline(aes(xintercept = 400),
                 size = 1, linetype = 2, alpha=0.3, color = "red") +
      geom_vline(aes(xintercept = 600),
                 size = 1, linetype = 2, alpha=0.8, color = "red") +
      coord_cartesian(expand = FALSE, xlim = c(-10, xtop3), ylim = c(ybottom,ytop)) +
      theme_classic() +
      labs(x = "Propane (ppmv, NGA-FID)", y = "depth (m)") +
      theme(axis.ticks.length = unit(0.18, "cm"),
            plot.margin = margin(15,15,15,15))
  }, height = 900, width = 250)
    
  output$coolplot4 <- renderPlot({
    gasmonitor <- yesterday()
    ybottom <- ybottom()
    xtop4 <- input$scalex4
    ggplot(data = gasmonitor, aes(x = iso.Butane..ppmv..NGA.FID, y = X.Top.depth.CSF.A..m.)) +
      geom_path() +
      geom_point(shape = 21, color = "black", fill = "darkseagreen3", size = 2.5, stroke = 0.5) +
      scale_y_reverse(breaks = c(seq(ybottom,ytop, by = -20))) +
      scale_x_continuous(breaks = c(seq(0,xtop4, by = round_any(xtop4*0.25,25)))) +
      geom_vline(aes(xintercept = 80),
                 size = 1, linetype = 2, alpha=0.3, color = "red") +
      geom_vline(aes(xintercept = 140),
                 size = 1, linetype = 2, alpha=0.8, color = "red") +
      coord_cartesian(expand = FALSE, xlim = c(-10, xtop4), ylim = c(ybottom,ytop)) +
      theme_classic() +
      labs(x = "isobutane (ppmv, NGA-FID)", y = "depth (m)") +
      theme(axis.ticks.length = unit(0.18, "cm"),
            plot.margin = margin(15,15,15,15))
  }, height = 900, width = 250)
    
  output$coolplot5 <- renderPlot({
    gasmonitor <- yesterday()
    ybottom <- ybottom()
    xtop5 <- input$scalex5
    ggplot(data = gasmonitor, aes(x = n.Butane..ppmv..NGA.FID, y = X.Top.depth.CSF.A..m.)) +
      geom_path() +
      geom_point(shape = 21, color = "black", fill = "steelblue", size = 2.5, stroke = 0.5) +
      scale_y_reverse(breaks = c(seq(ybottom,ytop, by = -20))) +
      scale_x_continuous(breaks = c(seq(0,xtop5, by = round_any(xtop5*0.25,20)))) +
      geom_vline(aes(xintercept = 45),
                 size = 1, linetype = 2, alpha=0.3, color = "red") +
      geom_vline(aes(xintercept = 95),
                 size = 1, linetype = 2, alpha=0.8, color = "red") +
      coord_cartesian(expand = FALSE, xlim = c(-10, xtop5), ylim = c(ybottom,ytop)) +
      theme_classic() +
      labs(x = "n-butane (ppmv, NGA-FID)", y = "depth (m)") +
      theme(axis.ticks.length = unit(0.18, "cm"),
            plot.margin = margin(15,15,15,15))
  }, height = 900, width = 250)
  
  output$coolplot6 <- renderPlot({
    gasmonitor <- yesterday()
    ybottom <- ybottom()
    xtop6 <- input$scalex6
    ggplot(data = gasmonitor, aes(x = iso.pentane..ppmv..NGA.FID, y = X.Top.depth.CSF.A..m.)) +
      geom_path() +
      geom_point(shape = 21, color = "black", fill = "seagreen", size = 2.5, stroke = 0.5) +
      scale_y_reverse(breaks = c(seq(ybottom,ytop, by = -20))) +
      scale_x_continuous(breaks = c(seq(0,xtop6, by = round_any(xtop6*0.25,10)))) +
      geom_vline(aes(xintercept = 35),
                 size = 1, linetype = 2, alpha=0.3, color = "red") +
      geom_vline(aes(xintercept = 60),
                 size = 1, linetype = 2, alpha=0.8, color = "red") +
      coord_cartesian(expand = FALSE, xlim = c(-10, xtop6), ylim = c(ybottom,ytop)) +
      theme_classic() +
      labs(x = "isopentane (ppmv, NGA-FID)", y = "depth (m)") +
      theme(axis.ticks.length = unit(0.18, "cm"),
            plot.margin = margin(15,15,15,15))
  }, height = 900, width = 250)
    # 
    # xtop7 <- input$scalex7
    # p7 <- ggplot(data = gasmonitor, aes(x = n.pentane..ppmv..NGA.FID, y = X.Top.depth.CSF.A..m.)) +
    #   geom_path() +
    #   geom_point(shape = 21, color = "black", fill = "darkseagreen1", size = 2.5, stroke = 0.5) +
    #   scale_y_reverse(breaks = c(seq(ybottom,ytop, by = -20))) +
    #   scale_x_continuous(breaks = c(seq(0,xtop7, by = round_any(xtop6*0.25,25)))) +
    #   coord_cartesian(expand = FALSE, xlim = c(-10, xtop7), ylim = c(ybottom,ytop)) +
    #   theme_classic() +
    #   labs(x = "n-pentane (ppmv, NGA-FID)", y = "depth (m)") +
    #   theme(axis.ticks.length = unit(0.18, "cm"),
    #         plot.margin = margin(6,6,6,6))
    # 
    # plot_grid(p1, p2, p3, p4, p5, p6, p7, nrow=1)
  # })#, height = 900, width = 2100)
}

shinyApp(ui = ui, server = server)