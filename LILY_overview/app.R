#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(shinydashboard)
library(shinydashboardPlus)

# Define UI for application that draws a histogram
ui <- dashboardPage(
    title = "About the LILY Database", #website title
    header = dashboardHeader(title = "About the LILY Database"),
    sidebar = dashboardSidebar(width = "0px"),
    body = dashboardBody(
        
        ########################################################################
        fluidRow(
          column(12, align="center",
                 div(style="display: inline-block;",img(src="LILY_logo.jpg", height="20%", width="20%")))),
        h2(HTML("<b>The LILY Database</b>"), style="text-align:center"),
        h3("Linking lithology to IODP physical, chemical, and magnetic properties data", style="text-align:center"),
        h5("During each expedition of the International Ocean Discovery Program and its precursor, the
Integrated Ocean Drilling Program (jointly referred to as IODP), vast arrays of data are collected from drill
cores. These data, which are accessible from the IODP LIMS (Laboratory Information Management System)
database, include physical, chemical, and magnetic properties collected semi‐continuously along cores using
automated track systems, as well as a variety of analyses conducted on discrete subsamples taken from the cores.
In addition, the lithology of all cores is described based on visual characteristics of the surface of split cores,
visual examination of smear slides and thin sections, and compositional or mineralogical information derived
from geochemical analyses. We extract basic lithologic information from this complex array of descriptive
information and then tie that information to all other measurements. This new database is referred to as LIMS
with Lithology (LILY). LILY currently contains over 34 million data from 89 km of core recovered on 42
expeditions conducted 2009–2019. Some uses of LILY include identifying the abundance of different
lithologies, finding data from core intervals with a specific lithology, assessing the efficacy of coring systems in
different lithologies, or characterizing and analyzing physical, chemical, and magnetic properties based on
lithology. We illustrate the use of LILY by computing the grain density by lithology from over 24,000 moisture
and density measurements and then use those grain densities, along with the large IODP bulk density dataset, to
compute a new high‐resolution porosity dataset with over 3.7 million new porosity estimates."),
        tags$a(href="https://doi.org/10.1029/2023GC011287", 
               "Childress, L.B., Acton, G.D., Percuoco, V.P. and M. Hastedt. 2024. The LILY database: Linking lithology to IODP physical, chemical, and magnetic properties data. Geochemistry, Geophysics, Geosystems, 25, e2023GC011287. https://doi.org/10.1029/2023GC011287"),
        ########################################################################
        br(),
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        h3(HTML("<a href='https://zenodo.org/records/10425539'>Access LILY Data on Zenodo</a>")),
        br(),
        h4("Primary Content (DataLITH)"),
        tags$table(style = "width: 100%",
                   tags$tr(tags$td(align = "center","There are 23 main files of the LILY database, which are organized based on data type and end with '_DataLITH.csv'. Each file contains IODP LIMS data paired with lithology and other metadata. The file prefix gives the type of data. For example, AVS_DataLITH.csv contains the Automated Vane Shear (AVS) shear strength data paired with lithology and other metadata. A list of all data types is given in Supporting Information Table S1 of Childress et al. (2024). There are a total of 23 DataLITH files."),
                           tags$td("                                  "),
                           tags$td(style = "width: 70%",
                                   align = "right",
                                   img(src="LILY_DataLITH.jpg", height="80%", width="80%"))
                           )),
        br(),
        h4("Additional Content"),
        br(),
        fluidRow(
          column(width = 5,
        h5(HTML("<b>Original Description Files:</b> RawDESC.zip contains 7,940 .csv files derived from the raw text content of the DESClogik Excel worksheets that was extracted, converted to comma separated value (.csv) format, and put into files with a consistent naming convention, without applying any corrections or conversions to the original text. Each file is the direct extraction of a tab from the DESC workbooks, available at <a href='https://web.iodp.tamu.edu/DESCReport'>https://web.iodp.tamu.edu/DESCReport</a>")),
        br(),
        h5(HTML("<b>Core Summary Files:</b> CoreSUMM.zip contains one file with Core Summary information, which includes the expedition, site, hole, core, coring type, top and bottom depths drilled, advances and recoveries, time and date of recovery, and the number of sections. These data are further paired with additional metadata (expanded core type, latitude, longitude, and water depth). Coordinates and water depth for each hole are derived from LIMS (and the Janus Web Database at <a href='http://www-odp.tamu.edu/database/'>http://www-odp.tamu.edu/database/</a> for older expeditions).")),
        br(),
        h5(HTML("<b>Raw Data Files:</b> RawDATA.zip contains the raw track/discrete dataset downloaded by expedition from IODP LIMS database and placed in folders for each type of data (AVS, CARB, SRM, etc.).")),
        br(),
        h5(HTML("<b>Raw Lithology Files:</b> RawLITH.zip contains 42 .csv files, with one file for each expedition. This is a metadata-cleaned, compiled by expedition version of lithologic descriptions only from the original DESClogik description files. Each file contains all lithologic description (prefix, principal and suffix, etc.) information for an entire expedition, as it was originally described. These have been transformed to a consistent format and paired with consistent identification information and additional metadata. Headers are normalized across all expeditions and SampleID information is standardized.")),
        br(),
        h5(HTML("<b>Cleaned Lithology Files:</b> CleanLITH contains 42 .csv files. Each file contains all lithologic description (prefix, principal and suffix) information for an entire expedition. The lithologic descriptions have been standardized to a consistent nomenclature using the dictionary given in Support Information Table S4 of Childress et al. (2024). These data are further paired with additional metadata (e.g., degree of consolidation, expanded core type, latitude, longitude, and water depth)."))),
        column(width = 7,
               img(src="LILY_F1.jpg", height="100%", width="100%"))),
        ########################################################################
        br(),
        hr(style = "border-top: 1px solid #000000;"), #horizontal line
        tags$i("These are not official IODP-JRSO applications and functionality is 
         not guaranteed. User assumes all risk."), #italic disclaimer
        
        tags$i("Questions, comments, concerns, compliments: shinylaurelwebmaster@gmail.com"),
        tags$head(tags$style(HTML('
        /* logo */
        .skin-blue .main-header .logo {
                              background-color: #f4b943;width: 400px;
                              }

        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
                              background-color: #f4b943;
                              }

        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color: #f4b943;margin-left: 400px;
                              }
            google_analytics.html'))),
        tags$script("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';") 
    )

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

}

# Run the application 
shinyApp(ui = ui, server = server)
