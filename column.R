library(shiny)
library(shinydashboard)
library(leaflet)
library(data.table)

ui <- pageWithSidebar(
    headerPanel("CSV Viewer"),
    sidebarPanel(
        fileInput('file1', 'Choose CSV File',
                  accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
        tags$hr(),
        checkboxInput('header', 'Header', TRUE),
        checkboxGroupInput("inCheckboxGroup",
                           "Checkbox group input:",
                           c("label 1" = "option1",
                             "label 2" = "option2")),
        radioButtons('sep', 'Separator',
                     c(Comma=',',
                       Semicolon=';',
                       Tab='\t'),
                     'Comma'),
        radioButtons('quote', 'Quote',
                     c(None='',
                       'Double Quote'='"',
                       'Single Quote'="'"),
                     'Double Quote'),
        
        uiOutput("choose_columns")
    ),
    mainPanel(
        tableOutput('contents')
        
        
    )
)



server <- function(input, output,session) {
    dsnames <- c()
    
    data_set <- reactive({
        inFile <- input$file1
        
        if (is.null(inFile))
            return(NULL)
        
        data_set<-read.csv(inFile$datapath, header=input$header, 
                           sep=input$sep, quote=input$quote)
    })
    output$contents <- renderTable({
        
        data_set()
    })
    
    observe({
        dsnames <- names(data_set())
        cb_options <- list()
        cb_options[ dsnames] <- dsnames
        updateCheckboxGroupInput(session, "inCheckboxGroup",
                                 label = "Check Box Group",
                                 choices = cb_options,
                                 selected = "")
        # }
    })
    
    
    output$choose_dataset <- renderUI({
        selectInput("dataset", "Data set", as.list(data_sets))
    })
    
    
    
    
    # Check boxes
    output$choose_columns <- renderUI({
        # If missing input, return to avoid error later in function
        if(is.null(input$dataset))
            return()
        
        # Get the data set with the appropriate name
        
        colnames <- names(contents)
        
        # Create the checkboxes and select them all by default
        checkboxGroupInput("columns", "Choose columns", 
                           choices  = colnames,
                           selected = colnames)
    })
    
}

shinyApp(ui, server)