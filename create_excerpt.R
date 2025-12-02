# Load Libraries
library(tidyverse)
library(data.table)

# set seed
set.seed(123)

# remove scientific notation
options(scipen = 999)

# Read in Data
data <- fread("data/ATP_W144.csv")

# Create Excerpt
## Filter for English Language Respondents and Select Relevant Columns
## Randomly Sample 626 Rows (99% CI, 5% MoE, Population of 10,454)
data_excerpt <- data %>%
  filter(LANG_W144 == 1) %>%
  select(-INTERVIEW_START_W144,
         -INTERVIEW_END_W144,
         -LANG_W144,
         -XRAND_FB_IG_W144,
         -DOV_USE4_W144,
         -DOV_ASKFB_W144,
         -DOV_ASKIG_W144,
         -F_CREGION,
         -F_CDIVISION,
         -F_USR_SELFID,
         -F_HISP,
         -F_HISP_ORIGIN,
         -F_YEARSINUS_RECODE,
         -F_RACECMB,
         -F_BIRTHPLACE,
         -F_RELIG,
         -F_BORN,
         -F_RELIGCAT1,
         -F_ATTENDPER,
         -F_VOLSUM,
         -WEIGHT_W144,
         -WEIGHT_W144_FB,
         -WEIGHT_W144_IG,
         -WEIGHT_W144_XT,
         -WEIGHT_W144_TT) %>%
  rename_with(tolower) %>%
  slice_sample(n = 626)

# Write Excerpt to CSV
fwrite(data_excerpt, "data/ATP_W144_excerpt.csv")


