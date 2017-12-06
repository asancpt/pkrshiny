input <- list()
input$NCAlog <- "Log"
input$NCAdose <- 320
input$NCAadm <- "Extravascular"
input$NCAinfusion <- 0
NCAtable <- NCA(concData = Theoph, 
                id = "Subject", Time = "Time", conc = "conc", 
                trt = "",
                fit = input$NCAlog,
                dose = input$NCAdose, 
                adm = input$NCAadm, 
                dur = input$NCAinfusion, 
                report = "Table",
                uTime = "h", uConc = "ug/L", uDose = "mg")

gather(NCAtable, key = "Parameter", value = "Value", -Subject)

NCAtable <- NCA(concData = Theoph, 
                id = "Subject", Time = "Time", conc = "conc", 
                trt = "",
                fit = "Log",
                dose = 320, 
                adm = "Extravascular", 
                dur = 0, 
                report = "Table",
                uTime = "h", uConc = "ug/L", uDose = "mg")
?NCA
