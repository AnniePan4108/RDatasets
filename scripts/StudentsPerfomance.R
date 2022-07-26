
# Setup -------------------------------------------------------------------

library(data.table)
library(janitor)
library(tidyverse)

df <- fread("./data/StudentsPerformance.csv")

# Cleaning/Organizing ----------------------------------------------------------------

df <- clean_names(df) %>% 
    mutate(average=(math_score+reading_score+writing_score)/3) %>% 
    select(c(gender, average))
