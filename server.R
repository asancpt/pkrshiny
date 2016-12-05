source("library.R")

Theoph <- read.csv("example/Theoph.csv", as.is = TRUE) %>% 
    mutate(Subject = sprintf("%02d", Subject))
Indometh <- read.csv("example/Indometh.csv", as.is = TRUE) %>% 
    mutate(Subject = sprintf("%02d", Subject))
sd_oral_richpk <- read.csv("example/sd_oral_richpk.csv", as.is = TRUE) %>% 
    mutate(ID = sprintf("%02d", ID))
sd_iv_rich_pkpd <- read.csv("example/sd_iv_rich_pkpd.csv", as.is = TRUE) %>% 
    rename(CONC = COBS) %>% mutate(ID = sprintf("%02d", ID))
Abbr <- read.csv("abbr.csv", stringsAsFactors = FALSE)

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

PrepNCAtable <- function(NCA_SOURCE, INPUT_NCADOSE, INPUT_NCAADM, 
                         INPUT_NCAINFUSION, INPUT_NCALOG, INPUT_REPORT = "Table",
                         INPUT_TRT = "None"){
    if (INPUT_TRT == "None"){
        NCAtable <<- NCA(NCA_SOURCE, 
                         colSubj = "SUBJECT", colTime = "TIME", colConc = "CONC", 
                         Dose = INPUT_NCADOSE, 
                         AdmMode = INPUT_NCAADM, 
                         TimeInfusion = INPUT_NCAINFUSION, 
                         Method = ifelse(INPUT_NCALOG == TRUE, "Log", "Linear"),
                         Report = INPUT_REPORT)
    } else {
        NCAtable <<- NCA(NCA_SOURCE, 
                         colSubj = "SUBJECT", colTime = "TIME", colConc = "CONC", 
                         colTrt = INPUT_TRT,
                         Dose = INPUT_NCADOSE, 
                         AdmMode = INPUT_NCAADM, 
                         TimeInfusion = INPUT_NCAINFUSION, 
                         Method = ifelse(INPUT_NCALOG == TRUE, "Log", "Linear"),
                         Report = INPUT_REPORT)
    }
    
}

shinyServer(function(input, output, session) {
    ### 1 ###
    output$contents <- renderTable({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        return(NCAsource)
    })
    
    ### 2 ###
    output$NCAresults <- renderTable({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        PrepNCAtable(NCAsource, input$NCAdose, input$NCAadm, 
                     input$NCAinfusion, input$NCAlog)
        return(NCAtable)
    })
    
    ### 3 ###
    output$NCAdesc <- renderTable({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        PrepNCAtable(NCAsource, input$NCAdose, input$NCAadm, 
                     input$NCAinfusion, input$NCAlog)
        
        options(scipen = 100); options(digits = 2)
        StatDesc <- stat.desc(NCAtable, basic = FALSE)
        NCAStatDesc <- data.frame(VALUE = rownames(StatDesc), StatDesc[-1])
        return(NCAStatDesc)
    })
    
    ### 4 ###
    output$NCAreport <- renderText({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        PrepNCAtable(NCAsource, input$NCAdose, input$NCAadm, 
                     input$NCAinfusion, input$NCAlog, "Text")
        
        NCAprint <- paste(NCAtable, collapse="\n")
        return(NCAprint)
    })
    
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
    
    output$PP <- renderTable({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        PrepNCAtable(NCAsource, input$NCAdose, input$NCAadm, 
                     input$NCAinfusion, input$NCAlog)
        
        NCAtable %>% gather(PPTESTCD, PPORRES, 2:dim(NCAtable)[2]) %>% 
            rename(USUBJID = SUBJECT) %>% 
            left_join(Abbr, by = "PPTESTCD") %>% 
            mutate(Arrange = as.numeric(gsub(pattern = "[^0-9]", replacement = "", USUBJID))) %>% 
            arrange(Arrange, USUBJID) %>% 
            mutate(STUDYID = input$StudyID, PPSEQ = row_number(), DOMAIN = "PP", 
                   PPGRPID = input$Drug, PPSCAT = "NON-COMPARTMENTAL") %>% 
            select(STUDYID, DOMAIN, USUBJID, PPSEQ, PPGRPID, PPTESTCD, PPTEST, PPSCAT, PPORRES)
    })
    
    ### 5 ###
    output$plot <- renderggiraph({
        ### Start ###
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(print("None"))
        PrepNCAsource(input$file1, input$Dataset)
        PrepNCAtable(NCAsource, input$NCAdose, input$NCAadm, 
                     input$NCAinfusion, input$NCAlog)
        
        NCAgg <- NCAsource %>% 
            left_join(NCAtable %>% select(SUBJECT, CMAX, TMAX, AUCLST, LAMZHL, VZFO, CLFO), by = "SUBJECT") %>% 
            mutate(TOOLTIP = sprintf(
                '<u><b>SUBJECT</b> %s</u>
                ( <b>TIME</b> %3.1f, <b>CONC</b> %3.1f )
                ( <b>TMAX</b> %3.1f, <b>CMAX</b> %3.1f )
                <b>AUCLST</b> %3.1f, <b>LAMZHL</b> %3.1f
                <b>VZFO</b> %3.1f, <b>CLFO</b> %3.1f', 
                SUBJECT, TIME, CONC, TMAX, CMAX, AUCLST, LAMZHL, VZFO, CLFO))
        
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
    
    dsnames <- c()
    
    data_set <- reactive({
        if (is.null(input$file1) & input$Dataset == "CSV")
            return(NULL)
        PrepNCAsource(input$file1, input$Dataset)
        data_set <- NCAsource
    })
    
    observe({
        dsnames <- names(data_set())
        cb_options <- list()
        cb_options[ dsnames] <- dsnames
        updateCheckboxGroupInput(session, "inCheckboxGroup",
                                 label = "Group",
                                 choices = cb_options,
                                 selected = "")
    })
    
})