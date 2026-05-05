# Architecture of Growth: Ethiopia’s Digital Economy Success Story #
## A Comparative Study of ICT Multipliers and Regional Connectivity Benchmarks##

📊 Project Overview

This repository contains a comprehensive data analysis of Ethiopia's ICT infrastructure evolution from 2010 to 2024. Using World Bank Development Indicators, the study employs comparative linear regression to quantify how digital connectivity translates into economic output (GDP per capita).

The core of this project is a comparison between Ethiopia’s disciplined growth trajectory and the aggregate trends of the Sub-Saharan Africa (SSA) region.

🛠️ Methodology & Tech Stack

Language: R

Key Libraries: tidyverse (Data Wrangling), ggplot2 (Visualization), broom (Statistical Modeling), knitr (Reporting).

Statistical Approach: Ordinary Least Squares (OLS) Regression.

Data Source: World Bank Open Data 

🚀 Key Analytical Findings

1. The "Contestability" EffectThe analysis reveals that connectivity markers accelerated sharply post-2018. This suggests a Contestability Effect: the mere policy shift toward liberalization forced improvements in the sector four years before a second operator (Safaricom) physically entered the market in 2022.

2. Ethiopia as a Digital OutlierWhile the Sub-Saharan Africa aggregate data shows significant statistical "noise" due to regional structural heterogeneity ($R^2 < 0.06$), Ethiopia’s model shows a remarkably precise correlation ($R^2 = 0.876$). This indicates that Ethiopia's economy is exceptionally sensitive to ICT improvements.

3. The Multiplier Gap (Depth vs. Breadth)A critical discovery in the regression estimates:Internet Impact: 32.95 (GDP per capita increase per 1% growth)Mobile Impact: 14.06 (GDP per capita increase per 1% growth)Insight: While mobile subscriptions provide the breadth of access, internet usage provides the depth of value, yielding a 2.3x higher economic return.

📁 Repository Structure
- analysis.Rmd: The master R Markdown file containing all code and narrative.
- digital_inclusion_raw.csv: The cleaned dataset used for the study.
- Architecture_of_Growth.html: The final knitted report (includes interactive Table of Contents and formatted tables).
   
📈 Visualizations
The project includes time-series visualizations and regression tables that highlight:
- The "catch-up" growth of Ethiopia compared to SSA benchmarks.
- The inflection points in mobile and internet penetration.
- Comparative statistical tables showing Estimate, P-Value, and R-Squared values.

Author: Mathyas Tilahun

Date: April 2026
