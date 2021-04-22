library(ggrepel)
library(ggridges)
library(ggthemes)
library(leaflet)
library(tidyr)
library(sf)
library(padr)
library(DT)
library(sp)
library(ggplot2)
library(shiny)
library(dplyr)
library(shinydashboard)
library(plotly)
library(lubridate)
options(shiny.maxRequestSize=200*1024^2)

# covid_raw <- read.csv("Data/WHO COVID-19 global table data April 10th 2021 at 1.17.05 PM.csv") %>% 
# dplyr::rename(Name = "ï..Name")
# cdnt <- read.csv("Data/average-latitude-longitude-countries.csv", encoding = "UTF-8") %>% 
#   dplyr::rename(ISO = "ISO.3166.Country.Code")
# vaccine <- read.csv("Data/Current-Vaccine-Intro-Status(view-hub.org).csv", encoding = "UTF-8") %>% 
#   dplyr::rename(COVAX = "COVAX.Status")
# vaccinated <- read.csv("Data/daily-covid-vaccination-doses-per-capita.csv", encoding = "UTF-8") %>% 
#   dplyr::rename(Country = "Entity")
# df_1 <- cdnt
# df_2 <- vaccine
# df_3 <- covid_raw
# df_4 <- vaccinated
# df_1 %>% 
#   left_join(df_2)
# covid <- df_1 %>% 
#   left_join(df_2, by = "Country") %>%
#   left_join(df_3, by = c("Country" = "Name")) %>%
#   left_join(df_4, by = c("Country" = "Country"))
# colSums(is.na(covid))
# clean_covid <- covid %>% drop_na(WHO.Region)
clean_covid <- read.csv("Data/clean_covid.csv")

yearOpt <- unique(clean_covid$Day)

europe_max <- clean_covid %>%
  filter(WHO.Region %in% "Europe") %>% 
  select(Cases...cumulative.total) %>% 
  max()

clean <- subset(x = clean_covid, select = c(Day, Country, Cases...cumulative.total))