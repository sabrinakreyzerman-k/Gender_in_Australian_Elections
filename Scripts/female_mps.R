#### Preamble ####
# Purpose: Create table for when Labor MPs elected were female
# Author: Sabrina Kreyzerman
# Date: 11 May 2026
# Contact: sabrina.kreyzerman@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
## Load packages ##
library(tidyverse)
library(knitr)
library(janitor)
library(kableExtra)
library(here)

## Read in datasets ##
cleaned_politicians_data <- read_csv(here("Data/Clean/cleaned_politicians_data.csv"))
cleaned_party_data <- read_csv(here("Data/Clean/cleaned_party_data.csv"))
cleaned_mp_data <- read_csv(here("Data/Clean/cleaned_mp_data.csv"))
combined_politician_dataset <- read_csv(here("Data/Clean/combined_politician_dataset.csv"))

#### Executing purpose ####
## Create table for Gender, Parties, and Elected MPs ##

combined_politician_dataset |> 
  filter(year_elected == '1993' | year_elected == "1996" | year_elected == "2013" | year_elected == "2016") |>
  filter(gender == "female") |>
  filter(partyName.x == 'Australian Labor Party') |>
  group_by(year_elected) |>
  count() |>
  ungroup() |>
  kable(
    col.names = c("Election Year", "Number of Female MPs Elected"),
    booktabs = TRUE)