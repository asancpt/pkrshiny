navbarPage(
    title = "pkr Shiny",
    ### 1 ###
    tabPanel(
        title = "Data",
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
    
    ### GROUP ###
    tabPanel(
        title = "Result",
        fluidRow(
            column(4,
                   sliderInput(
                       inputId = "NCAdose",  
                       label = "Set dose (mg)", 
                       min = 0, max = 1000, value = 320, step = 5, round=0),
                   helpText('If dosing amount is unknown, choose 0 (zero).')
            ),
                column(3, offset = 1, 
                   checkboxGroupInput(inputId = "inCheckboxGroup1", choices = "initial", 
                                      label = "or select dose column"),
                   helpText('If selected, value of left slider will be ignored.')
            ),
            column(3, 
                   checkboxGroupInput(inputId = "inCheckboxGroup2", choices = "initial", 
                                      label = "Select TRT column if exists"),
                   helpText('TRT column usually contains R or T. You can select multiple columns if the study has TRT, PRD, SEQ and so on.'),
                   checkboxInput('CarrySort', 'Sort TRT', FALSE)
            )
        ),
        tags$h3("Individual Parameters"),
        tableOutput("NCAgroup"),
        tags$h3("Descriptive Statistics"),
        tableOutput("NCAdesc"),
        includeMarkdown("parameters.md")
    ),
    
    ### 3A ###
    tabPanel(
        title = "Report",
        verbatimTextOutput("NCAreport")
    ),
    ### 3B ###
    tabPanel(
        title = "CDISC",
        textInput("StudyID", "Study ID", ""),
        textInput("Drug", "Drug", ""),
        tags$h3("PP"),
        tableOutput("PP"),
        tags$h3("PC"),
        tableOutput("PC")
    ),
    ### 4 ###
    tabPanel(
        title = "Dynamic",
        helpText('Hovering a cursor over a plot shows dynamic results.'),
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
    ### 20 ###
    tabPanel(
        title = "Plot", 
        helpText('Generating plots takes a while. Please wait.'),
        htmlOutput('plotPK')
    ),
    ### 21 ###
    tabPanel(
        title = "Fit", 
        helpText('Generating plots takes a while. Please wait.'),
        htmlOutput('plotFit')
    ),
    ### 90 ###
    tabPanel(
        title = "Help", 
        #includeMarkdown("README.md")
        htmlOutput('README')
    ),
    ### 99 ###
    tabPanel(
        title = "Contact", 
        includeMarkdown("CONTACT.md"),
        includeHTML("disqus.html")
    )
)
