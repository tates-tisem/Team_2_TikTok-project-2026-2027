# visualize.R makes the plots and saves them as .png in the plots folder.

library(dplyr)
library(ggplot2)
Sys.setlocale("LC_TIME", "C")

# create the plots folder if it does not exist yet
if (!dir.exists("plots")) {
  dir.create("plots")
}

d <- read.csv("../../Data/clean/watch_events_clean.csv")


# plot 1: spread of actions
p1 <- ggplot(d, aes(x = action)) +
  geom_bar(fill = "steelblue") +
  labs(title = "How users react to a video",
       x = "Action",
       y = "Number of events")

ggsave("plots/actions.png", p1, width = 7, height = 5)


# plot 2: watch time vs video length
set.seed(123)
d_sample <- sample_n(d, 3000)

p2 <- ggplot(d_sample, aes(x = video_length_sec, y = watch_seconds, colour = action)) +
  geom_point(alpha = 0.4) +
  labs(title = "Watch time against video length",
       x = "Video length (seconds)",
       y = "Watched (seconds)",
       colour = "Action")

ggsave("plots/watch_time_vs_length.png", p2, width = 7, height = 5)


# plot 3: events per day
d$day <- as.Date(d$started_at_std)

p3 <- ggplot(d, aes(x = day)) +
  geom_bar(fill = "darkorange") +
  labs(title = "Watch events per day",
       x = "Date",
       y = "Number of events")

ggsave("plots/events_per_day.png", p3, width = 7, height = 5)