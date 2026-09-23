# Compares the old CSV files with the tables in the SQLite database,
# to decide which CSV downloads can be replaced by the database.

library(tidyverse)
library(DBI)
library(RSQLite)
library(here)

base <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/"

# old CSV file -> closest table in the database (NA = no table)
pairs <- tribble(
  ~csv,                               ~table,
  "video_view.csv",                   "video_view",
  "coaching_2_data/sessions.csv",     NA,
  "coaching_2_data/users.csv",        "users",
  "coaching_2_data/impressions.csv",  "watch_logs",
  "coaching_2_data/watch_events.csv", "watch_logs"
)

con <- dbConnect(SQLite(), here("Data", "tiktok_students.sqlite"))

for (i in seq_len(nrow(pairs))) {
  cat("====", pairs$csv[i], "->", pairs$table[i], "====\n")
  csv <- read_csv(paste0(base, pairs$csv[i]), show_col_types = FALSE)
  
  if (is.na(pairs$table[i])) {
    cat("No table in database -> keep CSV\n\n")
    next
  }
  
  db_cols <- dbListFields(con, pairs$table[i])
  db_rows <- dbGetQuery(con, paste("SELECT COUNT(*) AS n FROM", pairs$table[i]))$n
  
  cat("Rows  CSV:", nrow(csv), " DB:", db_rows, "\n")
  cat("Missing in DB:", paste(setdiff(names(csv), db_cols), collapse = ", "), "\n")
  cat("Extra in DB  :", paste(setdiff(db_cols, names(csv)), collapse = ", "), "\n\n")
}

dbDisconnect(con)