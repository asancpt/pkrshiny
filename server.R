MyLib<- c("shiny", "pkr", "markdown", "pastecs", "ggplot2", "dplyr", 
          "tidyr", "ggiraph", "shinydashboard", "knitr")
library(shiny)
library(pkr)
library(markdown)
library(pastecs)
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggiraph)
library(shinydashboard)
library(knitr)
#MyLibList <- lapply(MyLib, library, character.only = TRUE)

#Cit <- sapply(MyLib, function(x) citation(x))
#Cit2 <- sapply(Cit, function(x) paste("-", print(x, style = "text")))


# ‘style’ should be one of “text”, “Bibtex”, “citation”, “html”, “latex”, “textVersion”, “R” 

# Dataset Prep ------------------------------------------------------------

Theoph <- read.csv("example/Theoph.csv", as.is = TRUE) %>% 
    mutate(Subject = sprintf("%02d", Subject))
Indometh <- read.csv("example/Indometh.csv", as.is = TRUE) %>% 
    mutate(Subject = sprintf("%02d", Subject))
sd_oral_richpk <- read.csv("example/sd_oral_richpk.csv", as.is = TRUE) %>% 
    mutate(ID = sprintf("%02d", ID))
sd_iv_rich_pkpd <- read.csv("example/sd_iv_rich_pkpd.csv", as.is = TRUE) %>% 
    rename(CONC = COBS) %>% mutate(ID = sprintf("%02d", ID))
Abbr <- read.csv("abbr.csv", stringsAsFactors = FALSE)

# Function Prep -----------------------------------------------------------

PrepNCAsource <- function(INPUT_FILE1, INPUT_DATASET){
    if (is.null(INPUT_FILE1) & INPUT_DATASET == "CSV")
        return(print("None"))
    
    NCAsource <<- if (INPUT_DATASET == "CSV") read.csv(INPUT_FILE1$datapath) 
    else if (INPUT_DATASET == "Theoph") Theoph
    else if (INPUT_DATASET == "Indometh") Indometh 
    else if (INPUT_DATASET == "sd_oral_richpk") sd_oral_richpk 
    else if (INPUT_DATASET == "sd_iv_rich_pkpd") sd_iv_rich_pkpd
    
    colnames(NCAsource) <<- toupper(colnames(NCAsource))
    if (colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJECT", "SUBJID", "ID", "USUBJID")] != "SUBJECT"){
        colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJID", "ID", "USUBJID")] <<- "SUBJECT"
    }
}

#PrepNCAtable(NCA_SOURCE = NCAsource, 
#             INPUT_NCADOSE = input$NCAdose, 
#             INPUT_DOSECOL = "",
#             INPUT_NCAADM = input$NCAadm, 
#             INPUT_TRT = NCAGroupName,
#             INPUT_NCAINFUSION = input$NCAinfusion, 
#             INPUT_NCALOG = input$NCAlog,
#             INPUT_REPORT = "Table")
#
#    function (concData, id, Time, conc, trt = "", fit = "Linear", 
#              dose = 0, adm = "Extravascular", dur = 0, report = "Table", 
#              iAUC = "", uTime = "h", uConc = "ug/L", uDose = "mg") 

#PrepNCAtable <- function(NCA_SOURCE,
#                         INPUT_TRT = "",
#                         INPUT_NCALOG, 
#                         INPUT_NCADOSE, 
#                         INPUT_DOSECOL = "", 
#                         INPUT_NCAADM, 
#                         INPUT_NCAINFUSION, 
#                         INPUT_REPORT = "Table"){
#    NCAtable <<- NCA(concData = NCA_SOURCE, 
#                     id = "SUBJECT", Time = "TIME", conc = "CONC", 
#                     trt = INPUT_TRT,
#                     fit = ifelse(INPUT_NCALOG == TRUE, "Log", "Linear"),
#                     dose = INPUT_NCADOSE, 
#                     adm = INPUT_NCAADM, 
#                     dur = INPUT_NCAINFUSION, 
#                     report = INPUT_REPORT,
#                     iAUC = "", uTime = "h", uConc = "ug/L", uDose = "mg")
#}

# input$NCAdose
# input$inCheckboxGroup1

# Shiny Main --------------------------------------------------------------

shinyServer(function(input, output, session) {
    ### 1 ###
    output$contents <- renderTable({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        return(NCAsource)
    })
    
#    ### 2 ###
#    output$NCAresults <- renderTable({
#        if (is.null(input$file1) & input$Dataset == "CSV")
#            return(print("None"))
#        PrepNCAsource(input$file1, input$Dataset)
#
#        NCAtable <- NCA(concData = NCAsource, 
#            id = "SUBJECT", Time = "TIME", conc = "CONC", 
#            trt = "",
#            fit = ifelse(input$NCAlog == TRUE, "Log", "Linear"),
#            dose = input$NCAdose, 
#            adm = input$NCAadm, 
#            dur = input$NCAinfusion, 
#            report = "Table",
#            uTime = "h", uConc = "ug/L", uDose = "mg")
#        
#        return(NCAtable)
#        
#    })
    ### 3 ###
    output$NCAgroup <- renderTable({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        
        ## No Dose ##
        
        #NCAdoseCol <- input$inCheckboxGroup1
        #if (is.null(NCAdoseCol)){
        #    PrepNCAsource(input$file1, input$Dataset)
        #    PrepNCAtable(NCAsource, input$NCAdose, input$NCAadm, 
        #                 input$NCAinfusion, input$NCAlog)
        #    return(NCAtable)
        #}
        
        
        ## No TRT ##
        if (is.null(input$inCheckboxGroup2)){
            PrepNCAsource(input$file1, input$Dataset)

            NCAtable <- NCA(concData = NCAsource, 
                id = "SUBJECT", Time = "TIME", conc = "CONC", 
                trt = "",
                fit = ifelse(input$NCAlog == TRUE, "Log", "Linear"),
                dose = ifelse(
                    is.null(input$inCheckboxGroup1),
                    yes = input$NCAdose,
                    no = NCAsource[, input$inCheckboxGroup1][NCAsource$TIME == 0]),
                adm = input$NCAadm, 
                dur = input$NCAinfusion, 
                report = "Table",
                uTime = "h", uConc = "ug/L", uDose = "mg")
            
            return(NCAtable)
        }
        
        ## TRT exists ##
        
        PrepNCAsource(input$file1, input$Dataset)
        
        NCAGroupName <- paste(input$inCheckboxGroup2, collapse = "_")
        NCAGroupData <- NCAsource %>% select_(.dots = input$inCheckboxGroup2) %>% 
            unite_(col = "All", from = input$inCheckboxGroup2, sep = "_") %>% 
            as.vector()
        NCAsource[ , NCAGroupName] <- NCAGroupData

        NCAtable <- NCA(concData = NCAsource, 
            id = "SUBJECT", Time = "TIME", conc = "CONC", 
            trt = NCAGroupName,
            fit = ifelse(input$NCAlog == TRUE, "Log", "Linear"),
            dose = ifelse(
                is.null(input$inCheckboxGroup1),
                yes = input$NCAdose,
                no = NCAsource[, input$inCheckboxGroup1][NCAsource$TIME == 0]),
            adm = input$NCAadm, 
            dur = input$NCAinfusion, 
            report = "Table",
            uTime = "h", uConc = "ug/L", uDose = "mg")
        
        #colnames(NCAtable)[2] <- "GROUP"
        #NCAtable %>% arrange(GROUP, SUBJECT)
        if (input$CarrySort == FALSE) return(NCAtable[order(NCAtable[ ,1]), ])
        else return(NCAtable[order(NCAtable[ ,2], NCAtable[ ,1]), ])
    })
    
    ### 3 Descriptive Stat ###
    output$NCAdesc <- renderTable({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        
        NCAtable <- NCA(concData = NCAsource, 
                        id = "SUBJECT", Time = "TIME", conc = "CONC", 
                        trt = "",
                        fit = ifelse(input$NCAlog == TRUE, "Log", "Linear"),
                        dose = ifelse(
                            is.null(input$inCheckboxGroup1),
                            yes = input$NCAdose,
                            no = NCAsource[, input$inCheckboxGroup1][NCAsource$TIME == 0]),
                        adm = input$NCAadm, 
                        dur = input$NCAinfusion, 
                        report = "Table",
                        uTime = "h", uConc = "ug/L", uDose = "mg")
        
        options(scipen = 100); options(digits = 2)
        StatDesc <- stat.desc(NCAtable, basic = FALSE)
        NCAStatDesc <- data.frame(VALUE = rownames(StatDesc), StatDesc[-1])
        return(NCAStatDesc)
    })
   
    # http://stackoverflow.com/questions/33499651/rmarkdown-in-shiny-application 
    #output$markdown <- renderUI({
    #    knit('rmd.Rmd', quiet = TRUE)
    #})
    
    output$plotFit<- renderUI({
        PrepNCAsource(input$file1, input$Dataset)
        HTML(markdown::markdownToHTML(knit('plotFit.Rmd', quiet = TRUE), 
                                      #options = c("toc", "mathjax"), 
                                      fragment.only = TRUE))
    })
    
    output$plotPK <- renderUI({
        PrepNCAsource(input$file1, input$Dataset)
        HTML(markdown::markdownToHTML(knit('plotPK.Rmd', quiet = TRUE), 
                                      #options = c("toc"), 
                                      fragment.only = TRUE))
    })
    
    ### 4 ###
    output$NCAreport <- renderText({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        
        NCAtable <- NCA(concData = NCAsource, 
                        id = "SUBJECT", Time = "TIME", conc = "CONC", 
                        trt = "",
                        fit = ifelse(input$NCAlog == TRUE, "Log", "Linear"),
                        dose = ifelse(
                            is.null(input$inCheckboxGroup1),
                            yes = input$NCAdose,
                            no = NCAsource[, input$inCheckboxGroup1][NCAsource$TIME == 0]),
                        adm = input$NCAadm, 
                        dur = input$NCAinfusion, 
                        report = "Text",
                        uTime = "h", uConc = "ug/L", uDose = "mg")
        
        NCAprint <- paste(NCAtable, collapse="\n")
        return(NCAprint)
    })
   
    ### PC column ### 
    output$PC <- renderTable({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        
        NCAsource %>% 
            rename(USUBJID = SUBJECT, PCORRES = CONC) %>% 
            mutate(Arrange = as.numeric(gsub(pattern = "[^0-9]", replacement = "", USUBJID))) %>% 
            arrange(Arrange, USUBJID) %>% 
            mutate(PCTPT = paste0(TIME, "H")) %>% 
            mutate(STUDYID = input$StudyID, PCSEQ = row_number(), DOMAIN = "PC",
                   PCGRPID = input$Drug, PCSPID = "NORMAL", 
                   PCTESTCD = input$Drug, PCTEST = paste0("CONCENTRATION OF ", PCTESTCD)) %>% 
            select(STUDYID, DOMAIN, USUBJID, PCSEQ, PCGRPID, PCSPID, PCTESTCD, PCTEST, 
                   PCORRES, PCTPT)
    })
    
    ### PP ###
    output$PP <- renderTable({
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        
        NCAtable <- NCA(concData = NCAsource, 
                        id = "SUBJECT", Time = "TIME", conc = "CONC", 
                        trt = "",
                        fit = ifelse(input$NCAlog == TRUE, "Log", "Linear"),
                        dose = ifelse(
                            is.null(input$inCheckboxGroup1),
                            yes = input$NCAdose,
                            no = NCAsource[, input$inCheckboxGroup1][NCAsource$TIME == 0]),
                        adm = input$NCAadm, 
                        dur = input$NCAinfusion, 
                        report = "Table",
                        uTime = "h", uConc = "ug/L", uDose = "mg")
        
        NCAtable %>% gather(PPTESTCD, PPORRES, 2:dim(NCAtable)[2]) %>% 
            rename(USUBJID = SUBJECT) %>% 
            left_join(Abbr, by = "PPTESTCD") %>% 
            mutate(Arrange = as.numeric(gsub(pattern = "[^0-9]", replacement = "", USUBJID))) %>% 
            arrange(Arrange, USUBJID) %>% 
            mutate(STUDYID = input$StudyID, PPSEQ = row_number(), DOMAIN = "PP", 
                   PPGRPID = input$Drug, PPSCAT = "NON-COMPARTMENTAL") %>% 
            select(STUDYID, DOMAIN, USUBJID, PPSEQ, PPGRPID, PPTESTCD, PPTEST, PPSCAT, PPORRES)
    })
    
    ### ggiraph ###
    output$plot <- renderggiraph({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        
        NCAtable <- NCA(concData = NCAsource, 
                        id = "SUBJECT", Time = "TIME", conc = "CONC", 
                        trt = "",
                        fit = ifelse(input$NCAlog == TRUE, "Log", "Linear"),
                        dose = input$NCAdose, 
                        adm = input$NCAadm, 
                        dur = input$NCAinfusion, 
                        report = "Table",
                        uTime = "h", uConc = "ug/L", uDose = "mg")
        
        NCAgg <- NCAsource %>% 
            left_join(NCAtable %>% select(SUBJECT, CMAX, TMAX, AUCLST, LAMZHL), by = "SUBJECT") %>% 
            mutate(TOOLTIP = sprintf(
                '<u><b>SUBJECT</b> %s</u>
                ( <b>TIME</b> %3.1f, <b>CONC</b> %3.1f )
                ( <b>TMAX</b> %3.1f, <b>CMAX</b> %3.1f )
                <b>AUCLST</b> %3.1f, <b>LAMZHL</b> %3.1f', 
                SUBJECT, TIME, CONC, TMAX, CMAX, AUCLST, LAMZHL))
        
        p <- ggplot(NCAgg, aes(x=TIME, y=CONC, tooltip = TOOLTIP, 
                               group = SUBJECT, colour=as.factor(SUBJECT))) +
            geom_line(size = 0.5) + geom_point_interactive(size = 1.5) + 
            #guides(col = guide_legend(ncol = 4)) +
            labs(list(title = "Concentration-time curves", 
                      x = "Time (hr)", 
                      y = "Concentration (ng/ml)")) +
            theme_bw() 
        
            #theme(legend.title=element_blank()) +
            #theme(plot.title = element_text(size = rel(5))) +
            #scale_colour_brewer(palette = "Set1")
            
        if (input$LogY == "Linear")
            print(ggiraph(code = {print(p)})) else 
            print(ggiraph(code = {print(p + scale_y_log10())}))
    })
    
## Interactive Column Names    
    dsnames <- c()
    
    data_set <- reactive({
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(NULL)
        PrepNCAsource(input$file1, input$Dataset) 
        data_set <- NCAsource %>% select(-CONC, -TIME) %>% group_by(SUBJECT) %>% mutate_each(funs(dense_rank))
        data_set[data_set>1] <- NA
        data_set[sapply(data_set, function(x) !any(is.na(x)))] 
    })

    observe({
        dsnames <- names(data_set())
        cb_options <- list()
        cb_options[ dsnames] <- dsnames
        # Dose
        updateCheckboxGroupInput(session, inputId = "inCheckboxGroup1",
                                 choices = cb_options,
                                 selected = "")
        # TRT
        updateCheckboxGroupInput(session, inputId = "inCheckboxGroup2",
                                 choices = cb_options,
                                 selected = "")
    })
    output$README <- renderUI({
        HTML(markdown::markdownToHTML(knit('README.Rmd', quiet = TRUE), 
                                      fragment.only = TRUE))
    })
    
})

