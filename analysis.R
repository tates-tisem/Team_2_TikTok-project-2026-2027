# Assignment 2 - build script
#
# Downloads the raw user data, writes the cleaned data table and produces
# every figure in visuals/.  Run with:  Rscript analysis.R   (or: make)

library(tidyverse)
library(here)
library(viridis)

# ---------------------------------------------------------------- data ----

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

# ------------------------------------------------------------ cleaning ----

# remove every row holding an NA, then drop duplicate rows as a safe measure
platform_users_clean <- platform_users %>%
  drop_na() %>%
  distinct()

write.csv(platform_users_clean, clean_file, row.names = FALSE)

# output folder for the plots
visuals_dir <- here("visuals")
dir.create(visuals_dir, showWarnings = FALSE)

# ------------------------------------- 1. missing values, raw vs clean ----

missing_comparison <- tibble(
  column = names(platform_users),
  raw_na = colSums(is.na(platform_users)),
  cleaned_na = colSums(is.na(platform_users_clean))
) %>%
  pivot_longer(cols = -column, names_to = "stage", values_to = "na_count") %>%
  mutate(stage = factor(stage, levels = c("raw_na", "cleaned_na")))

plot_missing_comparison <- ggplot(missing_comparison, aes(x = reorder(column, na_count), y = na_count, fill = stage)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.65) +
  geom_text(
    aes(label = na_count),
    position = position_dodge(width = 0.8),
    hjust = -0.3,
    color = "black",
    size = 2.5
  ) +
  scale_fill_viridis(discrete = TRUE, option = "B", begin = 0.2, end = 0.9) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  coord_flip() +
  labs(
    title = "Comparison of Missing Values: Raw vs. Cleaned Dataset",
    x = "Column",
    y = "Count of NAs",
    fill = "Stage"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 14, family = "sans"),
    axis.title.y = element_text(margin = margin(r = 10), face = "italic", family = "sans"),
    axis.title.x = element_text(margin = margin(t = 10), face = "italic", family = "sans"),
    legend.position = "top",
    legend.title = element_text(face = "bold"),
    axis.text.y = element_text(size = 10, family = "sans"),
    axis.text.x = element_text(size = 10, family = "sans"),
    text = element_text(family = "sans"),
    panel.grid.major.y = element_blank()
  )

ggsave(
  filename = file.path(visuals_dir, "missing_comparison.png"),
  plot = plot_missing_comparison,
  width = 9, height = 6, dpi = 300)

# --------------------------------- 2. satiation decay by preference ----

user_groups <- platform_users_clean %>%
  mutate(
    preference_group = case_when(
      pref_BeautyFashion > pref_Gaming ~ "Beauty/Fashion",
      pref_Gaming > pref_BeautyFashion ~ "Gaming",
      TRUE ~ "Neutral"
    )
  )

satiation_pref <- ggplot(user_groups, aes(x = preference_group, y = satiation_decay, fill = preference_group)) +
  geom_boxplot(alpha = 0.7, width = 0.4) +
  scale_fill_manual(values = c("Beauty/Fashion" = "#FF69B4", "Gaming" = "#4169E1", "Neutral" = "gray60")) +
  labs(
    title = "Satiation Decay by User Preference: Beauty/Fashion vs Gaming",
    x = "User Preference Group",
    y = "Satiation Decay",
    fill = "Preference"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 14),
    legend.position = "bottom",
    panel.grid.major.x = element_blank()
  )

ggsave(
  filename = file.path(visuals_dir, "satiation_pref.png"),
  plot = satiation_pref,
  width = 9, height = 6, dpi = 300)

# ------------------------- 3. beauty preference vs videos watched ----

# random sample so the point plot does not get overcrowded
set.seed(77)
random_sample <- platform_users_clean[sample.int(nrow(platform_users_clean), 800), ]

cor_beauty_video <- ggplot(random_sample, aes(x = pref_BeautyFashion, y = base_videos_watched_mean)) +
  geom_point(alpha = 0.5, size = 2, color = "#FF69B4") +
  geom_smooth(method = "lm", se = TRUE, color = "#FF1493", fill = "#FFB6C1", alpha = 0.2) +
  labs(
    title = "Correlation: Beauty/Fashion Preference vs Videos Watched",
    x = "Beauty/Fashion Preference Score",
    y = "Mean Videos Watched",
    caption = paste("Correlation:", round(cor(random_sample$pref_BeautyFashion,
                                              random_sample$base_videos_watched_mean,
                                              use = "complete.obs"), 3))
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 14),
    plot.caption = element_text(hjust = 0.5, size = 11)
  )

ggsave(
  filename = file.path(visuals_dir, "cor_beauty_video.png"),
  plot = cor_beauty_video,
  width = 9, height = 6, dpi = 300)

# ------------- 4. need for interaction, top 100 of each preference ----

top_beauty <- platform_users_clean %>%
  arrange(desc(pref_BeautyFashion)) %>%
  slice(1:100) %>%
  mutate(group = "Top Beauty/Fashion")

top_gaming <- platform_users_clean %>%
  arrange(desc(pref_Gaming)) %>%
  slice(1:100) %>%
  mutate(group = "Top Gaming")

top_users <- bind_rows(top_beauty, top_gaming)

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
