library(tidyverse)
library(here)

url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/impressions.csv"
data_file <- here("Data", "data_impressions.csv")
if (!file.exists(data_file)) {
  download.file(url, data_file, mode = "wb")
}
data_impressions <- read_csv(data_file)