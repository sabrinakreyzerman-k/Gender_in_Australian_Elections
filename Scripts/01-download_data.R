#### Preamble ####
# Purpose: Test Australian Politicians Package
# Author: Inessa De Angelis
# Date: 7 May 2026
# Contact: inessa.deangelis@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(AustralianPoliticians)

#### Download data ####
politician_data <- get_auspol("all") 

party_data <- get_auspol("allbyparty")

mp_data <- get_auspol("mps")

#### Clean data ####
clean_politician_data <- politician_data |>
  select(uniqueID, displayName, gender, birthDate, member)

clean_party_data <- party_data |>
  select(uniqueID, partyAbbrev, partyName, partySimplifiedName)

clean_mp_data <- mp_data |>
  select(uniqueID, mpFrom, mpTo)

#### Save dataset ####
write_csv(x = clean_politician_data, file = "politicians_data.csv")

write_csv(x = clean_party_data, file = "party_data.csv")

write_csv(x = clean_mp_data, file = "mp_data.csv")

#### Match up datasets ####
 clean_politician_data <- clean_politician_data |>
  left_join(clean_party_data, by = "uniqueID")

clean_politician_data <- clean_politician_data |>
  left_join(clean_mp_data, by = "uniqueID")

#### Save match up dataset ####
write_csv(clean_politician_data, "combined_politician_dataset.csv")

#### Read in dataset ####
combined_dataset <- read_csv("combined_politician_dataset.csv")

#### Read in the data ####
## Code sourced from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html#australian-elections
raw_elections_data <-
  read_csv(
    file = 
      "https://results.aec.gov.au/27966/website/Downloads/HouseMembersElectedDownload-27966.csv",
    show_col_types = FALSE,
    skip = 1)

# We have read the data from the AEC website. We may like to save
# it in case something happens or they move it.
write_csv(
  x = raw_elections_data,
  file = "australian_voting.csv"
)
