library(tidyverse)
library(here)

# data packages
# raw
data_url_2 <- "https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/users.csv"
data_dir <- here("Data", "DataA2")
data_file <- file.path(data_dir, "platform_users.csv")
clean_file <- file.path(data_dir, "cleaned_platform_users.csv")

if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

# Download only if the file does not already exist
if (!file.exists(data_file)) {
  download.file(
    url = data_url_2,
    destfile = data_file,
    mode = "wb"
  )
  message("Data downloaded to: ", data_file)
} else {
  message("File already exists. Download skipped.")
}

platform_users <- read_csv(data_file, show_col_types = FALSE)

# cleaned
platform_users_clean <- platform_users %>% drop_na()
write.csv(platform_users_clean, clean_file, row.names = FALSE)

# output folder for the plots
visuals_dir <- here("visuals")
dir.create(visuals_dir, showWarnings = FALSE)

# ggplot
top_beauty <- platform_users_clean %>%
  arrange(desc(pref_BeautyFashion)) %>%
  slice(1:100) %>%
  mutate(group = "Top Beauty/Fashion")

# Top 100 Gaming users
top_gaming <- platform_users_clean %>%
  arrange(desc(pref_Gaming)) %>%
  slice(1:100) %>%
  mutate(group = "Top Gaming")

# Combine both groups
top_users <- bind_rows(top_beauty, top_gaming)

# Create point plot
beautyvsgaming <- ggplot(top_users, aes(x = need_interaction, y = group, color = group)) +
  geom_point(size = 3, alpha = 0.6) +
  scale_color_manual(
    values = c("Top Beauty/Fashion" = "#FF69B4", "Top Gaming" = "#4169E1")
  ) +
  labs(
    title = "Need for Interaction: Top 100 Beauty/Fashion vs Top 100 Gaming Users",
    x = "Need for Interaction Score",
    y = "User Group",
    color = "Group"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 14),
    legend.position = "bottom",
    panel.grid.major.y = element_blank()
  )

ggsave(
  filename = file.path(visuals_dir, "beautyvsgaming.png"),
  plot = beautyvsgaming,
  width = 9, height = 6, dpi = 300)
