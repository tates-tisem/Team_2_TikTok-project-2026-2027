DATA = ../../../Data

all: plots/events_per_day.png

# watch_events is not in the database (action, started_at_raw missing), so it still comes from CSV
$(DATA)/watch_events.csv: download_data.R
	Rscript download_data.R

# clean the data
$(DATA)/watch_events_clean.csv: $(DATA)/watch_events.csv clean_data.R
	Rscript clean_data.R

# make the plots
plots/events_per_day.png: $(DATA)/watch_events_clean.csv visualize.R
	Rscript visualize.R

# delete everything make created, so the next make starts from scratch
clean:
	Rscript -e "unlink(c('$(DATA)/watch_events.csv', '$(DATA)/watch_events_clean.csv', 'plots'), recursive = TRUE)"