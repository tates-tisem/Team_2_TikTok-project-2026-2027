# Regression analysis: does having seen a creator before affect watch time?
# Data: SQLite database (watch_logs + video_view)

library(tidyverse)
library(DBI)
library(RSQLite)
library(here)

out_dir <- here("gen", "regression_figures")
dir.create(out_dir, showWarnings = FALSE)

# 1) Load data with SQL ------------------------------------------------------
con <- dbConnect(SQLite(), dbname = here("Data", "tiktok_students.sqlite"))

data <- dbGetQuery(con, "
  SELECT w.user_id, w.creator_id, w.watch_seconds, w.impression_at,
         v.video_length_sec
  FROM watch_logs w
  LEFT JOIN video_view v ON w.video_id = v.video_id
  ORDER BY w.user_id, w.impression_at
") %>% tibble()

dbDisconnect(con)

# 2) Create the variables ----------------------------------------------------
data <- data %>%
  group_by(user_id, creator_id) %>%
  arrange(impression_at, .by_group = TRUE) %>%
  mutate(exposure_no = row_number(),
         seen_before = ifelse(exposure_no > 1, 1, 0)) %>%
  ungroup() %>%
  mutate(long_video = ifelse(video_length_sec > median(video_length_sec, na.rm = TRUE), 1, 0))

# 3) Regressions -------------------------------------------------------------
# m1: starter model
m1 <- lm(watch_seconds ~ seen_before, data = data)

# m2: add a second variable
m2 <- lm(watch_seconds ~ seen_before + long_video, data = data)

# m3: interaction
m3 <- lm(watch_seconds ~ seen_before * long_video, data = data)

# m4: same interaction model with log watch time
m4 <- lm(log(watch_seconds + 1) ~ seen_before * long_video, data = data)

summary(m1)
summary(m2)
summary(m3)
summary(m4)

# 4) Save output -------------------------------------------------------------
capture.output(summary(m1), summary(m2), summary(m3), summary(m4),
               file = file.path(out_dir, "regression_summary.txt"))

# 5) Line chart: watch time by exposure number (m1) --------------------------
exposure_data <- data %>%
  filter(exposure_no <= 20) %>%
  group_by(exposure_no) %>%
  summarise(avg_watch = mean(watch_seconds))

exposure_plot <- ggplot(exposure_data, aes(x = exposure_no, y = avg_watch)) +
  geom_point() +
  geom_line() +
  labs(title = "Average watch time by how often the creator was shown before",
       x = "Impression number (1 = first time seeing this creator)",
       y = "Average watch time (seconds)") +
  theme_minimal()

ggsave(file.path(out_dir, "exposure_plot.png"), exposure_plot, width = 7, height = 5)

# 6) Bar chart: short vs. long video (m2) ------------------------------------
length_data <- data %>%
  filter(!is.na(long_video)) %>%
  group_by(long_video) %>%
  summarise(avg_watch = mean(watch_seconds)) %>%
  mutate(long_video = factor(long_video, labels = c("Short video", "Long video")))

video_length_plot <- ggplot(length_data, aes(x = long_video, y = avg_watch)) +
  geom_col() +
  labs(title = "Average watch time: short vs. long video",
       x = "", y = "Average watch time (seconds)") +
  theme_minimal()

ggsave(file.path(out_dir, "video_length_plot.png"), video_length_plot, width = 7, height = 5)

# 7) Interaction plot (m3) ---------------------------------------------------
interaction_data <- data %>%
  filter(!is.na(long_video)) %>%
  group_by(seen_before, long_video) %>%
  summarise(avg_watch = mean(watch_seconds), .groups = "drop") %>%
  mutate(seen_before = factor(seen_before, labels = c("First time", "Seen before")),
         long_video  = factor(long_video,  labels = c("Short video", "Long video")))

interaction_plot <- ggplot(interaction_data, aes(x = seen_before, y = avg_watch,
                                                 colour = long_video, group = long_video)) +
  geom_point(size = 3) +
  geom_line() +
  labs(title = "Average watch time: seen before x video length",
       x = "", y = "Average watch time (seconds)", colour = "") +
  theme_minimal()

ggsave(file.path(out_dir, "interaction_plot.png"), interaction_plot, width = 7, height = 5)