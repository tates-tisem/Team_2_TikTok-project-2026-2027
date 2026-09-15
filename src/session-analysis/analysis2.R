library(tidyverse)

sessions <- read_csv("../../data/sessions.csv")

# Session duration vs videos viewed
duration_videos_plot <- ggplot(
  data = sessions,
  aes(x = session_duration_sec, y = videos_viewed)
) +
  geom_point()

ggsave(
  "../../gen/figures/duration_vs_videos.png",
  duration_videos_plot
)

# Session duration vs watch time
duration_watch_plot <- ggplot(
  data = sessions,
  aes(x = session_duration_sec, y = watch_seconds)
) +
  geom_point()

ggsave(
  "../../gen/figures/duration_vs_watch.png",
  duration_watch_plot
)