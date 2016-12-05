library(shiny)
library(NonCompart)  
library(markdown)
library(pastecs)
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggiraph)

navbarPage(
    title = "Online NonCompart",
    ### 1 ###
    tabPanel(
        title = "Data upload",
        sidebarLayout(
            sidebarPanel(
                fileInput("file1", 'Choose CSV File with "SUBJECT", "TIME", "CONC" (case-insensitive)',
                          accept = c(
                              "text/csv",
                              "text/comma-separated-values,text/plain",
                              ".csv")
                ),
                radioButtons(
                    inputId = "Dataset", label = "Dataset",
                    choices = c("CSV" = "CSV",
                      "Theoph (N=12)" = "Theoph",
                      "Indometh (N=6)" = "Indometh",
                      "sd_oral_richpk (N=50)" = "sd_oral_richpk",
                      "sd_iv_rich_pkpd (N=60)" = "sd_iv_rich_pkpd"),
                    selected = "Theoph"),
                #tags$hr(),
                checkboxInput("NCAlog", "AUC Calculation by Log", TRUE),
                sliderInput(
                    inputId = "NCAdose",  
                    label = "Dose (mg)", 
                    min = 0, max = 1000, value = 320, step = 5, round=0),
                helpText('If dosing is unknown or diverse, choose 0 (zero).'),
                radioButtons("NCAadm", "Administration route",
                             c("Oral or Extravascular" = "Extravascular",
                               "Intravenous Bolus" = "Bolus",
                               "Intravenous Infusion" = "Infusion")),
                sliderInput('NCAinfusion', 'Intravenous Infusion time (hr)', min=0, max=10,
                            value=0, step=0.1)
            ),
            
            mainPanel(
                tableOutput("contents")
            )
        )
    ),
    ### 2 ###
    tabPanel(
        title = "Results", 
        tags$h3("Individual Parameters"),
        tableOutput("NCAresults"),
        tags$h3("Descriptive Statistics"),
        tableOutput("NCAdesc"),
        includeMarkdown("parameters.md")
    ),
    ### 3 ###
    tabPanel(
        title = "Official Report",
        verbatimTextOutput("NCAreport")
    ),
    ### 3A ###
    tabPanel(
        title = "CDISC Report",
        textInput("StudyID", "Study ID", ""),
        textInput("Drug", "Drug", ""),
        tags$h3("PP"),
        tableOutput("PP"),
        tags$h3("PC"),
        tableOutput("PC")
    ),
    ### 4 ###
    tabPanel(
        title = "Plots",
        sidebarLayout(
            sidebarPanel(
                radioButtons("LogY", "Y axis",
                             c("Log"="Log",
                               "Linear"="Linear")
                )
            ),
            mainPanel(
                ggiraph::ggiraphOutput("plot")
            )
        )
    ),
    ### 5 ###
    tabPanel(
        title = "Help", 
        includeMarkdown("help.md")
    )
)
