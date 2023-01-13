library(shiny)
library(shinydashboard)


ui <- dashboardPage(
  title = "GCR Display Cores", #website title
  header = dashboardHeader(title = "GCR Display Cores"),
  dashboardSidebar(disable = TRUE),
  # sidebar = dashboardSidebar(width = "0px"),
  body = dashboardBody(
    fluidRow( #row 1
      box(width = 6,
        title = "Leg 1, Site 2, Core 5R, Section 2",
        status = "primary",
        solidHeader = TRUE,
        collapsible = TRUE,
        column(width = 6, align = "center",
               h3("Calcite caprock"),
               img(src='1-2-5R-2.png'),
               h4("Sigsbee Basin"),
               h5("Gulf of Mexico")),
        column(width = 6,
               h4("Calcite caprock; extremely porous aggregate of calcite crystals"),
               hr(),
               h4("Approximate Age: 66 - 164 Ma"),
               hr(),
               fluidRow(
                 column(width = 5, tags$a(href="http://deepseadrilling.org/cores/leg001/2.5R.PDF", "Core image", target="_blank")), 
                 column(width = 4, tags$a(href="http://deepseadrilling.org/01/volume/dsdp01_02.pdf", "Reports", target="_blank")),
                 column(width = 3, tags$a(href="http://deepseadrilling.org/01/volume/dsdp01_02.pdf", "VCD", target="_blank"))
               )) #app link
      ),
      box(width = 6,
        title = "Leg 42A, Site 372, Core 8R, Section 2",
        status = "primary",
        solidHeader = TRUE,
        collapsible = TRUE,
        column(width = 6, align = "center",
               h3("Evaporite"),
               img(src='42A-372-8R-2.png'),
               h4("Menorca Rise"),
               h5("Mediterranean")),
        column(width = 6,
               h4("Cruise planned to provide information on the environment just prior to the deposition 
                  of the Messinian evaporites; to then test models of the evaporite origin"),
               hr(),
               h4("Approximate Age: 5.3 - 11.6 Ma"),
               hr(),
               fluidRow(
                 column(width = 5, tags$a(href="http://deepseadrilling.org/cores/leg042/372.8R.PDF", "Core image", target="_blank")), 
                 column(width = 4, tags$a(href="http://deepseadrilling.org/42_1/volume/dsdp42pt1_03.pdf", "Reports", target="_blank")),
                 column(width = 3, tags$a(href="http://deepseadrilling.org/42_1/volume/dsdp42pt1_03.pdf", "VCD", target="_blank"))
               )) #app link
      )),
    fluidRow( #row 2
      box(width = 6,
          title = "Leg 112, Site 686B, Core 5H, Section 4",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Laminated intervals"),
                 img(src='112-686B-5H-4.png'),
                 h4("West Pisco Basin"),
                 h5("Peru Margin")),
          column(width = 6,
                 h4("This site was selected (1) to obtain a high-resolution record of upwelling and climatic 
                histories from Quaternary and possibly Neogene sediments, (2) to calculate mass accumulation rates 
                of biogenic constituents from an upwelling regime, and (3) to document in detail early diagenetic 
                reactions and products specific to the coastal upwelling environment."),
                 hr(),
                 h4("Approximate Age: 0 - 2.6 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/112_IR/VOLUME/CORES/IMAGES/686B5H.PDF","Core image", target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/112_IR/VOLUME/CHAPTERS/ir112_18.pdf", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/112_IR/VOLUME/CHAPTERS/ir112_18.pdf", "VCD", target="_blank"))
                 )) #app link
      ),
      box(width = 6,
          title = "Leg 136, Site 842B, Core 3H, Section 4",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Red clay/icthyoliths"),
                 img(src='136-843B-3H-4.png'),
                 h4("Hawaiian Arch"),
                 h5(" ")),
          column(width = 6,
                 h4("The principal objective of operations at Site 842 was the installation of a reentry 
                    cone on the seafloor and the casing of a hole to basement for use as a test site for the Ocean Seismic Network."),
                 hr(),
                 h4("Approximate Age: 11.6 - 37.8 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/136_IR/VOLUME/CORES/IMAGES/842B3H.PDF","Core image", target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/136_IR/VOLUME/CHAPTERS/ir136_04.pdf", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/136_IR/VOLUME/CHAPTERS/cor_0842.pdf", "VCD", target="_blank"))),
                 h5("Sections 5 and 6 also available.")) #app link
          
      )),
    fluidRow( #row 3
      box(width = 6,
          title = "Leg 143, Site 868B, Core 2R, Section 1",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Boundstone (sponges in growth position)"),
                 img(src='143-868A-2R-1.png'),
                 h4("Resolution Guyot"),
                 h5("western Mid-Pacific Mountains")),
          column(width = 6,
                 h4("The objective of this site was to (1) to examine the biota and vertical development of a 
                    Cretaceous reef, (2) to determine the cause and timing of drowning, and (3) to determine the 
                    magnitude of relative changes in sea level and karsting."),
                 hr(),
                 h4("Approximate Age: 100 - 113 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/143_IR/VOLUME/CORES/IMAGES/868A2R.PDF","Core image", target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/143_IR/VOLUME/CHAPTERS/ir143_08.pdf", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/143_IR/VOLUME/CHAPTERS/cor_0867-868.pdf", "VCD", target="_blank"))
                 )) #app link
      ),
      box(width = 6,
          title = "Leg 145, Site 881B, Core 18H, Section 2",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Siliceous ooze (clayey diatom & ash layers)"),
                 img(src='145-881B-18H-2.png'),
                 h4("Subarctic Pacific Ocean"),
                 h5(" ")),
          column(width = 6,
                 h4("The sediments of this site contain a critical record of late Mesozoic and Cenozoic 
                    oceanographic and climatic changes; paleoceanography and paleoclimatology of the North Pacific Ocean."),
                 hr(),
                 h4("Approximate Age: 11,700 yrs - 2.6 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CORES/IMAGES/881B18H.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CHAPTERS/ir145_03.pdf", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CHAPTERS/cor_0881.pdf", "VCD", target="_blank"))),
                 h5("Sections 1, 3, 4, 5, 6, 7 and CC also available.")) #app link
          
      )),
    fluidRow( #row 4
      box(width = 6,
          title = "Leg 145, Site 882A, Core 11H, Section #########",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Siliceous ooze (diatom) with dropstone"),
                 img(src='143-868A-2R-1.png'),
                 h4("Subarctic Pacific Ocean"),
                 h5(" ")),
          column(width = 6,
                 h4("The sediments of this site contain a critical record of late Mesozoic and Cenozoic 
                    oceanographic and climatic changes; paleoceanography and paleoclimatology of the North Pacific Ocean."),
                 hr(),
                 h4("Approximate Age: 0 - 3.6 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/143_IR/VOLUME/CORES/IMAGES/868A2R.PDF","Core image", target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/143_IR/VOLUME/CHAPTERS/ir143_08.pdf", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/143_IR/VOLUME/CHAPTERS/cor_0867-868.pdf", "VCD", target="_blank"))
                 )) #app link
      ),
      box(width = 6,
          title = "Leg 145, Site 881B, Core 18H, Section 2",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Siliceous ooze (clayey diatom & ash layers)"),
                 img(src='145-881B-18H-2.png'),
                 h4("Subarctic Pacific Ocean"),
                 h5(" ")),
          column(width = 6,
                 h4("The sediments of this site contain a critical record of late Mesozoic and Cenozoic 
                    oceanographic and climatic changes; paleoceanography and paleoclimatology of the North Pacific Ocean."),
                 hr(),
                 h4("Approximate Age: 11,700 yrs - 2.6 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CORES/IMAGES/881B18H.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CHAPTERS/ir145_03.pdf", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CHAPTERS/cor_0881.pdf", "VCD", target="_blank"))),
                 h5("Sections 1, 3, 4, 5, 6, 7 and CC also available.")) #app link
          
      ))
  )
)

server <- function(input, output, session) {
#########---Output Map---#######################################################
  
   
}

shinyApp(ui = ui, server = server)