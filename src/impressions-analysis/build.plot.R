library(tidyverse)
dir.create("data", showWarnings = FALSE)
url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/impressions.csv"
if (!file.exists("data/data_impressions.csv")) {
  download.file(url, "data/data_impressions.csv")
}
data_impressions <- read_csv("data/data_impressions.csv")
print(sum(is.na(data_impressions$score_total)))
print(colSums(is.na(data_impressions)))
print(sum(duplicated(data_impressions$impression_id)))
print(sum(duplicated(data_impressions)))
duplicate_ids <- data_impressions %>%
  count(impression_id) %>%
  filter(n>1) %>%
  arrange(desc(n))
print(duplicate_ids)
data_clean <- data_impressions %>% distinct()
# Repeated impression_id values with differing other columns are kept:
# they represent separate impressions of the same video within a session,
# not data errors, so they are not removed here.
print(nrow(data_clean))
print(sum(duplicated(data_clean$impression_id)))
source_summary <- data_clean %>%
  count(source_bucket) %>%
  mutate(percentage = n / sum(n) * 100) %>%
  arrange(desc(n))
print(source_summary)
dir.create("png", showWarnings = FALSE)
score_graph <- ggplot(data_clean, aes(x = score_total, y = feed_rank, color = source_bucket)) + 
  geom_point(alpha = 0.7, size = 2) +
  labs(
    title = "Total Score vs Feed Rank",
    x = "Total score",
    y = "Feed rank",
    color = "Feed source"
  ) +
  theme_minimal()
ggsave("png/score_graph.png", score_graph, width = 7, height = 4)

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
ggsave("png/source_plot.png", source_plot, width = 7, height = 4)
