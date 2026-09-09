# TikTok Impressions Analysis

## Goal

This analysis was completed for Issue #9 of the team Tiktok project. It inspects TikTok impression data, including feed sources, ranking scores, missing values, and duplicate records.

## Data
The script automatically creates the data folder if needed.
The data is downloaded automatically from the course repository and saved locally as:
data/data_impressions.csv

The CSV file is not included in Git.

## Requirements
- R
- The R package tidyverse
- Make

## Run the Analysis
Open Terminal in the impressions-analysis folder and run:
    make

## Data Cleaning & Main Findings
The original dataset contains 95,737 rows.
The mission_ids variable contains 13,926 missing values.
There are 786 fully duplicated rows.
After removing fully duplicated rows, 94,951 rows remain.
The cleaned data still contains 161 repeated impression_id values with differences in other variables.
The feed source distribution is 51.6% preferred_new, 31.4% explore, and 17.0% known.

## Visualization

A scatter plot was created using ggplot2, with score_total on the x-axis and feed_rank on the y-axis. The points are colored by source_bucket.
The resulting graph was saved using ggsave() as:
png/score_graph.png
The graph is stored in the separate png folder.
