
# Uploading Libraries -----------------------------------------------------

library(tidyverse)
library(janitor)
library(data.table)
library(readxl)
library(dplyr)
library(reshape2)

df <- read_xlsx("./data/Canada.xlsx", skip=1)

# Cleaning ----------------------------------------------------------------

df <- df %>% 
  clean_names() %>% 
  select(-c(1, 2)) 
isTotalRow <- 
  endsWith(df$area_name, suffix="Total")


# Plotting ----------------------------------------------------------------

totals <- df[isTotalRow, ] %>% 
  select(-2)

total_unpivot <- 
  melt(totals, id=c("area_name"),
       variable.name = "date",
       value.name="immigrants")

str(total_unpivot)

total_unpivot$date <- 
  str_remove(pattern="x", string = total_unpivot$date) %>% 
  as.integer()
total_unpivot$immigrants <- 
  as.numeric(total_unpivot$immigrants)

ggplot(total_unpivot, mapping=aes(x=date, y=immigrants, fill=area_name))+
  geom_bar(stat="identity") 

ggplot(total_unpivot, mapping=aes(x=date, y=immigrants, col=area_name, group=area_name))+
  geom_line() +
  labs(title="Canadian Immigrants over the Years",
       xlab="Date",
       ylab="Immigrants") +
  guides(col= guide_legend(title= "Area Names")
        )
