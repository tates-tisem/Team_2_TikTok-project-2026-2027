
all: plots/events_per_day.png

# download the raw data
../../Data/raw/watch_events.csv: download_data.R
	Rscript download_data.R

# clean the data
../../Data/clean/watch_events_clean.csv: ../../Data/raw/watch_events.csv clean_data.R
	Rscript clean_data.R

# make the plots
plots/events_per_day.png: ../../Data/clean/watch_events_clean.csv visualize.R
	Rscript visualize.R

# delete everything make created, so the next make starts from scratch
clean:
	Rscript -e "unlink(c('../../Data/raw/watch_events.csv', '../../Data/clean', 'plots'), recursive = TRUE)"