library(tidyverse)

# check if raw data exists
if (!file.exists("data/data_impressions.csv")) {
  download.file(url, "data/data_impressions.csv")}

# inspect data
data_impressions <- read_csv("data/data_impressions.csv")
print(sum(is.na(data_impressions$score_total)))
print(colSums(is.na(data_impressions)))
print(sum(duplicated(data_impressions$impression_id)))
print(sum(duplicated(data_impressions)))

# clean data
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

write.csv(data_clean, file.path("Data", "cleaned_data_impressions.csv"), row.names = FALSE)
