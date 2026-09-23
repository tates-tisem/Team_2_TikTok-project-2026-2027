# clean_data.R
# Inspects and cleans the raw watch events data.

library(dplyr)
library(lubridate)
library(here)

d <- read.csv(here("Data", "watch_events.csv"))


# inspect the raw data

print(head(d))
str(d)
print(summary(d))
print(colSums(is.na(d)))
print(sum(duplicated(d$watch_event_id)))
print(table(d$action))
print(table(nchar(d$started_at_raw)))


# fix the mixed-format timestamps

d$started_at_std <- ymd_hms(d$started_at_raw, quiet = TRUE)

missing_time <- is.na(d$started_at_std)
d$started_at_std[missing_time] <- as_datetime(as.numeric(d$started_at_raw[missing_time]))

# the raw column is not needed any more
d$started_at_raw <- NULL


# 2. fill the missing watch_seconds

d$started_at <- ymd_hms(d$started_at)
d$ended_at   <- ymd_hms(d$ended_at)

missing_seconds <- is.na(d$watch_seconds)
d$watch_seconds[missing_seconds] <- difftime(d$ended_at[missing_seconds], d$started_at[missing_seconds], units = "secs")


# 3. add the video length

video_lengths <- d %>%
  filter(action == "watch_full") %>%
  group_by(video_id) %>%
  summarise(video_length_sec = max(watch_seconds, na.rm = TRUE))

d <- merge(d, video_lengths, by = "video_id", all.x = TRUE)


# 4. checking the result

print(sum(is.na(d$started_at_std)))
print(sum(is.na(d$watch_seconds)))
print(sum(is.na(d$video_length_sec)))

# 5. saving to the Data folder
write.csv(d, here("Data", "watch_events_clean.csv"), row.names = FALSE)