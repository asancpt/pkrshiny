library(googlesheets) # install.packages("googlesheets")
library(dplyr)

#gs_auth()
gs_user()
gs_ls()

# http://shiny.rstudio.com/articles/persistent-data-storage.html#gsheets
# http://127.0.0.1:16806/library/googlesheets/doc/formulas-and-formatted-numbers.html
# http://127.0.0.1:16806/library/googlesheets/doc/basic-usage.html
# http://127.0.0.1:16806/library/googlesheets/doc/managing-auth-tokens.html

#my_sheets <- gs_ls()
#PEET2017data = gs_ls("peet2017")

table <- "peet2017" # Data

saveData <- function(data) {
  # Grab the Google Sheet
  sheet <- gs_title(table)
  # Add the data as a new row
  gs_add_row(sheet, input = data)
}

loadData <- function() {
  # Grab the Google Sheet
  sheet <- gs_title(table)
  # Read the data
  gs_read_csv(sheet)
}

PEET2017 = loadData()
PEET2017

# Add input - Click - See my result - 

PEETmean <- PEET2017 %>% mutate(Mean = mean(Score))
saveData(PEETmean)

# FORM | https://docs.google.com/forms/d/1c7zeyxixqFpGYUBFk68xYh_gqNiD8h9MPQfXCfJzU9A/edit
# SHEET | https://docs.google.com/spreadsheets/d/1j02Xc0ykrzEPqsJiTURAXRo1l0AuBN0zQ42myl04Q84/edit#gid=2065211891


### Example
# http://127.0.0.1:16806/library/googlesheets/doc/formulas-and-formatted-numbers.html
gs_ff() %>% 
  gs_read(range = cell_cols("B:C"))

gs_ff() %>% 
  gs_read(literal = FALSE, range = cell_cols("B:C"))

gs_ff() %>% 
  gs_read_cellfeed(range = cell_cols("E")) %>% 
  select(-cell_alt, -row, -col) %>% 
  knitr::kable()
