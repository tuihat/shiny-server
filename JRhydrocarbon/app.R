#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

if(!require(ellipsis)){
  install.packages("ellipsis")
  library(ellipsis) #something...
}

if(!require(stats)){
    install.packages("stats")
    library(stats) #statistics
}

if(!require(ggplot2)){
    install.packages("ggplot2")
    library(ggplot2) #graphs
}

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

technote30 <- read.csv("anomalous_gradient.csv", #LIMS file
                       stringsAsFactors = FALSE)
technote_normal <- read.csv("normal_lines.csv", #LIMS file
                            stringsAsFactors = FALSE)
technote30 <- technote30[order(technote30$temp_C),]

# Define UI for application that draws a histogram
ui <- fluidPage(navbarPage("JR Safety Monitoring",
                           tabPanel("Thermal Gradient",
                                    titlePanel("Thermal Gradient"),
                                    h5("This app will provide a very rough estimate of temperature at depth if
                                       needed for gas safety monitoring. Fits are generalized and not guaranteed
                                       accurate for all thermal gradients."),
                                    h5("To use this app:"),
                                    h5("1. Enter any known values for depth and temperature (left panel). 
                                       By default the seafloor value of 4 C is also included. The graph will
                                       automatically update based on your input."),
                                    h5("2. Enter the depth value for the gas safety measurement. (right panel)"),
                                    h5("3. Temperature values based on linear and exponential regressions will
                                       populate (right panel). Update start values for exponential regression if needed."),
                                    hr(),
                                    sidebarLayout(
                                        sidebarPanel(
                                            h5("Type in values for measured 
                                               temperatures at depth. Values will appear in the plot."),
                                            br(),
                                            fluidRow(
                                                column(6,
                                                       h4("Temperature (C)"),
                                                       numericInput("temp_grad1", "", value = 30),
                                                       numericInput("temp_grad2", "", value = 25),
                                                       numericInput("temp_grad3", "", value = 15),
                                                       numericInput("temp_grad4", "", value = 10),
                                                       numericInput("temp_grad5", "", value = NULL),
                                                       numericInput("temp_grad6", "", value = NULL),
                                                       numericInput("temp_grad7", "", value = NULL),
                                                       numericInput("temp_grad8", "", value = NULL)
                                                ),
                                                column(6,
                                                       h4("Depth (mbsf)"),
                                                       numericInput("depth_grad1", "", value = 900),
                                                       numericInput("depth_grad2", "", value = 350),
                                                       numericInput("depth_grad3", "", value = 75),
                                                       numericInput("depth_grad4", "", value = 50),
                                                       numericInput("depth_grad5", "", value = NULL),
                                                       numericInput("depth_grad6", "", value = NULL),
                                                       numericInput("depth_grad7", "", value = NULL),
                                                       numericInput("depth_grad8", "", value = NULL)
                                                )),
                                            width = 3),
                                        mainPanel(fluidRow(
                                                      column(8,
                                                            plotOutput("temp_gradPlot")),
                                                      column(4,
                                                             numericInput("regressionDepthInput", 
                                                                          "Enter depth (mbsf) of gas safety measurement:", value = 350),
                                                             hr(),
                                                             h4("Linear Regression"),
                                                             textOutput("linearequation"),
                                                             br(),
                                                             textOutput("lineartempOutput"),
                                                             tags$head(tags$style(HTML("#lineartempOutput {font-size: 20px;}"))),
                                                             br(),
                                                             
                                                             hr(),
                                                             h4("Exponential Regression"),
                                                             htmlOutput("expequation"),
                                                             br(),
                                                             textOutput("exptempOutput"),
                                                             tags$head(tags$style(HTML("#exptempOutput {font-size: 20px;}"))),
                                                             hr(),
                                                             h5("If the exponential fit does not look reasonable, adjust the start values for 'a' and 'b'."),
                                                             numericInput("initializeA", "a:", value = 5),
                                                             numericInput("initializeB", "b:", value = 0.16)
                                                             ))
                           ))),
                           
                           tabPanel("Plotting Hydrocarbon",
                                titlePanel("Plotting Hydrocarbon"),
                                    sidebarLayout(
                                        sidebarPanel(
                                            h5("Type in values for sets of hydrocarbon ratios and 
                           temperature (measured or calculated). Values will appear in the plot."),
                                            br(),
                                            fluidRow(
                                                column(6,
                                                h4("C1/C2 Ratio"),
                                                numericInput("ratio1", "", value = NULL),
                                                numericInput("ratio2", "", value = NULL),
                                                numericInput("ratio3", "", value = NULL),
                                                numericInput("ratio4", "", value = NULL),
                                                numericInput("ratio5", "", value = NULL),
                                                numericInput("ratio6", "", value = NULL),
                                                numericInput("ratio7", "", value = NULL),
                                                numericInput("ratio8", "", value = NULL)
                                            ),
                                                column(6,
                                                h4("Temperature (C)"),
                                                numericInput("temp1", "", value = NULL),
                                                numericInput("temp2", "", value = NULL),
                                                numericInput("temp3", "", value = NULL),
                                                numericInput("temp4", "", value = NULL),
                                                numericInput("temp5", "", value = NULL),
                                                numericInput("temp6", "", value = NULL),
                                                numericInput("temp7", "", value = NULL),
                                                numericInput("temp8", "", value = NULL)
                                            )),
                                        width = 3), #narrow the sidebar
                                mainPanel(br(),
                                    plotOutput("coolplot"),
                                    br())
))))

# Define server logic required to draw a histogram
server <- function(input, output) {
#################THERMAL GRADIENT###############################################    
    #dataframe of input values from user
    data_input1 <- reactive({
        data.frame(
            temp_grad = c(4,input$temp_grad1, input$temp_grad2, input$temp_grad3, input$temp_grad4,
                      input$temp_grad5, input$temp_grad6, input$temp_grad7, input$temp_grad8),
            depth_grad = c(0.001,input$depth_grad1, input$depth_grad2, input$depth_grad3, input$depth_grad4,
                     input$depth_grad5, input$depth_grad6, input$depth_grad7, input$depth_grad8)
        )
    })
    #graph of input temperatures and depths
    output$temp_gradPlot <- renderPlot({
        validate( #require some input data before the graph appears
            need(data_input1() != "", "Please enter temperature and depth values.")
        )
        data_input11 <- data_input1() #make input a dataframe in this chunk
        
        a <- input$initializeA
        b <- input$initializeB
        
        ggplot() +
            geom_point(data = data_input11, aes(x = temp_grad, y = depth_grad),
                       shape = 21, color = "black", fill = "red", size = 5, stroke = 1) +
            geom_smooth(data = data_input11, aes(x = temp_grad, y = depth_grad), method = "lm", col = "black", fullrange = TRUE, se = FALSE) +
            stat_smooth(data = data_input11, aes(x = temp_grad, y = depth_grad), 
                        method="nls",formula =  y~a*exp(x*b),method.args=list(start=c(a=a,b=b)),se=F,color="blue")+
            scale_y_reverse(breaks = c(seq(1000, 0, by = -50))) +
            scale_x_continuous(position = "top") +
            coord_cartesian(expand = c(0,0), xlim = c(0, 40), ylim = c(1000,0)) +
            theme_classic() +
            labs(x = "temperature (C)", y = "mbsf") +
            theme(axis.ticks.length = unit(0.18, "cm"),
                  panel.border = element_rect(colour = "black", fill=NA, size=2),
                  axis.line = element_blank(),
                  axis.text = element_text(size = 14),
                  axis.title = element_text(size = 16),
                  aspect.ratio=1,
                  plot.margin = margin(6,20,20,10))
        }, height = 700, width = 700)
    
    ##Linear regression values and calculations
    output$linearequation <- renderText({
        linear_reg <- lm(formula = depth_grad ~ temp_grad, data = data_input1())
        paste0("y = ", signif(coef(linear_reg)[2],3),"x + ", signif(coef(linear_reg)[1],3))
    })
    
    output$lineartempOutput <- renderText({
        linear_reg <- lm(formula = depth_grad ~ temp_grad, data = data_input1())
        linear_calc <- signif(((input$regressionDepthInput - coef(linear_reg)[1])/coef(linear_reg)[2]), digits = 3)
        paste0("Calculated temperature: ",linear_calc," C")
    })
    
    ##Exp regression values and calculations
    output$expequation <- renderText({"y = ae<sup>(bx)</sup>"})
    
    output$exptempOutput <- renderText({
        a <- input$initializeA
        b <- input$initializeB
        
        exp_calc <- signif((log(input$regressionDepthInput/a))/b, digits = 3)
        paste0("Calculated temperature: ",exp_calc," C")
    })

#################PLOT HYDROCARBONS###############################################     
    #dataframe of input values from user
    data_input2 <- reactive({
        data.frame(
            ratio = c(input$ratio1, input$ratio2, input$ratio3, input$ratio4,
                      input$ratio5, input$ratio6, input$ratio7, input$ratio8),
            temp = c(input$temp1, input$temp2, input$temp3, input$temp4,
                     input$temp5, input$temp6, input$temp7, input$temp8)
        )
    })
    
    output$coolplot <- renderPlot({
        ggplot() +
            geom_path(data = technote30, aes(x = anom_C1.C2, y = temp_C),
                      color = "grey20", size = 2) +
            geom_area(data = technote30, aes(x = anom_C1.C2, y = temp_C),
                      fill = "grey80") +
            geom_path(data = technote_normal, aes(x = dashed_x, y = dashed_y),
                      size = 0.5, color = "gray20", linetype = 2) +
            geom_path(data = technote_normal, aes(x = left_norm_x, y = left_norm_y),
                      size = 0.5, color = "gray20") +
            geom_path(data = technote_normal, aes(x = right_norm_x, y = right_norm_y),
                      size = 0.5, color = "gray20") +
            geom_polygon(data=technote_normal,
                         aes(x = shade_x, y = shade_y), fill="blue", alpha=0.2) +
            geom_point(data = data_input2(), aes(x = ratio, y = temp),
                       shape = 24, color = "black", fill = "red", size = 5, stroke = 1) +
            scale_y_reverse(breaks = c(seq(100, 0, by = -5))) +
            scale_x_log10(position = "top", labels = function(x) format(x, scientific = FALSE)) +
            annotation_logticks(sides = "t", short = unit(0.2, "cm"),
                                mid = unit(0.30, "cm"),
                                long = unit(0.40,"cm")) +
            annotate("text", x=40, y=10, size = 5, label= "Anomalous") +
            annotate("text", x=800, y=45, size = 5, label= "Normal") +
            annotate("text", x=40, y=75, size = 5, angle = 70, label= "High TOC (2%)") +
            annotate("text", x=450, y=80, size = 5, angle = 72, label= "Low TOC (0.5%)") +
            coord_cartesian(expand = c(0,0), xlim = c(10, 100000), ylim = c(100,0)) +
            theme_classic() +
            labs(x = "Methane/Ethane (C1/C2)", y = "temperature (C)") +
            theme(axis.ticks.length = unit(0.18, "cm"),
                  panel.border = element_rect(colour = "black", fill=NA, size=2),
                  axis.line = element_blank(),
                  axis.text = element_text(size = 14),
                  axis.title = element_text(size = 16),
                  plot.margin = margin(10,25,10,10))
    }, height = 900, width = 800)
}

# Run the application 
shinyApp(ui = ui, server = server)
