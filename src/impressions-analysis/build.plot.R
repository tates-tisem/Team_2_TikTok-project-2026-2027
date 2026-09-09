library(tidyverse)
dir.create("data", showWarnings = FALSE)
url <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/impressions.csv"
if (!file.exists("data/data_impressions.csv")) {
  download.file(url, "data/data_impressions.csv")
}

data_impressions <- read_csv("data/data_impressions.csv")
data_impressions
sum(is.na(data_impressions$score_total))
colSums(is.na(data_impressions))
print(data_impressions, n = 14)
sum(duplicated(data_impressions$impression_id))
sum(duplicated(data_impressions))
duplicate_ids <- data_impressions %>%
  count(impression_id) %>%
  filter(n>1) %>%
  arrange(desc(n))
duplicate_ids
data_clean <- data_impressions %>% distinct()
nrow(data_clean)
sum(duplicated(data_clean$impression_id))
source_summary <- data_clean %>%
  count(source_bucket) %>%
  mutate(percentage = n / sum(n) * 100) %>%
  arrange(desc(n))
source_summary

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
score_graph
ggsave("png/score_graph.png", width = 7, height = 4)
