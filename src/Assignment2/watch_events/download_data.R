# Downloads the raw TikTok watch events data into the Data folder.
library(here)

url  <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/watch_events.csv"
dest <- here("Data", "watch_events.csv")

if (!file.exists(dest)) {
  download.file(url, destfile = dest, mode = "wb")
}

cat("Downloaded raw data to:", dest, "\n")