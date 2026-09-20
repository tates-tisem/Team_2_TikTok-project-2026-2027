library(tidyverse)
dir.create("data", showWarnings = FALSE)
url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/impressions.csv"
if (!file.exists("data/data_impressions.csv")) {
  download.file(url, "data/data_impressions.csv")
}
data_impressions <- read_csv("data/data_impressions.csv")