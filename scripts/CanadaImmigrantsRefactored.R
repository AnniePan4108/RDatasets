# Configs -----------------------------------------------------
options(scipen = 999) # Disable Scientific Notation
library(tidyverse)
library(janitor)
library(data.table)
library(readxl)

# Load -----------------------------------------------------------------

df <-
  read_xlsx("./data/Canada.xlsx", skip = 1)


# Transform ----------------------------------------------------------------


df <-
  df %>%
  clean_names() %>%
  select(-(1:2))

totals <-
  df %>%
  select(-reg_name) %>%
  filter(endsWith(area_name, "Total")) %>%
  as.data.table() %>%
  melt(id.vars = "area_name",
       variable.name = "date",
       value.name = "immigrants") %>%
  mutate(
    date = str_remove(date, "x") %>% as.integer(),
    immigrants = as.numeric(immigrants),
    area_name = str_remove(area_name, "Total")
  ) %>% na.omit() %>%
  suppressWarnings()


# Plot Bar Chart --------------------------------------------------

ggplot(data = totals,
       mapping = aes(x = date, y = immigrants, fill = area_name)) +
  geom_bar(stat = "identity") +
  labs(title = "Immigrants by Continent",
       x = "Year",
       y = "Number of immigrants") +
  theme_bw() +
  scale_fill_discrete() +
  theme(plot.title = element_text(hjust = .5),
        legend.position = "top") +
  guides(fill = guide_legend(title = "Continent"))


# Plot Line Chart ---------------------------------------------------------

ggplot(data = totals,
       mapping = aes(x = date, y = immigrants,
                     
                     col = area_name)) +
  labs(title = "Immigrants by Continent",
       x = "Date",
       y = "Immigrants",) +
  geom_line() +
  geom_point(shape = 1) +
  scale_x_continuous(n.breaks = 10) +
  theme(
    plot.title = element_text(face = "bold", hjust = .5),
    legend.position = "right",
    axis.text.x = element_text(angle = 300, hjust = .5),
  ) +
  guides(col = guide_legend(title = "Continent"))
