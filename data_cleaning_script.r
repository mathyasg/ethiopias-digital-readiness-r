# =============================================================================
# Ethiopia Digital Readiness – Reproducible Data Cleaning
# Author: Mathyas Tilahun
# Project: Ethiopia's Digital Readiness
# Data source: World Bank World Development Indicators (WDI)
# Purpose: Turn the raw wide-format export into a clean analysis-ready long + wide data
# =============================================================================

library(tidyverse)

# -----------------------------------------------------------------------------
# 1. Load raw data
# -----------------------------------------------------------------------------
# Force character on import so World Bank ".." missing markers do not coerce
# columns incorrectly. Treat ".." as NA immediately.
df_raw <- read_csv(
  "digital_inclusion_raw.csv",
  col_types = cols(.default = "c"),
  na = c("", "NA", "..")
)

message("Raw rows loaded: ", nrow(df_raw))

# -----------------------------------------------------------------------------
# 2. Drop metadata / empty rows
# -----------------------------------------------------------------------------
# The WDI export ends with two non-data rows. We also drop completely blank rows.
df <- df_raw %>%
  filter(
    !is.na(`Country Name`),
    !str_detect(`Country Name`, regex("Data from database|Last Updated", ignore_case = TRUE))
  )

# Keep only the two entities required for this analysis.
# Easy to expand later by editing this filter.
df <- df %>%
  filter(`Country Name` %in% c("Ethiopia", "Sub-Saharan Africa"))

# -----------------------------------------------------------------------------
# 3. Select & rename columns
# -----------------------------------------------------------------------------
# Country Code and Series Code are redundant once we have readable names.
df <- df %>%
  select(
    Country   = `Country Name`,
    Indicator = `Series Name`,
    `2010`:`2024`
  )

# -----------------------------------------------------------------------------
# 4. Reshape wide → long
# -----------------------------------------------------------------------------
df_long <- df %>%
  pivot_longer(
    cols      = `2010`:`2024`,
    names_to  = "Year",
    values_to = "Value"
  ) %>%
  mutate(
    Year  = as.integer(Year),
    Value = as.numeric(Value)
  )

# -----------------------------------------------------------------------------
# 5. Document known missing values (do not impute)
# -----------------------------------------------------------------------------
# Ethiopia has genuine gaps in 2018 for mobile cellular and fixed broadband.
# We leave them as NA so regressions and visualisations are not distorted by invented numbers.
missing_check <- df_long %>%
  filter(is.na(Value)) %>%
  select(Country, Indicator, Year)

if (nrow(missing_check) > 0) {
  message("\nKnown missing values retained as NA:")
  
} else {
  message("\nNo missing values found.")
}

# -----------------------------------------------------------------------------
# 6. Add short indicator labels (for models & facets)
# -----------------------------------------------------------------------------
df_long <- df_long %>%
  mutate(
    Indicator_short = case_when(
      str_detect(Indicator, "Internet")        ~ "internet_pct",
      str_detect(Indicator, "Mobile cellular") ~ "mobile_per_100",
      str_detect(Indicator, "GDP per capita")  ~ "gdp_pc_usd",
      str_detect(Indicator, "Fixed broadband") ~ "broadband_per_100",
      TRUE ~ Indicator
    )
  )

# -----------------------------------------------------------------------------
# 7. Quality checks
# -----------------------------------------------------------------------------
stopifnot(nrow(df_long) == 120)
stopifnot(n_distinct(df_long$Country) == 2)
stopifnot(n_distinct(df_long$Indicator) == 4)
stopifnot(min(df_long$Year) == 2010, max(df_long$Year) == 2024)

message("\nCleaning complete.")
message("Rows: ", nrow(df_long))
message("Non-missing values: ", sum(!is.na(df_long$Value)))

# -----------------------------------------------------------------------------
# 8. Write clean outputs + keep objects in environment
# -----------------------------------------------------------------------------
write_csv(df_long, "digital_inclusion_clean_long.csv")

df_wide <- df_long %>%
  select(Country, Year, Indicator_short, Value) %>%
  pivot_wider(names_from = Indicator_short, values_from = Value)

write_csv(df_wide, "digital_inclusion_clean_wide.csv")


message("Clean files written: digital_inclusion_clean_long.csv / digital_inclusion_clean_wide.csv")