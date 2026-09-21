library(tidyverse)

# new folders 
if (!dir.exists("../../data")) dir.create("../../data", recursive = TRUE)
if (!dir.exists("../../gen/figures")) dir.create("../../gen/figures", recursive = TRUE)

# download the data 
url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/sessions.csv"
if (!file.exists("../../../Data/sessions.csv")) {
  download.file(url, destfile = "../../../Data/sessions.csv", mode = "wb")
}

sessions <- read_csv("../../../Data/sessions.csv")

# Session duration vs videos viewed
duration_videos_plot <- ggplot(
  data = sessions,
  aes(x = session_duration_sec, y = videos_viewed)
) +
  geom_point()

ggsave(
  "../../../gen/figures/duration_vs_videos.png",
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
  "../../../gen/figures/videos_vs_watch.png",
  videos_watch_plot
)

ggsave(
  "../../../gen/figures/duration_vs_watch.png",
  duration_watch_plot
)