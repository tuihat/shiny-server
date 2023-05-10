library(dplyr)
library(data.table)
library(shiny)
library(shinythemes)
library(shinyWidgets)


#load data
LIMS2_DSDP_NGDC <- read.csv("LIMS2_dsdp_NGDClinks_dt.csv")
LIMS2_DSDP_JANUS <- read.csv("LIMS2_dsdp_links_final.csv")
LIMS2_ODP_NGDC <- read.csv("ODP_NGDC_LIMS2.csv")
LIMS2_ODP_NGDC_leg_sum <- read.csv("ODPNGDC_leg_summary.csv", check.names = FALSE)
LIMS2_ODP_NGDC_hole_sum <- fread("ODPNGDC_hole_summary.csv") #special for the degree symbols in coordinates
LIMS2_ODP_NGDC_core_sum <- read.csv("ODPNGDC_core_summary.csv", check.names = FALSE)
LIMS2_ODP_NGDC_sect_sum <- read.csv("ODPNGDC_section_summary.csv", check.names = FALSE)
LIMS2_ODP_JANUS <- read.csv("LIMS2_odp_janus_links_final.csv")
LIMS2_IODP_NGDC <- read.csv("IODP_NGDC_LIMS2.csv")
LIMS2_IODP_JANUS <- read.csv("LIMS2_iodp_janus_links_final.csv")
LIMS2_ZENODO <- read.csv("LIMS2_Zenodo2.csv")


#what to do based on the program type
DSDP <- c("1","2","3","4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96")
ODP <- c("100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "123", "124", "125", "126", "127", "128", "129", "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "144", "145", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210")
IODP_NGDC <- c("301", "303", "304", "305", "306", "307", "308", "309", "310", "311")
IODP <- c("301", "302", "303", "304", "305", "306", "307", "308", "309", "310", "311", "312", "320T", "320", "321", "323", "324", "317", "318", "327", "328", "329", "330", "334", "335", "336", "339", "340T", "340", "342", "344", "345", "341S", "341", "346", "349", "350", "351", "352", "353", "354", "355", "356", "359", "360", "361", "362T", "364", "362", "363", "366", "367", "368", "371", "369", "372", "374", "375", "376", "368X", "379", "382", "383", "379T", "385", "378", "384", "390C", "395E", "395C", "396", "391","392", "390", "393", "397T", "397")

data_types_DSDP_NGDC <- c("Hole Summary", "Core and Section Summary", "Visual Core Description (VCD)", "Hard Rock Description", 
                          "Smear Slide Description", "Computer Generated Core Description", "Spinner Magnetometer - Discrete Sediments", 
                          "AF Demagnetization - Sediments", "Spinner Magnetometer - Long Core", "Magnetic Remanence - Hard Rock", 
                          "Magnetic Curie Temperature - Hard Rock", "Density and Porosity", "Gamma Ray Attenuation Bulk Density", "Grain Size", 
                          "Sonic Velocity", "Vane Shear", "Interstitial Water Chemistry", "Major Elements - Hard Rock", "Minor Elements - Hard Rock", 
                          "Age Profile", "XRD - Bulk", "XRD - Clay", "XRD - Silt", "X-ray Mineralogy - Bulk", "X-ray Mineralogy - Clay", 
                          "X-ray Mineralogy - Silt", "Algae", "Ammonite", "Aptychi", "Archaeomonad", "Benthic Foraminifera", "Bryozoan", 
                          "Carbon and Carbonate", "Crinoids", "Calcispherulide", "Diatoms", "Dinoflagellate", "Ebridians & Actinicidians", "Fish Debris",
                          "Nannofossil", "Ostracod", "Plantic Foraminifera", "Phytolitharia", "Pollen", "Radiolaria", "Rhyncollite", "Silicoflagellate", 
                          "Trace Fossils")
data_types_DSDP_JANUS <- c("Samples", "Core Composite Images", "Core Closeup Images")
data_types_DSDP_all <- c("Hole Summary", "Core and Section Summary", "Visual Core Description (VCD)", "Hard Rock Description", 
                         "Smear Slide Description", "Computer Generated Core Description", "Spinner Magnetometer - Discrete Sediments", 
                         "AF Demagnetization - Sediments", "Spinner Magnetometer - Long Core", "Magnetic Remanence - Hard Rock", 
                         "Magnetic Curie Temperature - Hard Rock", "Density and Porosity", "Gamma Ray Attenuation Bulk Density", "Grain Size", 
                         "Sonic Velocity", "Vane Shear", "Interstitial Water Chemistry", "Major Elements - Hard Rock", 
                         "Minor Elements - Hard Rock", "Age Profile", "XRD - Bulk", "XRD - Clay", "XRD - Silt", "X-ray Mineralogy - Bulk", 
                         "X-ray Mineralogy - Clay", "X-ray Mineralogy - Silt", "Algae", "Ammonite", "Aptychi", "Archaeomonad", "Benthic Foraminifera",
                         "Bryozoan", "Carbon and Carbonate", "Crinoids", "Calcispherulide", "Diatoms", "Dinoflagellate", "Ebridians & Actinicidians", 
                         "Fish Debris", "Nannofossil", "Ostracod", "Plantic Foraminifera", "Phytolitharia", "Pollen", "Radiolaria", "Rhyncollite",
                         "Silicoflagellate", "Trace Fossils", "Samples", "Core Composite Images", "Core Closeup Images")
data_types_ODP_NGDC_sum <- c("Leg Summary", "Hole Summary", "Core Summary", "Section Summary")
data_types_ODP_NGDC_txt <- c("Age", "CHNS and Carbonate - Summary", 
                             "Section Summary - Detailed", "Gamma Ray Attenuation Bulk Density - Summary", "Description - Sediments", 
                             "Hole Summary - Detailed", "Description - Smear Slide Detail", "Description - Smear Slide Summary", "Shear Strength",  
                             "CHNS and Carbonate - Detailed", "Moisture & Density - Detailed", "Moisture & Density - Summary", 
                             "Magnetism - Detailed", "Thermal Conductivity", "Automated Vane Shear", "Borehole Water", "Interstitial Water - Summary", 
                             "Interstitial Water - Detail", "P-wave Velocity, Discrete3", "Source Rock Analysis (RockEval) - Summary", 
                             "Source Rock Analysis (RockEval) - Detailed", "Velocity", "Gas Elements - Summary", "Gas Elements - Detailed", 
                             "Gamma Ray Attenuation Bulk Density - Detailed", "Description - Veins", "Description - Thin Section", "Magnetism - Summary",
                             "Torvane", "Description - Hard Rock", "Magnetic Susceptibilty - Summary", "Magnetic Susceptibilty - Detailed", 
                             "Downhole Temperature", "X-ray Fluorescence - Summary", "X-ray Fluorescence - Detailed",  "P-wave Logger", 
                             "Penetrometer", "Natural Gamma Radiation", "P-wave Velocity, Discrete1", "P-wave Velocity, Discrete2", 
                             "X-ray Diffraction - Summary", "Reflectance Spectroscopy and Colorimetry", "Elemental Composition - ICP")
data_types_ODP_NGDC_file <- c("Visual Core Descriptions - Sediment","Paleontology", "Visual Core Descriptions - Hard Rock", 
                              "XRD Scanned Documents", "Visual Core Descriptions - Structural","X-ray Diffraction - Detailed")
data_types_ODP_NGDC <- c("Leg Summary", "Hole Summary", "Core Summary", "Section Summary", "Hole Summary - Detailed", "Section Summary - Detailed",
                         "Visual Core Descriptions - Sediment", "Visual Core Descriptions - Hard Rock", "Visual Core Descriptions - Structural",
                         "Description - Sediments", "Description - Hard Rock", "Description - Smear Slide Summary", 
                         "Description - Smear Slide Detail", "Description - Veins",
                         "Description - Thin Section", "Paleontology",
                         "Magnetism - Summary", "Magnetism - Detailed", "Magnetic Susceptibilty - Summary", "Magnetic Susceptibilty - Detailed",
                         "Gamma Ray Attenuation Bulk Density - Summary", "Gamma Ray Attenuation Bulk Density - Detailed",
                         "Moisture & Density - Summary", "Moisture & Density - Detailed",
                         "Natural Gamma Radiation", "P-wave Logger", "Velocity", "P-wave Velocity, Discrete1", "P-wave Velocity, Discrete2", 
                         "P-wave Velocity, Discrete3",
                         "Reflectance Spectroscopy and Colorimetry", "Shear Strength", "Automated Vane Shear", "Torvane", "Penetrometer", 
                         "Downhole Temperature", "Thermal Conductivity",
                         "Borehole Water", "Interstitial Water - Summary", 
                         "Interstitial Water - Detail", "Elemental Composition - ICP", "CHNS and Carbonate - Summary",
                         "CHNS and Carbonate - Detailed", "Source Rock Analysis (RockEval) - Summary", "Source Rock Analysis (RockEval) - Detailed",
                         "Gas Elements - Summary", "Gas Elements - Detailed", 
                         "X-ray Fluorescence - Summary", 
                         "X-ray Fluorescence - Detailed", "X-ray Diffraction - Summary", "X-ray Diffraction - Detailed", "XRD Scanned Documents",
                         "Age")
data_types_ODP_JANUS <- c("Samples", "Core Composite Images", "Core Closeup Images", "Thin Section Images")
data_types_IODP_NGDC_txt <- c("Description - Smear Slide", "Magnetic Remanence", 
                             "Magnetic Susceptibilty - Summary1", "Magnetic Susceptibilty - Summary2", "Magnetic Susceptibilty - Detailed",
                             "Gamma Ray Attenuation Bulk Density", "P-wave Velocity Logger", "P-wave Velocity, Discrete1", 
                             "P-wave Velocity, Discrete2", "P-wave Velocity, Discrete3", "Moisture & Density", "Natural Gamma Radiation", 
                             "Vane Shear Strength (AVS)", "Vane Shear Strength (Torvane)", "Compressional Strength (Penetrometer)",
                             "Color Reflectance", "RGB Channels",  "Thermal Conductivity", "Noncontact Resistivity", 
                             "Interstitial Water", "CHNS and Carbonate", "Elemental Composition - ICP", "Gas Elements", "X-ray Diffraction - Summary", 
                              "Foraminifers - All2", "Foraminifers - Benthic2", "Foraminifers - Planktonic2", 
                             "Paleontology - Range")
data_types_IODP_NGDC_file <- c("Visual Core Descriptions - Sediment and Rock", "Visual Core Descriptions - Structural","X-ray Diffraction - Data")
data_types_IODP_NGDC <- c("Visual Core Descriptions - Sediment and Rock", 
                          "Visual Core Descriptions - Structural", "Description - Smear Slide", "Magnetic Remanence", 
                          "Magnetic Susceptibilty - Summary1", "Magnetic Susceptibilty - Summary2", "Magnetic Susceptibilty - Detailed",
                          "Gamma Ray Attenuation Bulk Density", "P-wave Velocity Logger", "P-wave Velocity, Discrete1", 
                          "P-wave Velocity, Discrete2", "P-wave Velocity, Discrete3", "Moisture & Density", "Natural Gamma Radiation", 
                          "Vane Shear Strength (AVS)", "Vane Shear Strength (Torvane)", "Compressional Strength (Penetrometer)",
                          "Color Reflectance", "RGB Channels",  "Thermal Conductivity", "Noncontact Resistivity", 
                          "Interstitial Water", "CHNS and Carbonate", "Elemental Composition - ICP", "Gas Elements",  "X-ray Diffraction - Summary", 
                          "X-ray Diffraction - Data", "Foraminifers - All2", "Foraminifers - Benthic2", "Foraminifers - Planktonic2", 
                          "Paleontology - Range")
data_types_IODP_JANUS <- c("Samples", "Core Composite Images", "Core Closeup Images", "Thin Section Images")
data_types_ZENODO <- c("Hole Summary", "Hole Drilling Summary", "Core Summary", 
                       "Core Drilling Summary", "Section Summary", "Rig instrumentation", 
                       "Subsea camera", "Sample Report", "Piece Log", "Visual Core Description", 
                       "Micropaleontology", "Core Composite Images", "Section-Half Images", 
                       "Whole-Round Section Images", "Whole-Round Composite 360 Images", "Closeup Images", "Thin Section Images", 
                       "Photomicrographs", "SEM Images", "Magnetic Remanence (SRM longcore)", 
                       "Magnetic Remanence (SRM discrete)", "Magnetic Remanence (spinner)", 
                       "Core Orientation", "Magnetic Susceptibility (Whole-Round)", 
                       "Magnetic Susceptibility (Section-Half)", 
                       "Magnetic Susceptibility (Kappabridge)", "Bulk Density (GRA)", 
                       "Bulk and Grain Density (MAD)", "Natural Gamma Radiation", "P-wave Velocity Logger (Whole-Round)", 
                       "P-wave Velocity Caliper (Section/Discrete)", "P-wave Velocity Bayonet (Section)", 
                       "Color Reflectance", "Laser Height Profile (Section-Half)", "RGB Channels", "Vane Shear Strength (AVS)", 
                       "Vane Shear Strength (Torvane)", "Compressional Strength (Penetrometer)", 
                       "Downhole Temperature", "Thermal Conductivity", "Interstitial Water Composite Report", 
                       "Alkalinity and pH", "Salinity", "Ion Chromatography", "Titration", 
                       "Spectrophotometry", "ICP-AES Elemental Analysis (IW)", "ICP-AES Elemental Analysis (Solids)", 
                       "Carbonates Analysis Report", "Inorganic Carbon (Coulometer)", 
                       "Elemental Analysis (CHNS)", "Source Rock Analysis", "Gas Elements", "Perfluorocarbon Tracers (PFT)",
                       "X-ray Diffraction (XRD)", "Portable X-ray Fluorescence (PXRF)", 
                       "Shore X-ray Summary (XRF)", "Affine and Splice Tables", "Downhole Logging", 
                       "Navigation", "Bathymetry", "Towed Magnetometer")
data_headers_ZENODO <- c("Operations", "Operations", "Operations", "Operations", 
                         "Operations", "Operations", "Operations", "Curation", "Curation", 
                         "Descriptive Information", "Descriptive Information", "Images", "Images", 
                         "Images", "Images", "Images", "Images", "Images", "Images", "Magnetism", 
                         "Magnetism", "Magnetism", "Magnetism", "Magnetism", "Magnetism", "Magnetism", 
                         "Physical Properties", "Physical Properties", "Physical Properties", 
                         "Physical Properties", "Physical Properties", "Physical Properties", 
                         "Physical Properties", "Physical Properties", "Physical Properties", 
                         "Physical Properties", "Physical Properties", "Physical Properties", 
                         "Physical Properties", "Physical Properties", "Chemistry", "Chemistry", "Chemistry", 
                         "Chemistry", "Chemistry", "Chemistry", "Chemistry", "Chemistry", "Chemistry", 
                         "Chemistry", "Chemistry", "Chemistry", "Chemistry", "Chemistry", 
                         "X-ray", "X-ray", "X-ray", "Stratigraphic Correlation", "Logging", 
                         "Underway", "Underway", "Underway")


ui <- fluidPage(theme = shinytheme("spacelab"),
                navbarPage("LIMS2 - Electric Boogaloo", #title of the whole app
                           tabPanel(title = HTML(paste("<center>About", "the App</center>", sep = "<br/>")), #Tab - App Intro
                                    h2("Welcome to LIMS2"),
                                    h4("This is an application for easier and faster access to
                                       data from the Deep Sea Drilling Project (DSDP), the Ocean Drilling Program (ODP), 
                                       and beyond that is not stored in the Laboratory Information Management System (LIMS)."),
                                    tags$a(href="https://web.iodp.tamu.edu/LORE/", "LIMS Database",
                                           target="_blank"),
                                    br(), br(),
                                    h2("Quick Start Guide"),
                                    h4("Use the tabs at the top to choose a scientific ocean drilling program. Within a 
                                       tab select the leg/expedition, site, and data type (as appropriate) to locate your data."),
                                    br(),
                                    h2("Additional Information"),
                                    h4("DSDP (Deep Sea Drilling Project) and ODP (Ocean Drilling Program) data are stored at the
                                    NOAA National Centers for Environmental Information (NCEI) 
                                    formerly known as NGDC (National Geophysical Data Center). The National Geophysical Data Center (NGDC) 
                                       and its sister data centers merged into the National Centers for Environmental Information (NCEI)."),
                                    h4("Some data from Integrated Ocean Drilling Program (IODP 2003-2013) and International Ocean Discovery
                                       Program (IODP 2013-2024) is also stored at NCEI, but not all data is present."),
                                    br(),
                                    h4("Janus Web Database: Janus has been used to collect data since ODP Leg 171A (January 1997), 
                                    and data collected prior to Leg 171A are added to Janus as time permits. With the exception of 
                                    Summary data (Hole, Core, Section), much of the data
                                       that appears accessible within the LIMS Overview is actually stored within the Janus Web Database.
                                       This includes images from DSDP, ODP, and IODP Exp 310-311 which are not available online through
                                       NCEI and are provided in this app in separate tabs for completeness."),
                                    tags$a(href="https://web.iodp.tamu.edu/janusweb/links/links_all.shtml", "Janus Web Database Queries",
                                           target="_blank"),
                                    br(), br(),
                                    h4("Zenodo: Zenodo is a general-purpose open repository which allows researchers to deposit 
                                       research papers, data sets, research software, reports, and any other related digital assets.
                                       Currently, a random selection of IODP Expedition data has been uploaded. Searches for data
                                       stored in Zenodo can be time consuming and this app attempts to provide a more user-friendly
                                       access point to IODP Zenodo data."),
                                    tags$a(href="https://zenodo.org/communities/iodp/", "IODP Zenodo",
                                           target="_blank")), #app link),
                           tabPanel(title = HTML(paste("<center>DSDP", "Leg 1-96</center>", sep = "<br/>")),#"DSDP Data Tab
                                    fluidRow(
                                      column(width = 3,
                                             pickerInput('input1.3', 'Data:', 
                                               choices = data_types_DSDP_NGDC,
                                               # selected = 'placeholder1',
                                               # options = pickerOptions(`actions-box` = TRUE),
                                               multiple = F)),
                                      column(width = 3,
                                            pickerInput('input1', 'Leg:', 
                                              choices = DSDP,
                                              # selected = 1,
                                              options = pickerOptions(`actions-box` = TRUE),
                                              multiple = T)),
                                      column(width = 3,
                                            pickerInput('input1.2', 'Site/Hole:', 
                                              choices = 'placeholder1',
                                              # selected = 'placeholder1',
                                              options = pickerOptions(`actions-box` = TRUE),
                                              multiple = T)),
                                    column(width = 3,
                                           br(),
                                           downloadButton("downloadNGDC", "Download selected data"))),
                                    br(),
                                    DT::dataTableOutput("DSDP_table"),
                                    tags$head(tags$style(".datatables .display {margin-left: 0;}")),
                                    br(), br(),
                                    "To access all datasets: ",
                                    tags$a(href="https://www.ngdc.noaa.gov/mgg/geology/data/glomar_challenger/all_dsdp_data_by_type/", 
                                           "NCEI DSDP Data by Type",
                                           target="_blank"), #app link
                                    br(),
                                    "To access data by DSDP Leg: ",
                                    tags$a(href="https://www.ngdc.noaa.gov/mgg/geology/dsdp/data/dsdpdata.htm", 
                                           "NCEI DSDP Data by Leg",
                                           target="_blank"), #app link
                                    br(),
                                    "Documentation of data types: ",
                                    tags$a(href="https://www.ngdc.noaa.gov/mgg/geology/data/glomar_challenger/doc/docs.htm", 
                                           "NCEI Documentation",
                                           target="_blank")), #app link
                           #####################################################
                           tabPanel(title = HTML(paste("<center>DSDP Images", "Leg 1-96</center>", sep = "<br/>")), #"DSDP Images App
                                    tags$i("Please note that this application will only function while the Janus Web Database exists. DSDP Images
                                           can also be retrieved by contacting the NCEI. Due to their volume, these data 
                                           are not available online through NCEI, but are archived and available on request.",
                                           style = "color: red; font-size: 20px;"), br(), br(),
                                    tags$i("Not happy about that? Complain (loudly) before JANUS is dismantled.",
                                           style = "color: red; font-size: 20px;"),br(), br(),
                                    fluidRow(
                                      column(width = 3,
                                             pickerInput('input11', 'Leg:', 
                                                         choices = DSDP,
                                                         selected = 1,
                                                         options = pickerOptions(`actions-box` = TRUE),
                                                         multiple = F))),
                                    br(),
                                    DT::dataTableOutput("DSDP_images_table"),
                                    tags$head(tags$style(".datatables .display {margin-left: 0;}")),
                                    br(), br()),
                           #####################################################
                           tabPanel(title = HTML(paste("<center>ODP Data", "Leg 100-210</center>", sep = "<br/>")), #"ODP Data App
                                    fluidRow(
                                      column(width = 3,
                                             pickerInput('input2.1', 'Leg:', 
                                                choices = ODP,
                                                # selected = 123,
                                                options = pickerOptions(`actions-box` = TRUE),
                                                multiple = F)),
                                      column(width = 3,
                                             pickerInput('input2.2', 'Site/Hole:', 
                                               choices = 'placeholder1',
                                               # selected = 123,
                                               options = pickerOptions(`actions-box` = TRUE),
                                               multiple = F)),
                                      column(width = 3,
                                             pickerInput('input2.3', 'Data:', 
                                               choices = 'placeholder2',
                                               # selected = 123,
                                               options = pickerOptions(`actions-box` = TRUE),
                                               multiple = F))),
                                    h5("Data issues (ex. - bad delimiters) are common with NCEI ODP data. If you are experiencing issues,
                                    try refreshing the page, or accessing the data directly using the link."),
                                    hr(),
                                    uiOutput("ODP_link"),
                                    tags$head(tags$style(HTML("#ODP_link {font-size: 15px;}"))),
                                    hr(),
                                    textOutput("ODP_folder_link"),
                                    tags$head(tags$style(HTML("#ODP_folder_link {font-size: 20px;}"))),
                                    br(),
                                    DT::dataTableOutput("ODP_sum_table"),
                                    DT::dataTableOutput("ODP_txt_table"),
                                    tags$head(tags$style(".datatables .display {margin-left: 0;}")),
                                    br(),
                                    uiOutput("ODP_link2"),
                                    br(),
                                    "JOIDES Resolution Data: ",
                                    tags$a(href="https://www.ngdc.noaa.gov/mgg/geology/data/joides_resolution/", 
                                           "NCEI JR Data",
                                           target="_blank"), #app link
                                    br(),
                                    "Documentation of data types: ",
                                    tags$a(href="https://www.ngdc.noaa.gov/mgg/geology/data/joides_resolution/documentation/", 
                                           "NCEI Documentation",
                                           target="_blank")), #app link
                           #####################################################
                           tabPanel(title = HTML(paste("<center>ODP Images", "Leg 100-210</center>", sep = "<br/>")),#"ODP Images App
                                    tags$i("Please note that this application will only function while the Janus Web Database exists. ODP Images
                                           can also be retrieved by contacting the NCEI. Due to their volume, these data 
                                           are not available online through NCEI, but are archived and available on request.",
                                           style = "color: red; font-size: 20px;"), br(), br(),
                                    tags$i("Not happy about that? Complain (loudly) before JANUS is dismantled.",
                                           style = "color: red; font-size: 20px;"),br(), br(),
                                    fluidRow(
                                      column(width = 3,
                                             pickerInput('input22', 'Leg:', 
                                                         choices = ODP,
                                                         selected = 100,
                                                         options = pickerOptions(`actions-box` = TRUE),
                                                         multiple = F))),
                                    br(),
                                    DT::dataTableOutput("ODP_images_table"),
                                    tags$head(tags$style(".datatables .display {margin-left: 0;}")),
                                    br(), br()),
                           #####################################################
                           tabPanel(title = HTML(paste("<center>IODP Data", "Exp 301-311</center>", sep = "<br/>")), #"IODP Data App
                                    fluidRow(
                                      column(width = 3,
                                             pickerInput('input4.1', 'Expedition:', 
                                                         choices = IODP_NGDC,
                                                         # selected = 123,
                                                         options = pickerOptions(`actions-box` = TRUE),
                                                         multiple = F)),
                                      column(width = 3,
                                             pickerInput('input4.2', 'Site/Hole:', 
                                                         choices = 'placeholder1',
                                                         # selected = 123,
                                                         options = pickerOptions(`actions-box` = TRUE),
                                                         multiple = F)),
                                      column(width = 3,
                                             pickerInput('input4.3', 'Data:', 
                                                         choices = 'placeholder2',
                                                         # selected = 123,
                                                         options = pickerOptions(`actions-box` = TRUE),
                                                         multiple = F))),
                                    h5("Data issues (ex. - bad delimiters) are common with NCEI data. If you are experiencing issues,
                                    try refreshing the page, or accessing the data directly using the link."),
                                    hr(),
                                    uiOutput("IODP_NGDC_link"),
                                    tags$head(tags$style(HTML("#IODP_link {font-size: 15px;}"))),
                                    hr(),
                                    textOutput("IODP_folder_link"),
                                    tags$head(tags$style(HTML("#IODP_folder_link {font-size: 20px;}"))),
                                    br(),
                                    # DT::dataTableOutput("IODP_sum_table"),
                                    DT::dataTableOutput("IODP_txt_table"),
                                    tags$head(tags$style(".datatables .display {margin-left: 0;}")),
                                    br(),
                                    uiOutput("IODP_link2"),
                                    br(),
                                    "JOIDES Resolution Data: ",
                                    tags$a(href="https://www.ngdc.noaa.gov/mgg/geology/data/joides_resolution/", 
                                           "NCEI JR Data",
                                           target="_blank"), #app link
                                    br(),
                                    "Documentation of data types: ",
                                    tags$a(href="https://www.ngdc.noaa.gov/mgg/geology/data/joides_resolution/documentation/", 
                                           "NCEI Documentation",
                                           target="_blank")), #app link
                           #####################################################
                           tabPanel(title = HTML(paste("<center>IODP Images", "Exp 301-311</center>", sep = "<br/>")),#"IODP Images App
                                    tags$i("Please note that this application will only function while the Janus Web Database exists. Images
                                           can also be retrieved by contacting the NCEI. Due to their volume, these data 
                                           are not available online through NCEI, but are archived and available on request.",
                                           style = "color: red; font-size: 20px;"), br(), br(),
                                    tags$i("Not happy about that? Complain (loudly) before JANUS is dismantled.",
                                           style = "color: red; font-size: 20px;"),br(), br(),
                                    fluidRow(
                                      column(width = 3,
                                             pickerInput('input42', 'Expedition:', 
                                                         choices = IODP_NGDC,
                                                         selected = 301,
                                                         options = pickerOptions(`actions-box` = TRUE),
                                                         multiple = F))),
                                    br(),
                                    DT::dataTableOutput("IODP_images_table"),
                                    tags$head(tags$style(".datatables .display {margin-left: 0;}")),
                                    br(), br()),
                           #####################################################
                           tabPanel(title = HTML(paste("<center>IODP Data", "Zenodo</center>", sep = "<br/>")),#"IODP Data - Zenodo
                                    pickerInput('input3', 'Expedition:', 
                                                choices = unique(LIMS2_ZENODO$leg_exp),
                                                selected = 362,
                                                options = pickerOptions(`actions-box` = TRUE),
                                                multiple = T),
                                    br(),
                                    h5("Data is added to Zenodo at random times, in no particular order, and is difficult to search for. Therefore this
                                       application may not reflect all available IODP Zenodo data, 
                                       especially if it was recently added. (last check: April 2023)"),
                                    br(),
                                    DT::dataTableOutput("IODP_table"),
                                    h6("'no data available' = data does not exist in another database to publish in Zenodo"),
                                    h6("'not published' = this data may or may not exist elsewhere. For data available through
                                       LIMS, 'not published' indicates that data exists but was not published in Zenodo. For
                                       other data types (ex. - DATA1) it is unknown whether this data exists."))),
                br(), br(),
                tags$head(includeHTML(("google_analytics.html"))),
                tags$style(type="text/css",
                           ".shiny-output-error { visibility: hidden; }",
                           ".shiny-output-error:before { visibility: hidden; }"
                ),
                tags$i("These are not official IODP-JRSO applications 
                                    and functionality is not guaranteed. User assumes all risk."), #italic disclaimer
                br(),
                tags$i("Questions, comments, concerns, compliments: shinylaurelwebmaster@gmail.com")
  
)

server <- function(input, output, session) {
#########---DSDP Data - APP #1---####################################################
################################################################################ 
  observeEvent(input$input1, { ##Limit site/hole choices based on Leg
    column_levels <- with(LIMS2_DSDP_NGDC, site[leg_exp %in% input$input1])
    updatePickerInput(session, "input1.2", choices = column_levels, selected = column_levels)
  })
  
  DSDP_NGDC_df <- reactive({ #make the df from the NGDC online data tables
    req(input$input1)
      NGDC <- subset(LIMS2_DSDP_NGDC, leg_exp %in% input$input1)
      names(NGDC)[3:50] <- data_types_DSDP_NGDC
      NGDC2 <- NGDC[, c("leg_exp","site", input$input1.3)]
      NGDC2
      NGDC2_link <- NGDC2[1,3]
      NGDC2_type <- fread(NGDC2_link, quote = "")
      NGDC2_type$sitehole <- paste0(NGDC2_type$site,NGDC2_type$hole)
      NGDC2_type <- subset(NGDC2_type, leg %in% input$input1)
      NGDC2_type <- subset(NGDC2_type, sitehole %in% input$input1.2)
      NGDC2_type
  })
  
  output$DSDP_table <- DT::renderDataTable({ #make the df pretty
    pretty_table <- DSDP_NGDC_df()
    DT::datatable(pretty_table, options = list(pageLength = 10, scrollX = TRUE, autoWidth = TRUE,
                                               columnDefs = list(list(className = 'dt-center', targets=1:ncol(pretty_table)))), 
                  rownames = TRUE, escape = FALSE)
  })
  output$downloadNGDC <- downloadHandler( #download NGDC data
    filename = function() {
      paste("selected_DSDP_NGDCdata", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(DSDP_NGDC_df(), file, row.names = FALSE)
    })
################################################################################
################################################################################
  
#########---DSDP Images - APP #1.2---###########################################
################################################################################
  DSDP_JANUS_df <- reactive({ #make the df from the NGDC online data tables
    new_df <- subset(LIMS2_DSDP_JANUS, leg_exp == input$input11)
    new_df <- new_df[,-1] #drop the exp column
    new_df$site <- paste0("Site ", new_df$site)
    new_df <- as.data.frame(new_df)
    new_df2 <- t(new_df)
    colnames(new_df2) <- new_df2[1,]
    new_df2 <- new_df2[-1,]
    new_df2
    rownames(new_df2) <- data_types_DSDP_JANUS
    for(i in 1:nrow(new_df2)) {# for-loop over columns
      for(j in 1:ncol(new_df2)){
        if (new_df2[i,j] != "not available") {
          new_df2[i,j] <- paste0("<a href='",new_df2[i,j],"' target='_blank'>",rownames(new_df2)[i],"</a>")}
        else{}
      }}
    new_df2
  })
  
  output$DSDP_images_table <- DT::renderDataTable({ #make the df pretty
    pretty_table <- DSDP_JANUS_df()
    DT::datatable(pretty_table, options = list(pageLength = 20, scrollX = TRUE, autoWidth = TRUE,
                                               columnDefs = list(list(className = 'dt-center', targets=1:ncol(pretty_table)))), 
                  rownames= TRUE, escape = FALSE)
  })

################################################################################
################################################################################

#########---ODP - APP #2---####################################################
################################################################################ 
  choose_ODP_Exp <- reactive({
    new_df <- subset(LIMS2_ODP_NGDC, Leg == input$input2.1)
    new_df2 <- unique(new_df$sitehole)
    new_df2
  })
  
  choose_ODP_Site <- reactive({
    new_df <- subset(LIMS2_ODP_NGDC, Leg == input$input2.1)
    new_df <- subset(new_df, sitehole == input$input2.2)
    new_df2 <- unique(new_df$long_name)
    new_df2 <- new_df2[order(match(new_df2,data_types_ODP_NGDC))]
    new_df2
  })
  
  observeEvent(input$input2.1, { #use Program to limit Exp choices
    updatePickerInput(session, "input2.2", choices = choose_ODP_Exp())
    updatePickerInput(session, "input2.3", choices = choose_ODP_Site())
  })
  
  observeEvent(input$input2.2, { #use Program to limit Exp choices
    updatePickerInput(session, "input2.3", choices = choose_ODP_Site())
  })
  
  choose_ODP_data <- reactive({
    new_df <- subset(LIMS2_ODP_NGDC, Leg == input$input2.1)
    new_df <- subset(new_df, sitehole == input$input2.2)
    new_df2 <- subset(new_df, long_name == input$input2.3)
    new_df2
  })
  
  ##############################################################################
  ODP_summ_choice <- reactive({
    req(input$input2.3 %in% data_types_ODP_NGDC_sum)
    if(input$input2.3 == "Leg Summary") {
      NGDC_summ <- subset(LIMS2_ODP_NGDC_leg_sum, Leg == input$input2.1)
      NGDC_summ
    } else if(input$input2.3 == "Hole Summary") {
      NGDC_summ <- subset(LIMS2_ODP_NGDC_hole_sum, Leg == input$input2.1)
      temp_site <- as.numeric(gsub("\\D", "", input$input2.2))
      temp_hole <- gsub('[0-9]+', '', input$input2.2)
      NGDC_summ <- subset(NGDC_summ, Site == temp_site)
      NGDC_summ2 <- subset(NGDC_summ, Hole == temp_hole)
      NGDC_summ2
    } else if(input$input2.3 == "Core Summary") {
      NGDC_summ <- subset(LIMS2_ODP_NGDC_core_sum, Leg == input$input2.1)
      temp_site <- as.numeric(gsub("\\D", "", input$input2.2))
      temp_hole <- gsub('[0-9]+', '', input$input2.2)
      NGDC_summ <- subset(NGDC_summ, Site == temp_site)
      NGDC_summ2 <- subset(NGDC_summ, Hole == temp_hole)
      NGDC_summ2
    } else if(input$input2.3 == "Section Summary") {
      NGDC_summ <- subset(LIMS2_ODP_NGDC_sect_sum, Leg == input$input2.1)
      temp_site <- as.numeric(gsub("\\D", "", input$input2.2))
      temp_hole <- gsub('[0-9]+', '', input$input2.2)
      NGDC_summ <- subset(NGDC_summ, Site == temp_site)
      NGDC_summ2 <- subset(NGDC_summ, Hole == temp_hole)
      NGDC_summ2
    } 
  })
  output$ODP_sum_table <- DT::renderDataTable({ #make the df pretty
    if(input$input2.3 %in% data_types_ODP_NGDC_sum){
    pretty_table <- ODP_summ_choice()
    DT::datatable(pretty_table, options = list(pageLength = 20, scrollX = TRUE, autoWidth = TRUE,
                                               columnDefs = list(list(className = 'dt-center', targets=1:ncol(pretty_table)))),
                  rownames= TRUE, escape = FALSE)
    }
  })
  # ##############################################################################
  ODP_txt_choice <- reactive({
    req(input$input2.3 %in% data_types_ODP_NGDC_txt)
    new_df3 <- choose_ODP_data()
    link <- paste0(new_df3$ngdc_link)
    NGDC_txt <- fread(link, quote = "")
    NGDC_txt
  })

  output$ODP_txt_table <- DT::renderDataTable({ #make the df pretty
    req(input$input2.3 %in% data_types_ODP_NGDC_txt)
    pretty_table <- ODP_txt_choice()
    DT::datatable(pretty_table, options = list(pageLength = 20, scrollX = TRUE, autoWidth = TRUE,
                                               columnDefs = list(list(className = 'dt-center', targets=1:ncol(pretty_table)))),
                  rownames= TRUE, escape = FALSE)
  })
  # ##############################################################################
  ODP_file_choice <- reactive({
    req(input$input2.3 %in% data_types_ODP_NGDC_file)
    statement <- "Multiple files are available for this data type. Use link above."
  })
  output$ODP_folder_link <- renderText({
    ODP_file_choice()
  })
  # ##############################################################################
  ODP_select <- reactive({ #link to specific dataset
    df <- choose_ODP_data()
    link2 <- paste0(df$ngdc_link)
    url <- a(link2, href=link2, target = "_blank")
    })

  output$ODP_link <- renderUI({ #link to specific dataset
    tagList("Data source: ", ODP_select())
  })
  
  ODP_select2 <- reactive({ #see the entire expedition
    link2 <- paste0("https://www.ngdc.noaa.gov/mgg/geology/data/joides_resolution/", input$input2.1)
    url <- a(link2, href=link2, target = "_blank")
  })
  
  output$ODP_link2 <- renderUI({ #see the entire expedition
    tagList("See all data from this expedition: ", ODP_select2())
  })
################################################################################ 
#########---ODP Images - APP #2.2---###########################################
################################################################################
  ODP_JANUS_df <- reactive({ #make the df from the NGDC online data tables
    new_df <- subset(LIMS2_ODP_JANUS, leg_exp == input$input22)
    new_df <- new_df[,-1] #drop the exp column
    site_holder <- paste0("Site ", new_df$site)
    new_df <- as.data.frame(new_df)
    new_df2 <- t(new_df)
    new_df2 <- data.frame(new_df2[-1,])
    colnames(new_df2) <- site_holder
    rownames(new_df2) <- data_types_ODP_JANUS
    for(i in 1:nrow(new_df2)) {# for-loop over columns
      for(j in 1:ncol(new_df2)){
        if (new_df2[i,j] != "no data available") {
          new_df2[i,j] <- paste0("<a href='",new_df2[i,j],"' target='_blank'>",rownames(new_df2)[i],"</a>")}
        else{}
      }}
    new_df2
  })
  
  output$ODP_images_table <- DT::renderDataTable({ #make the df pretty
    pretty_table <- ODP_JANUS_df()
    DT::datatable(pretty_table, options = list(pageLength = 20, scrollX = TRUE, autoWidth = TRUE,
                                               columnDefs = list(list(className = 'dt-center', targets="_all"))), 
                  rownames= TRUE, escape = FALSE)
  })
  
################################################################################
################################################################################
  
  #########---IODP - NGDC - APP #4---####################################################
  ################################################################################ 
  choose_IODP_Exp <- reactive({
    new_df <- subset(LIMS2_IODP_NGDC, Leg == input$input4.1)
    new_df2 <- unique(new_df$sitehole)
    new_df2
  })
  
  choose_IODP_Site <- reactive({
    new_df <- subset(LIMS2_IODP_NGDC, Leg == input$input4.1)
    new_df <- subset(new_df, sitehole == input$input4.2)
    new_df2 <- unique(new_df$long_name)
    new_df2 <- new_df2[order(match(new_df2,data_types_IODP_NGDC))]
    new_df2
  })
  
  observeEvent(input$input4.1, { #use Program to limit Exp choices
    updatePickerInput(session, "input4.2", choices = choose_IODP_Exp())
    updatePickerInput(session, "input4.3", choices = choose_IODP_Site())
  })
  
  observeEvent(input$input4.2, { #use Program to limit Exp choices
    updatePickerInput(session, "input4.3", choices = choose_IODP_Site())
  })
  
  choose_IODP_data <- reactive({
    new_df <- subset(LIMS2_IODP_NGDC, Leg == input$input4.1)
    new_df <- subset(new_df, sitehole == input$input4.2)
    new_df2 <- subset(new_df, long_name == input$input4.3)
    new_df2
  })
  
  ##############################################################################
  # ##############################################################################
  IODP_txt_choice <- reactive({
    req(input$input4.3 %in% data_types_IODP_NGDC_txt)
    new_df3 <- choose_IODP_data()
    link <- paste0(new_df3$ngdc_link)
    NGDC_txt <- fread(link, quote = "")
    NGDC_txt
  })
  
  output$IODP_txt_table <- DT::renderDataTable({ #make the df pretty
    req(input$input4.3 %in% data_types_IODP_NGDC_txt)
    pretty_table <- IODP_txt_choice()
    DT::datatable(pretty_table, options = list(pageLength = 20, scrollX = TRUE, autoWidth = TRUE,
                                               columnDefs = list(list(className = 'dt-center', targets=1:ncol(pretty_table)))),
                  rownames= TRUE, escape = FALSE)
  })
  # ##############################################################################
  IODP_file_choice <- reactive({
    req(input$input4.3 %in% data_types_IODP_NGDC_file)
    statement <- "Multiple files are available for this data type. Use link above."
  })
  output$IODP_folder_link <- renderText({
    IODP_file_choice()
  })
  # ##############################################################################
  IODP_NGDC_select <- reactive({ #link to specific dataset
    df <- choose_IODP_data()
    link2 <- paste0(df$ngdc_link)
    url <- a(link2, href=link2, target = "_blank")
  })
  
  output$IODP_NGDC_link <- renderUI({ #link to specific dataset
    tagList("Data source: ", IODP_NGDC_select())
  })
  
  IODP_select2 <- reactive({ #see the entire expedition
    link2 <- paste0("https://www.ngdc.noaa.gov/mgg/geology/data/joides_resolution/", input$input4.1)
    url <- a(link2, href=link2, target = "_blank")
  })
  
  output$IODP_link2 <- renderUI({ #see the entire expedition
    tagList("See all data from this expedition: ", IODP_select2())
  })
  ################################################################################ 
  #########---IODP Images - APP #4.2---###########################################
  ################################################################################
  IODP_JANUS_df <- reactive({ #make the df 
    new_df <- subset(LIMS2_IODP_JANUS, leg_exp == input$input42)
    new_df <- new_df[,-1] #drop the exp column
    site_holder <- paste0("Site ", new_df$site)
    new_df <- as.data.frame(new_df)
    new_df2 <- t(new_df)
    new_df2 <- data.frame(new_df2[-1,])
    colnames(new_df2) <- site_holder
    rownames(new_df2) <- data_types_IODP_JANUS
    for(i in 1:nrow(new_df2)) {# for-loop over columns
      for(j in 1:ncol(new_df2)){
        if (new_df2[i,j] != "no data available") {
          new_df2[i,j] <- paste0("<a href='",new_df2[i,j],"' target='_blank'>",rownames(new_df2)[i],"</a>")}
        else{}
      }}
    new_df2
  })
  
  output$IODP_images_table <- DT::renderDataTable({ #make the df pretty
    pretty_table <- IODP_JANUS_df()
    DT::datatable(pretty_table, options = list(pageLength = 20, scrollX = TRUE, autoWidth = TRUE,
                                               columnDefs = list(list(className = 'dt-center', targets="_all"))), 
                  rownames= TRUE, escape = FALSE)
  })
  
  ################################################################################
  ################################################################################  
#########---IODP - APP #3---####################################################
################################################################################ 
  IODP_select <- reactive({ #choose expedition and determine results
    IODP_result <- subset(LIMS2_ZENODO, leg_exp %in% input$input3)
    IODP_result <- IODP_result[,-1] #drop the exp column
    site_holder <- paste0("Site ", IODP_result$site)
    IODP_result2 <- t(IODP_result)
    IODP_result2 <- data.frame(IODP_result2[-1, ])
    colnames(IODP_result2) <- site_holder
    rownames(IODP_result2) <- data_types_ZENODO
    IODP_result2[is.na(IODP_result2)] = ""

    for(i in 1:nrow(IODP_result2)) {# for-loop over columns
      for(j in 1:ncol(IODP_result2)){
        if (IODP_result2[i,j] != "not published" & IODP_result2[i,j] != "no data available") {
          IODP_result2[i,j] <- paste0("<a href='",IODP_result2[i,j],"' target='_blank'>",colnames(IODP_result2)[j],"</a>")}
        else{}
      }}
    IODP_result2 <- cbind(IODP_result2, data_headers_ZENODO)
    IODP_result2
    })

  output$IODP_table <- DT::renderDataTable({
    pretty_table <- IODP_select()
    DT::datatable(pretty_table, extensions = 'RowGroup', options = list(pageLength = 100, scrollX = TRUE, autoWidth = TRUE,
                                                                        rowGroup = list(dataSrc=c(ncol(pretty_table))),
                                                                        columnDefs = list(list(className = 'dt-center', targets=1:ncol(pretty_table)),
                                                                                          list(visible=FALSE, targets=c(ncol(pretty_table))))),
                  rownames= TRUE, escape = FALSE)
  })
################################################################################ 
   
}

shinyApp(ui = ui, server = server)