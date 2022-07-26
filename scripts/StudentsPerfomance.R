
# Setup -------------------------------------------------------------------

library(data.table)
library(janitor)
library(tidyr)
library(ggtheme)
library(tidyverse)

df <- fread("./data/StudentsPerformance.csv")

# Cleaning/Organizing ----------------------------------------------------------------

df <- clean_names(df) %>% 
    mutate(average=(math_score+reading_score+writing_score)/3) %>% 
    select(c(gender, average))


# Plot --------------------------------------------------------------------

ggplot(data = df, mapping = aes(x = average, color = gender)) +
  geom_density() +
  labs(
    title = "Average Scores",
    x = "Score",
    y = "Density"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = .5, face = "bold"),
  )


# T Test setup -------------------------------------------------------------------

M <-
  df %>% 
  filter(gender == "male") %>% select(average)

F <-
  df %>% 
  filter(gender == "female") %>% select(average)

t.test(M, F)
