# Loading Packages/Setup --------------------------------------------------

library(tidyverse)
library(janitor)
library(tidyr)
library(ggplot2)
library(data.table)

# Data -----------------------------------------------------------------------

df <- fread("./data/insurance.csv") %>% 
  clean_names() %>% 
  select(region, charges)

# Plot --------------------------------------------------------------------

ggplot(data=df, mapping=aes(x=region, y=charges, color=region))+
  geom_boxplot()

# ANOVA -------------------------------------------------------------------

fit <- lm(data=df, formula=charges~region)

anova(fit)

