# Downloads the raw TikTok watch events data into the repository's Data folder.

# paths are relative to this script's folder (Summary/watch_events)
raw_dir <- file.path("..", "..", "Data", "raw")

# create the folder if it does not exist yet
if (!dir.exists(raw_dir)) {
  dir.create(raw_dir, recursive = TRUE)
}

url  <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/watch_events.csv"
dest <- file.path(raw_dir, "watch_events.csv")

download.file(url, destfile = dest, mode = "wb")

cat("Downloaded raw data to:", dest, "\n")