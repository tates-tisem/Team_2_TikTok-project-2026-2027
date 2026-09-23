library(tidyverse)
library(here)

# create the figures folder
dir.create(here("gen", "figures"), recursive = TRUE, showWarnings = FALSE)

# download the data
url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/sessions.csv"
data_file <- here("Data", "sessions.csv")
if (!file.exists(data_file)) {
  download.file(url, destfile = data_file, mode = "wb")
}

sessions <- read_csv(data_file)

# Session duration vs videos viewed
duration_videos_plot <- ggplot(
  data = sessions,
  aes(x = session_duration_sec, y = videos_viewed)
) +
  geom_point()

ggsave(
  here("gen", "figures", "duration_vs_videos.png"),
  duration_videos_plot
)

# Session duration vs watch time
duration_watch_plot <- ggplot(
  data = sessions,
  aes(x = session_duration_sec, y = watch_seconds)
) +
  geom_point()

# Videos viewed vs watch time
videos_watch_plot <- ggplot(
  data = sessions,
  aes(x = videos_viewed, y = watch_seconds)
) +
  geom_point() +
  labs(title = "Videos Viewed vs Watch Time", x = "videos_viewed", y = "watch_seconds")

ggsave(
  here("gen", "figures", "videos_vs_watch.png"),
  videos_watch_plot
)

ggsave(
  here("gen", "figures", "duration_vs_watch.png"),
  duration_watch_plot
)
