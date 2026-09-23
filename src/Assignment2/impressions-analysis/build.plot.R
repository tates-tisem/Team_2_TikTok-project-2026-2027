library(tidyverse)
library(here)

data_clean <- read_csv(here("Data", "cleaned_data_impressions.csv"))

# folder where the plots are saved
png_dir <- here("src", "Assignment2", "impressions-analysis", "png")
dir.create(png_dir, showWarnings = FALSE, recursive = TRUE)

score_graph <- ggplot(data_clean, aes(x = score_total, y = feed_rank, color = source_bucket)) + 
  geom_point(alpha = 0.7, size = 2) +
  labs(
    title = "Total Score vs Feed Rank",
    x = "Total score",
    y = "Feed rank",
    color = "Feed source"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(png_dir, "score_graph.png"),
  plot = score_graph,
  width = 7, height = 4, dpi = 300)

# if source_summary is going to be used more ofted, make seperate csv for it. for now this is fine.
source_summary <- data_clean %>%
  count(source_bucket) %>%
  mutate(percentage = n / sum(n) * 100) %>%
  arrange(desc(n))
print(source_summary)

source_plot <- ggplot(source_summary, aes(x = reorder(source_bucket, -n), y = percentage, fill = source_bucket)) +
  geom_col() +
  labs(
    title = "Impression Share by Source",
    x = "Source",
    y = "Percentage (%)",
    fill = "Feed source"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave(
  filename = file.path(png_dir, "source_plot.png"),
  plot = source_plot,
  width = 7, height = 4, dpi = 300)