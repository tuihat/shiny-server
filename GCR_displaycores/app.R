#GCR Display Cores
#started: 11 January 2023
#updated: 2 November 2023
#Laurel Childress; childress@iodp.tamu.edu

###############################################################################
# This site previews core sections in the GCR that ready for quick display to 
#...students, visitors, and scientists. A preview image is provided, as well as 
#...a brief overview of the location, science, and age of the material. Links 
#...to the digital core image, the Initial Report/Proceedings Volume, and the 
#...visual core description (VCD) are also provided.
###############################################################################

#Packages
if(!require(shiny)){ #check if the package is installed and sourced
  install.packages("shiny") #if not, install the package
  library(shiny) #and source the package 
}

if(!require(shinydashboard)){ #check if the package is installed and sourced
  install.packages("shinydashboard") #if not, install the package
  library(shinydashboard) #and source the package
}
###############################################################################
ui <- dashboardPage(
  title = "GCR Display Cores", #website title
  header = dashboardHeader(title = "GCR Display Cores"),
  dashboardSidebar(disable = TRUE),
  # sidebar = dashboardSidebar(width = "0px"),
  body = dashboardBody(
    tags$head(includeHTML(("google_analytics.html"))),
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
          title = "Leg 145, Site 882A, Core 11H, Section 1",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Siliceous ooze (diatom) with dropstone"),
                 img(src='145-882A-11H-1.png'),
                 h4("Subarctic Pacific Ocean"),
                 h5(" ")),
          column(width = 6,
                 h4("The sediments of this site contain a critical record of late Mesozoic and Cenozoic 
                    oceanographic and climatic changes; paleoceanography and paleoclimatology of the North Pacific Ocean."),
                 hr(),
                 h4("Approximate Age: 0 - 3.6 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CORES/IMAGES/882A11H.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CHAPTERS/ir145_04.pdf", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CHAPTERS/cor_0882.pdf", "VCD", target="_blank"))),
                 h5("Sections 2, 3, 4, 5, 6, 7 and CC also available.")) #app link
      ),
      box(width = 6,
          title = "Leg 145, Site 882A, Core 12H, Section 2",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Siliceous diatom ooze"),
                 img(src='145-882A-12H-2.png'),
                 h4("Subarctic Pacific Ocean"),
                 h5(" ")),
          column(width = 6,
                 h4("The sediments of this site contain a critical record of late Mesozoic and Cenozoic 
                    oceanographic and climatic changes; paleoceanography and paleoclimatology of the North Pacific Ocean."),
                 hr(),
                 h4("Approximate Age: 2.6 - 11.6 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CORES/IMAGES/882A12H.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CHAPTERS/ir145_04.pdf", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/145_IR/VOLUME/CHAPTERS/cor_0882.pdf", "VCD", target="_blank"))),
                 h5("Sections 1, 3, 4, 5, 6, 7 and CC also available.")) #app link
      )),
    fluidRow( #row 5
      box(width = 6,
          title = "Leg 146, Site 893A, Core 15H, Section 3",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Well laminated silty clay"),
                 img(src='146-893A-15H-3.png'),
                 h4("Santa Barbara Basin"),
                 h5(" ")),
          column(width = 6,
                 h4("During the late Quaternary, an absence of burrowing organisms allowed the preservation of 
                    annual laminations caused by seasonal changes in sediment supply and character. The sediments 
                    are rich in organic carbon and microbial methane. The sequence represents deposition at high 
                    sedimentation rates in suboxic to oxic conditions and contains diatoms, radiolarians, 
                    foraminifers, and pollen in sufficient abundance, thus providing an important opportunity 
                    for high- to ultra-high-resolution paleoclimatic/paleoenvironmental investigation."),
                 hr(),
                 h4("Approximate Age: 11,700 - 129,000 yrs"),
                 hr(),
                 fluidRow(
                   column(width = 5,tags$a(href="http://www-odp.tamu.edu/publications/146_1_IR/VOLUME/CORES/IMAGES/893A15H.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/146_2_IR/VOLUME/CHAPTERS/ir146pt2_02.pdf","Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/146_2_IR/VOLUME/CHAPTERS/cor_0893.pdf", "VCD", target="_blank")))) #app link
      ),
      box(width = 6,
          title = "Leg 146, Site 893A, Core 21H, Section 5",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Yearly laminated sediments"),
                 img(src='146-893A-21H-5.png'),
                 h4("Santa Barbara Basin"),
                 h5(" ")),
          column(width = 6,
                 h4("During the late Quaternary, an absence of burrowing organisms allowed the preservation of 
                    annual laminations caused by seasonal changes in sediment supply and character. The sediments 
                    are rich in organic carbon and microbial methane. The sequence represents deposition at high 
                    sedimentation rates in suboxic to oxic conditions and contains diatoms, radiolarians, 
                    foraminifers, and pollen in sufficient abundance, thus providing an important opportunity 
                    for high- to ultra-high-resolution paleoclimatic/paleoenvironmental investigation."),
                 hr(),
                 h4("Approximate Age: 11,700 - 129,000 yrs"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/146_1_IR/VOLUME/CORES/IMAGES/893A21H.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/146_2_IR/VOLUME/CHAPTERS/ir146pt2_02.pdf", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/146_2_IR/VOLUME/CHAPTERS/cor_0893.pdf", "VCD", target="_blank"))),
                 h5("Section 4 also available.")) #app link
          
      )),
    fluidRow( #row 6
      box(width = 6,
          title = "Leg 147, Site 895C, Core 4R, Section 2",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Dunite matrix, impregnated by gabbroic melt"),
                 img(src='147-895C-4R-2.png'),
                 h4("Hess Deep"),
                 h5("East Pacific Rise")),
          column(width = 6,
                 h4("This section demonstrates the evolution of crustal processes at a fast-spreading ridge."),
                 hr(),
                 h4("Approximate Age: unknown"),
                 hr(),
                 fluidRow(
                   column(width = 5,tags$a(href="http://www-odp.tamu.edu/publications/147_IR/VOLUME/CORES/IMAGES/895C4R.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/147_IR/VOLUME/CHAPTERS/ir147_01.pdf","Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/147_IR/VOLUME/CHAPTERS/cor_0895.pdf", "VCD", target="_blank")))) #app link
      ),
      box(width = 6,
          title = "Leg 168, Site 1023A, Core 5H, Section 3",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Hemipelagic turbidite"),
                 img(src='168-1023A-5H-3.png'),
                 h4("Juan de Fuca Ridge"),
                 h5(" ")),
          column(width = 6,
                 h4("This expedition focused on exploring the causes and consequences of ridge-flank hydrothermal circulation 
                 by drilling a suite of relatively shallow holes that allowed observations of lateral gradients of temperature, 
                 pressure, fluid composition, and rock alteration."),
                 hr(),
                 h4("Approximate Age: 0 - 2.6 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/168_IR/CORES/1023A5H.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/168_IR/01_CHAP.PDF", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/168_IR/VCD1023.PDF", "VCD", target="_blank")))
                 #h5("Section 4 also available.")) #app link
          )
      )),
    fluidRow( #row 7
      box(width = 6,
          title = "Leg 169, Site 1033C, Core 3H, Section 4",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Finely laminated diatom mud"),
                 img(src='169-1033C-3H-4.png'),
                 h4("Saanich Inlet"),
                 h5("fjord in southeastern Vancouver Island")),
          column(width = 6,
                 h4("This expedition investigated the ultra-high resolution paleoecologic record of the inshore northeast Pacific for the 
                 last 8,000 − 10,000 yr or so using organic remains preserved in Saanich Inlet sediments.Studies focussed on organic 
                    diagenesis and low-temperature remineralization reactions in a shallow, temperate, isolated anoxic basin."),
                 hr(),
                 h4("Approximate Age: 0 - 11,700 yrs"),
                 hr(),
                 fluidRow(
                   column(width = 5,tags$a(href="http://www-odp.tamu.edu/publications/169S_IR/CORES/1033C3H.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/169S_IR/CHAP_02.PDF","Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/169S_IR/VCD1033.PDF", "VCD", target="_blank")))) #app link
      ),
      box(width = 6,
          title = "Leg 199, Site 1215B, Core 1H, Section 4",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Red clay"),
                 img(src='199-11215B-1H-4.png'),
                 h4("Molokai Fracture Zone"),
                 h5("equatorial Pacific")),
          column(width = 6,
                 h4("This expedition was to study the evolution of the equatorial Pacific current and wind 
                 system as Earth went from maximum Cenozoic warmth to initial Antarctic glaciations."),
                 hr(),
                 h4("Approximate Age: 0 - 56 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/199_IR/VOLUME/CORES/IMAGES/1215B1H.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/199_IR/chap_08/chap_08.htm", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/199_IR/VOLUME/CORES/COR_1215.PDF", "VCD", target="_blank"))),
                 h5("Section 1, 2, 3, 5, 6, 7, and CC also available.")) #app link
      )),
    fluidRow( #row 8
      box(width = 6,
          title = "Leg 199, Site 1218A, Core 1H, Section 2",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Siliceous ooze (radiolarian clay)"),
                 img(src='199-1218A-1H-2.png'),
                 h4("Clipperton Fracture Zone"),
                 h5("equatorial Pacific")),
          column(width = 6,
                 h4("The goal of this expedition was to study the evolution of the equatorial Pacific current 
                 and wind system as Earth went from maximum Cenozoic warmth to initial Antarctic glaciations. 
                 This is the sole site to be drilled on the 40-Ma transect during Leg 199 and will be used to 
                 investigate paleoceanographic processes in the equatorial Paleogene Pacific Ocean during the inferred 
                 transition of Earth's climate from the early Paleogene 'greenhouse' into the late Paleogene 'icehouse'."),
                 hr(),
                 h4("Approximate Age: 0 - 23 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5,tags$a(href="http://www-odp.tamu.edu/publications/199_IR/VOLUME/CORES/IMAGES/1218A1H.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/199_IR/chap_11/chap_11.htm","Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/199_IR/VOLUME/CORES/COR_1218.PDF", "VCD", target="_blank"))),
                 h5("Section 1, 3, 4, 5, 6, and CC also available.")) #app link
      ),
      box(width = 6,
          title = "Leg 199, Site 1218A, Core 24X, Section 2",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Eocene/Oligocene (E/O) boundary"),
                 img(src='199-1218A-24X-2.png'),
                 h4("Clipperton Fracture Zone"),
                 h5("equatorial Pacific")),
          column(width = 6,
                 h4("The goal of this expedition was to study the evolution of the equatorial Pacific current 
                 and wind system as Earth went from maximum Cenozoic warmth to initial Antarctic glaciations. 
                 This is the sole site to be drilled on the 40-Ma transect during Leg 199 and will be used to 
                 investigate paleoceanographic processes in the equatorial Paleogene Pacific Ocean during the inferred 
                 transition of Earth's climate from the early Paleogene 'greenhouse' into the late Paleogene 'icehouse'."),
                 hr(),
                 h4("Approximate Age: 33.4 - 33.9 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/199_IR/VOLUME/CORES/IMAGES/1218A24X.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/199_IR/chap_11/chap_11.htm", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/199_IR/VOLUME/CORES/COR_1218.PDF", "VCD", target="_blank"))),
                 h5("Section 1 also available.")) #app link
      )),
    fluidRow( #row 9
      box(width = 6,
          title = "Leg 199, Site 1220B, Core 20X, Section 2",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Paleocene-Eocene thermal maximum (PETM)"),
                 img(src='199-1220B-20X-2.png'),
                 h4("between the Clipperton and Clarion Fracture Zones"),
                 h5("equatorial Pacific")),
          column(width = 6,
                 h4("The goal of this expedition was to study the evolution of the equatorial Pacific 
                    current and wind system as Earth went from maximum Cenozoic warmth to initial Antarctic 
                    glaciations and to study equatorial ocean circulation from the late Paleocene through 
                    the late Eocene during the early Cenozoic thermal maximum."),
                 hr(),
                 h4("Approximate Age: 55.5 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5,tags$a(href="http://www-odp.tamu.edu/publications/199_IR/VOLUME/CORES/IMAGES/1220B20X.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/199_IR/chap_13/chap_13.htm","Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/199_IR/VOLUME/CORES/COR_1220.PDF", "VCD", target="_blank"))),
                 h5("Section CC also available.")) #app link
      ),
      box(width = 6,
          title = "Leg 202, Site 1241A, Core 3H, Section 3",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Calcareous ooze (nannofossil-foraminifer ooze, with ash layer)"),
                 img(src='202-1241A-3H-3.png'),
                 h4("Guatemala Basin"),
                 h5("southeast Pacific")),
          column(width = 6,
                 h4("The goal of this expedition was to provide a continuous late Neogene sedimentary 
                    sequence to assess variability of upper-ocean processes, including the reorganization of 
                    equatorial Pacific surface circulation and the development of the Atlantic to Pacific 
                    salinity contrast, both associated with the closure of the Isthmus of Panama and other 
                    late Neogene climate changes."),
                 hr(),
                 h4("Approximate Age: 0 - 11 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://www-odp.tamu.edu/publications/202_IR/VOLUME/CORES/IMAGES/1241A3H.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/202_IR/chap_12/chap_12.htm", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/202_IR/VOLUME/CORES/COR_1241.PDF", "VCD", target="_blank"))),
                 h5("Section 4 also available.")) #app link
      )),
    fluidRow( #row 10
      box(width = 6,
          title = "Leg 206, Site 1256D, Core 13R, Section 1",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Extrusive basalt"),
                 img(src='206-1256D-13R-1.png'),
                 h4("Cocos Plate"),
                 h5("eastern equatorial Pacific")),
          column(width = 6,
                 h4("The goal of this expedition was to drill in situ ocean crust, which formed at a superfast spreading rate ~15 m.y. ago."),
                 hr(),
                 h4("Approximate Age: unknown"),
                 hr(),
                 fluidRow(
                   column(width = 5,tags$a(href="http://www-odp.tamu.edu/publications/206_IR/VOLUME/CORES/IMAGES/1256D13R.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://www-odp.tamu.edu/publications/206_IR/chap_03/chap_03.htm","Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://www-odp.tamu.edu/publications/206_IR/VOLUME/CORES/COR_1256.PDF", "VCD", target="_blank"))))
                 # h5("Section CC also available.")) #app link
      ),
      box(width = 6,
          title = "Leg 310, Site M0015A, Core 30R, Section 1",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Coral"),
                 img(src='310-M0015A-30R-1.png'),
                 h4("MSP: Maraa, Tahiti"),
                 h5("western Pacific")),
          column(width = 6,
                 h4("The goal of this expedition was to establish the course of last deglacial 
                 sea level rise at Tahiti, to define sea-surface temperature variations for the 
                 region over the period 20,000 – 10,000 cal. y BP, and to analyze the impact of 
                 sea level changes on reef growth and geometry."),
                 hr(),
                 h4("Approximate Age: 11,700 - 12,900 years"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://publications.iodp.org/proceedings/310/EXP_REPT/CORES/IMAGES/0015A30R.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://publications.iodp.org/proceedings/310/106/106_.htm", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://publications.iodp.org/proceedings/310/EXP_REPT/CORES/COR_MET.PDF", "VCD", target="_blank"))),
                 h5("Section CC also available.")) #app link
      )),
    fluidRow( #row 11
      box(width = 6,
          title = "Leg 310, Site M0023A, Core 11R, Section 1",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Coral (overlapping laminated microbialites)"),
                 img(src='310-M0023A-11R-1.png'),
                 h4("MSP: Maraa, Tahiti"),
                 h5("western Pacific")),
          column(width = 6,
                 h4("The goal of this expedition was to establish the course of last deglacial 
                 sea level rise at Tahiti, to define sea-surface temperature variations for the 
                 region over the period 20,000 – 10,000 cal. y BP, and to analyze the impact of 
                 sea level changes on reef growth and geometry."),
                 hr(),
                 h4("Approximate Age: 11,700 - 12,900 years"),
                 hr(),
                 fluidRow(
                   column(width = 5,tags$a(href="http://publications.iodp.org/proceedings/310/EXP_REPT/CORES/IMAGES/0023A11R.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://publications.iodp.org/proceedings/310/107/107_.htm","Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://publications.iodp.org/proceedings/310/EXP_REPT/CORES/COR_TIR.PDF", "VCD", target="_blank"))))
          # h5("Section CC also available.")) #app link
      ),
      box(width = 6,
          title = "Leg 312, Site 1256D, Core 176R, Section 1",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Vertical basalt dyke"),
                 img(src='312-1256D-176R-1.png'),
                 h4("Cocos Plate"),
                 h5("eastern equatorial Pacific")),
          column(width = 6,
                 h4("The goal of this expedition was to recover, for the first time, a complete 
                    section of the upper oceanic crust from extrusive lavas down through the 
                    dikes and into the uppermost gabbros."),
                 hr(),
                 h4("Approximate Age: ~15 Ma"),
                 hr(),
                 fluidRow(
                   column(width = 5, tags$a(href="http://publications.iodp.org/proceedings/309_312/EXP_REPT/CORES/IMAGES/1256D176R.PDF","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://publications.iodp.org/proceedings/309_312/103/103_.htm", "Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://publications.iodp.org/proceedings/309_312/EXP_REPT/CORES/1256_2.PDF", "VCD", target="_blank"))))
      )),
    fluidRow( #row 12
      box(width = 6,
          title = "Leg 345, Site U1415P, Core 14R, Section 1",
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          column(width = 6, align = "center",
                 h3("Olivine gabbro"),
                 img(src='345-U1415P-14R-1.png'),
                 h4("Hess Deep"),
                 h5("East Pacific Rise")),
          column(width = 6,
                 h4("The goal of this expedition was to sample lower crustal primitive 
                    gabbroic rock that formed at the fast-spreading East Pacific Rise (EPR) 
                    in order to test competing models of magmatic accretion and the intensity of hydrothermal cooling at depth."),
                 hr(),
                 h4("Approximate Age: unknown"),
                 hr(),
                 fluidRow(
                   column(width = 5,tags$a(href="https://web.iodp.tamu.edu/filesR/FileGet-LORE?recordid=21005081","Core image",target="_blank")),
                   column(width = 4, tags$a(href="http://publications.iodp.org/proceedings/345/113/113_.htm","Reports", target="_blank")),
                   column(width = 3, tags$a(href="http://publications.iodp.org/proceedings/345/EXP_REPT/CORES/CORU1415P.PDF", "VCD", target="_blank"))))
          # h5("Section CC also available.")) #app link
      )),
    tags$i("These are not official IODP-JRSO applications 
                                    and functionality is not guaranteed. User assumes all risk."), #italic disclaimer
  br(),
  tags$i("Questions, comments, concerns, compliments: shinylaurelwebmaster@gmail.com")
  )
)

server <- function(input, output, session) {
#########---Output Map---#######################################################
  
   
}

shinyApp(ui = ui, server = server)