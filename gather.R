
# Setting up file and loading libraries
library(tidyverse)
library(readr)


# Loading AmfAR county-level opioid Rx rate dataset (2006-2017).

county_rx_rate <- 
  read_csv(file = "/Users/ciaraduggan/Desktop/gov_50/final_project/duggan_final_project_gov50/raw_data/county_opioid_RxRate.csv", 
           col_types = cols(
             STATE = col_character(),
             STATEABBREVIATION = col_character(),
             COUNTY = col_character(),
             STATEFP = col_character(),
             COUNTYFP = col_character(),
             INDICATOR = col_character(),
             YEAR = col_character(),
             VALUE = col_double()
           ))

# Loading AmfAR data on county-level age-adjusted drug-related death rate (per
# 100,000).

county_drug_deaths <-
  read_csv(file = "/Users/ciaraduggan/Desktop/gov_50/final_project/duggan_final_project_gov50/raw_data/county_ageadjusted_drugdeathrate.csv", 
           col_types = cols(
             STATE = col_character(),
             STATEABBREVIATION = col_character(),
             COUNTY = col_character(),
             STATEFP = col_character(),
             COUNTYFP = col_character(),
             INDICATOR = col_character(),
             YEAR = col_character(),
             VALUE = col_double()
             ))

# Pivoting the county_drug_deaths dataset to a wider format to create a variable
# containing age-adjusted drug-related death rate estimates.

county_drug_deaths_wider <-
  county_drug_deaths %>%
  pivot_wider(names_from = "INDICATOR", values_from = "VALUE")

# Pivoting the county_rx_rate_wider dataset to a wider format to create a
# variable containing the opioid prescription rates per 100,000 people.

county_rx_rate_wider <-
  county_rx_rate %>%
  pivot_wider(names_from = "INDICATOR", values_from = "VALUE")

# Joining the resulting county_drug_deaths_wider and county_rx_rate_wider data
# sets by county and year.

county_drug_data <- county_drug_deaths_wider %>%
  inner_join(county_rx_rate_wider, by = c("COUNTY", 
                                          "YEAR", 
                                          "STATE", 
                                          "STATEABBREVIATION",
                                          "STATEFP",
                                          "COUNTYFP"
  ))

# Saving county_drug_data as an rds file.

write_rds(county_drug_data, "county_drug_data.rds")

             
             
             