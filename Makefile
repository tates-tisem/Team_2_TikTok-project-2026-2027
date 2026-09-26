.PHONY: all clean

# ------------------------------------------------------------
# Default target: build the whole project
# ------------------------------------------------------------

all: src/Assignment3/final_report.pdf


# ------------------------------------------------------------
# SQLite database
# ------------------------------------------------------------

Data/tiktok_students.sqlite: src/download_database.R
	Rscript src/download_database.R


# ------------------------------------------------------------
# Assignment 1: video summary
# ------------------------------------------------------------

src/Assignment1/summary.html: \
	src/Assignment1/summary.qmd \
	Data/tiktok_students.sqlite
	quarto render src/Assignment1/summary.qmd --to html


# ------------------------------------------------------------
# Assignment 2: impressions analysis
# ------------------------------------------------------------

gen/stamps/impressions.done: \
	src/Assignment2/impressions-analysis/data2.R \
	src/Assignment2/impressions-analysis/data2clean.R \
	src/Assignment2/impressions-analysis/build.plot.R
	Rscript src/Assignment2/impressions-analysis/data2.R
	Rscript src/Assignment2/impressions-analysis/data2clean.R
	Rscript src/Assignment2/impressions-analysis/build.plot.R
	mkdir -p gen/stamps
	touch gen/stamps/impressions.done


# ------------------------------------------------------------
# Assignment 2: session analysis
# ------------------------------------------------------------

gen/stamps/sessions.done: \
	src/Assignment2/session-analysis/analysis.R \
	src/Assignment2/session-analysis/analysis2.R
	Rscript src/Assignment2/session-analysis/analysis.R
	Rscript src/Assignment2/session-analysis/analysis2.R
	mkdir -p gen/stamps
	touch gen/stamps/sessions.done


# ------------------------------------------------------------
# Assignment 2: users analysis
# ------------------------------------------------------------

gen/stamps/users.done: \
	src/Assignment2/users_analysis/analysis.R
	Rscript src/Assignment2/users_analysis/analysis.R
	mkdir -p gen/stamps
	touch gen/stamps/users.done


# ------------------------------------------------------------
# Assignment 2: watch events analysis
# ------------------------------------------------------------

gen/stamps/watch_events.done: \
	src/Assignment2/watch_events/download_data.R \
	src/Assignment2/watch_events/clean_data.R \
	src/Assignment2/watch_events/visualize.R
	Rscript src/Assignment2/watch_events/download_data.R
	Rscript src/Assignment2/watch_events/clean_data.R
	Rscript src/Assignment2/watch_events/visualize.R
	mkdir -p gen/stamps
	touch gen/stamps/watch_events.done


# ------------------------------------------------------------
# Assignment 3: regression analysis
# ------------------------------------------------------------

gen/stamps/regression.done: \
	src/Assignment3/regression_sql.R \
	Data/tiktok_students.sqlite
	Rscript src/Assignment3/regression_sql.R
	mkdir -p gen/stamps
	touch gen/stamps/regression.done


# ------------------------------------------------------------
# Final report
# ------------------------------------------------------------

src/Assignment3/final_report.pdf: \
	src/Assignment3/final_report.qmd \
	src/Assignment1/summary.html \
	gen/stamps/impressions.done \
	gen/stamps/sessions.done \
	gen/stamps/users.done \
	gen/stamps/watch_events.done \
	gen/stamps/regression.done \
	Data/tiktok_students.sqlite
	quarto render src/Assignment3/final_report.qmd --to pdf


# ------------------------------------------------------------
# Clean generated outputs
# ------------------------------------------------------------

clean:
	rm -rf gen/stamps
	rm -rf gen/figures
	rm -rf gen/regression_figures
	rm -f src/Assignment3/final_report.pdf
	rm -f Data/data_impressions.csv
	rm -f Data/cleaned_data_impressions.csv
	rm -f Data/sessions.csv
	rm -f Data/platform_users.csv
	rm -f Data/cleaned_platform_users.csv
	rm -f Data/watch_events.csv
	rm -f Data/watch_events_clean.csv