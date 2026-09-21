# analysis.R

# create folders
if (!dir.exists("../../../Data")) dir.create("../../../Data", recursive = TRUE)
if (!dir.exists("../../../gen/figures")) dir.create("../../../gen/figures", recursive = TRUE)

# download the data
url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/sessions.csv"
if (!file.exists("../../../Data/sessions.csv")) {
  download.file(url, destfile = "../../../Data/sessions.csv", mode = "wb")
}

library(tidyverse)
sessions <- read_csv("../../../Data/sessions.csv")

# basic cleaning
sessions <- sessions %>%
  mutate(
    login_at = as_datetime(login_at),
    date = as.Date(login_at)
  )

# 1. Session duration
duration_plot <- ggplot(data = sessions, aes(x = session_duration_sec)) +
  geom_histogram(fill = "steelblue", bins = 30) +
  labs(
    title = "Distribution of Session Duration",
    x = "Session duration (seconds)",
    y = "Count"
  )

ggsave("../../../gen/figures/session_duration.png", duration_plot)

# 2. Videos viewed
videos_plot <- ggplot(data = sessions, aes(x = videos_viewed)) +
  geom_histogram(fill = "mediumpurple", bins = 30) +
  labs(
    title = "Distribution of Videos Viewed per Session",
    x = "Videos viewed",
    y = "Count"
  )

ggsave("../../../gen/figures/videos_viewed.png", videos_plot)

# 3. Sessions per user
user_sessions <- sessions %>%
  count(user_id)

user_plot <- ggplot(data = user_sessions, aes(x = n)) +
  geom_histogram(fill = "orange", bins = 30) +
  labs(
    title = "Distribution of Sessions per User",
    x = "Number of sessions",
    y = "Count"
  )

ggsave("../../../gen/figures/sessions_per_user.png", user_plot)

# 4. Daily sessions over time
daily_sessions <- sessions %>%
  count(date)

time_plot <- ggplot(data = daily_sessions, aes(x = date, y = n)) +
  geom_line() +
  labs(
    title = "Daily Sessions Over Time",
    x = "Date",
    y = "Number of sessions"
  )

ggsave("../../../gen/figures/daily_sessions.png", time_plot)