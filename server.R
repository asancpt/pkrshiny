library(shiny)
library(NonCompart)  
library(markdown)
library(pastecs)
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggiraph)

Theoph <- read.csv("example/Theoph.csv", as.is = TRUE) %>% mutate(Subject = sprintf("%02d", Subject))
Indometh <- read.csv("example/Indometh.csv", as.is = TRUE) %>% mutate(Subject = sprintf("%02d", Subject))
sd_oral_richpk <- read.csv("example/sd_oral_richpk.csv", as.is = TRUE) %>% mutate(ID = sprintf("%02d", ID))
sd_iv_rich_pkpd <- read.csv("example/sd_iv_rich_pkpd.csv", as.is = TRUE) %>% rename(CONC = COBS) %>% mutate(ID = sprintf("%02d", ID))

#PrepareNCA <- function(input$file1, input$Dataset){
#    inFile <- input$file1
#    if (is.null(inFile) & input$Dataset == "CSV")
#        return(print("None")) #NULL)
#    NCAsource <- if (input$Dataset == "CSV") read.csv(inFile$datapath) else 
#        if (input$Dataset == "Theoph") Theoph else 
#            if (input$Dataset == "Indometh") Indometh else sd_oral_richpk
#    colnames(NCAsource) <- toupper(colnames(NCAsource))
#    if (colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJECT", "SUBJID", "ID", "USUBJID")] != "SUBJECT"){
#        colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJID", "ID", "USUBJID")] <- "SUBJECT"
#    }
#}

shinyServer(function(input, output) {
    ### 1 ###
    output$contents <- renderTable({
        ### Template Start ###
        inFile <- input$file1
        if (is.null(inFile) & input$Dataset == "CSV")
            return(print("None")) #NULL)
        NCAsource <- if (input$Dataset == "CSV") read.csv(inFile$datapath) else 
            if (input$Dataset == "Theoph") Theoph else 
                if (input$Dataset == "Indometh") Indometh else 
                    if (input$Dataset == "sd_oral_richpk") sd_oral_richpk else sd_iv_rich_pkpd
        colnames(NCAsource) <- toupper(colnames(NCAsource))
        if (colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJECT", "SUBJID", "ID", "USUBJID")] != "SUBJECT"){
            colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJID", "ID", "USUBJID")] <- "SUBJECT"
        }
        ### Template End ###
        
        NCAsource 
    })
    
    ### 2 ###
    output$NCAresults <- renderTable({
        ### Template Start ### input$file1, input$Dataset
        inFile <- input$file1
        if (is.null(inFile) & input$Dataset == "CSV")
            return(print("None")) #NULL)
        NCAsource <- if (input$Dataset == "CSV") read.csv(inFile$datapath) else 
            if (input$Dataset == "Theoph") Theoph else 
                if (input$Dataset == "Indometh") Indometh else 
                    if (input$Dataset == "sd_oral_richpk") sd_oral_richpk else sd_iv_rich_pkpd
        colnames(NCAsource) <- toupper(colnames(NCAsource))
        if (colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJECT", "SUBJID", "ID", "USUBJID")] != "SUBJECT"){
            colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJID", "ID", "USUBJID")] <- "SUBJECT"
        }
        ### Template End ###
        
        NCA(NCAsource, "SUBJECT", "TIME", "CONC", 
            Dose = input$NCAdose, 
            AdmMode = input$NCAadm, 
            TimeInfusion = input$NCAinfusion, 
            Method = ifelse(input$NCAlog == TRUE, "Log", "Linear"))
    })
    
    ### 3 ###
    output$NCAdesc <- renderTable({
        ### Template Start ###
        inFile <- input$file1
        if (is.null(inFile) & input$Dataset == "CSV")
            return(print("None")) #NULL)
        NCAsource <- if (input$Dataset == "CSV") read.csv(inFile$datapath) else 
            if (input$Dataset == "Theoph") Theoph else 
                if (input$Dataset == "Indometh") Indometh else 
                    if (input$Dataset == "sd_oral_richpk") sd_oral_richpk else sd_iv_rich_pkpd
        colnames(NCAsource) <- toupper(colnames(NCAsource))
        if (colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJECT", "SUBJID", "ID", "USUBJID")] != "SUBJECT"){
            colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJID", "ID", "USUBJID")] <- "SUBJECT"
        }
        ### Template End ###
        
        NCAtable <- NCA(NCAsource, "SUBJECT", "TIME", "CONC", 
                        Dose = input$NCAdose, 
                        AdmMode = input$NCAadm, 
                        TimeInfusion = input$NCAinfusion, 
                        Method = ifelse(input$NCAlog == TRUE, "Log", "Linear"))
        
        options(scipen = 100); options(digits = 2)
        StatDesc <- stat.desc(NCAtable, basic = FALSE)#, basic = FALSE)
        data.frame(VALUE = rownames(StatDesc), StatDesc[-1])
    })
    
    ### 4 ###
    output$NCAreport <- renderText({
        ### Template Start ###
        inFile <- input$file1
        if (is.null(inFile) & input$Dataset == "CSV")
            return(print("None")) #NULL)
        NCAsource <- if (input$Dataset == "CSV") read.csv(inFile$datapath) else 
            if (input$Dataset == "Theoph") Theoph else 
                if (input$Dataset == "Indometh") Indometh else 
                    if (input$Dataset == "sd_oral_richpk") sd_oral_richpk else sd_iv_rich_pkpd
        colnames(NCAsource) <- toupper(colnames(NCAsource))
        if (colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJECT", "SUBJID", "ID", "USUBJID")] != "SUBJECT"){
            colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJID", "ID", "USUBJID")] <- "SUBJECT"
        }
        ### Template End ###
        
        NCAprint <- NCA(NCAsource, "SUBJECT", "TIME", "CONC", 
                        Dose=input$NCAdose, 
                        AdmMode = input$NCAadm, 
                        TimeInfusion = input$NCAinfusion, 
                        Report="Text", 
                        Method = ifelse(input$NCAlog == TRUE, "Log", "Linear"))
        paste(NCAprint, collapse="\n")
    })
    
    output$PC <- renderTable({
        ### Template Start ###
        inFile <- input$file1
        if (is.null(inFile) & input$Dataset == "CSV")
            return(print("None")) #NULL)
        NCAsource <- if (input$Dataset == "CSV") read.csv(inFile$datapath) else 
            if (input$Dataset == "Theoph") Theoph else 
                if (input$Dataset == "Indometh") Indometh else 
                    if (input$Dataset == "sd_oral_richpk") sd_oral_richpk else sd_iv_rich_pkpd
        colnames(NCAsource) <- toupper(colnames(NCAsource))
        if (colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJECT", "SUBJID", "ID", "USUBJID")] != "SUBJECT"){
            colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJID", "ID", "USUBJID")] <- "SUBJECT"
        }
        ### Template End ###
        
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
        ### Template Start ###
        inFile <- input$file1
        if (is.null(inFile) & input$Dataset == "CSV")
            return(print("None")) #NULL)
        NCAsource <- if (input$Dataset == "CSV") read.csv(inFile$datapath) else 
            if (input$Dataset == "Theoph") Theoph else 
                if (input$Dataset == "Indometh") Indometh else 
                    if (input$Dataset == "sd_oral_richpk") sd_oral_richpk else sd_iv_rich_pkpd
        colnames(NCAsource) <- toupper(colnames(NCAsource))
        if (colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJECT", "SUBJID", "ID", "USUBJID")] != "SUBJECT"){
            colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJID", "ID", "USUBJID")] <- "SUBJECT"
        }
        ### Template End ###
        
        NCAtable <- NCA(NCAsource, "SUBJECT", "TIME", "CONC", 
                        Dose = input$NCAdose, 
                        AdmMode = input$NCAadm, 
                        TimeInfusion = input$NCAinfusion, 
                        Method = ifelse(input$NCAlog == TRUE, "Log", "Linear"))
        
        Abbr <- read.csv("abbr.csv", stringsAsFactors = FALSE)
        
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
        ### Template Start ###
        inFile <- input$file1
        if (is.null(inFile) & input$Dataset == "CSV")
            return(print("None")) #NULL)
        NCAsource <- if (input$Dataset == "CSV") read.csv(inFile$datapath) else 
            if (input$Dataset == "Theoph") Theoph else 
                if (input$Dataset == "Indometh") Indometh else 
                    if (input$Dataset == "sd_oral_richpk") sd_oral_richpk else sd_iv_rich_pkpd
        colnames(NCAsource) <- toupper(colnames(NCAsource))
        if (colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJECT", "SUBJID", "ID", "USUBJID")] != "SUBJECT"){
            colnames(NCAsource)[colnames(NCAsource) %in% c("SUBJID", "ID", "USUBJID")] <- "SUBJECT"
        }
        NCAsource <- NCAsource %>% mutate(SUBJECT = as.character(SUBJECT))
        ### Template End ###
        
        NCAtable <- NCA(NCAsource, "SUBJECT", "TIME", "CONC", 
                        Dose = input$NCAdose, 
                        AdmMode = input$NCAadm, 
                        TimeInfusion = input$NCAinfusion, 
                        Method = ifelse(input$NCAlog == TRUE, "Log", "Linear")) 
        
        NCAgg <- NCAsource %>% 
            left_join(NCAtable %>% select(SUBJECT, CMAX, TMAX, AUCLST, LAMZHL, VZFO, CLFO), by = "SUBJECT") %>% 
            mutate(TOOLTIP = sprintf(
                '<u><b>SUBJECT</b> %s</u>
                ( <b>TIME</b> %3.1f, <b>CONC</b> %3.1f )
                ( <b>TMAX</b> %3.1f, <b>CMAX</b> %3.1f )
                <b>AUCLST</b> %3.1f, <b>LAMZHL</b> %3.1f
                <b>VZFO</b> %3.1f, <b>CLFO</b> %3.1f', 
                SUBJECT, TIME, CONC, TMAX, CMAX, AUCLST, LAMZHL, VZFO, CLFO))
                
                
                #paste0(SUBJECT, TIME, CONC, CMAX, TMAX, AUCLST, LAMZHL, sep = ","))
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
            
        if (input$LogY == "Linear"){
            print(ggiraph(code = {print(p)}))
        } else {
            print(
                ggiraph(code = {print(p + scale_y_log10())})
            )
        }
    })
})