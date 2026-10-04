.PHONY: all clean

# default target: build everything
all: Data/tiktok_students.sqlite Data/data_impressions.csv Data/cleaned_data_impressions.csv src/Assignment2/impressions-analysis/png/score_graph.png src/Assignment2/impressions-analysis/png/source_plot.png

# download the SQLite database
Data/tiktok_students.sqlite: src/download_database.R
	Rscript src/download_database.R
	
# download raw data
Data/data_impressions.csv: src/Assignment2/impressions-analysis/data2.R
	Rscript src/Assignment2/impressions-analysis/data2.R

# download cleaned data
Data/cleaned_data_impressions.csv: src/Assignment2/impressions-analysis/data2clean.R
	Rscript src/Assignment2/impressions-analysis/data2clean.R

# visualize the data (plots)
src/Assignment2/impressions-analysis/png/score_graph.png: src/Assignment2/impressions-analysis/build.plot.R Data/cleaned_data_impressions.csv
	Rscript src/Assignment2/impressions-analysis/build.plot.R

src/Assignment2/impressions-analysis/png/source_plot.png: src/Assignment2/impressions-analysis/build.plot.R Data/cleaned_data_impressions.csv
	Rscript src/Assignment2/impressions-analysis/build.plot.R

# clean up output files

clean:
	-del Data\data_impressions.csv
	-del Data\cleaned_data_impressions.csv
	-del src\Assignment2\impressions-analysis\png\score_graph.png
	-del src\Assignment2\impressions-analysis\png\source_plot.png

# this one does not work on Windows :(
# clean: 
#	rm -f Data/data_impressions.csv
#	rm -f Data/cleaned_data_impressions.csv
#	rm -f src/Assignment2/impressions-analysis/png/score_graph.png
#	rm -f src/Assignment2/impressions-analysis/png/source_plot.png


# Goal
# Make the whole project reproducible from a single command. Create one Makefile in the root of the repository that, when run, downloads the data, cleans it if necessary, runs the different summaries, runs the regression analysis, and combines all the outputs into the final PDF (or, if you want to take it further, into a dashboard).

# Tasks

# Create a single Makefile at the root of the repository that orchestrates the full pipeline end to end.

# Use proper Makefile targets and dependencies, so a step only reruns when its inputs have changed (not on every make call).

# (Optional, more advanced) In addition to a static PDF, turn the final output into an interactive dashboard (e.g. a Quarto dashboard or Shiny app) as the last step of the pipeline.

# Completion

# When everything runs correctly, create a Pull request on GitHub from your branch to your main branch (not to the main repository) and merge to main.

.PHONY: all clean
# default target: build everything
all: Data/tiktok_students.sqlite Data/data_impressions.csv Data/cleaned_data_impressions.csv src/Assignment2/impressions-analysis/png/score_graph.png src/Assignment2/impressions-analysis/png/source_plot.png

# download the SQLite database
Data/tiktok_students.sqlite: src/download_database.R
	Rscript src/download_database.R

##########################################################################################################################################################
##########################################################################################################################################################

# ASSIGNMENT 1
src/Assignment1/summary.html: src/Assignment1/summary.qmd Data/tiktok_students.sqlite
	quarto render src/Assignment1/summary.qmd --to html

##########################################################################################################################################################
##########################################################################################################################################################

# ASSIGNMENT 2

# impression-analysis
	
# download raw data
Data/data_impressions.csv: src/Assignment2/impressions-analysis/data2.R
	Rscript src/Assignment2/impressions-analysis/data2.R

# download cleaned data
Data/cleaned_data_impressions.csv: src/Assignment2/impressions-analysis/data2clean.R
	Rscript src/Assignment2/impressions-analysis/data2clean.R

# visualize the data (plots)
src/Assignment2/impressions-analysis/png/score_graph.png src/Assignment2/impressions-analysis/png/source_plot.png: \
	src/Assignment2/impressions-analysis/build.plot.R Data/cleaned_data_impressions.csv
	Rscript src/Assignment2/impressions-analysis/build.plot.R

# src/Assignment2/impressions-analysis/png/source_plot.png: src/Assignment2/impressions-analysis/build.plot.R Data/cleaned_data_impressions.csv
# Rscript src/Assignment2/impressions-analysis/build.plot.R

##########################################################################################################################################################
# session-analysis
src/Assignment2/session-analysis/figures/duration_vs_videos.png \ src/Assignment2/session-analysis/figures/duration_vs_watch.png \ src/Assignment2/session-analysis/figures/videos_vs_watch.png: \
	src/Assignment2/session-analysis/analysis2.R 
	Rscript src/Assignment2/session-analysis/analysis2.R

	
src/Assignment2/session-analysis/figures/session_duration.png \ src/Assignment2/session-analysis/figures/videos_viewed.png \ src/Assignment2/session-analysis/figures/sessions_per_user.png \ src/Assignment2/session-analysis/figures/daily_sessions.png: \
	src/Assignment2/session-analysis/analysis.R 
	Rscript src/Assignment2/session-analysis/analysis.R

##########################################################################################################################################################
# user_analysis

# download raw data
Data/platforum_users.csv: src/Assignment2/user_analysis/DataA2.qmd
	quarto render src/Assignment2/user_analysis/DataA2.qmd

# download cleaned data
Data/cleaned_platforum_users.csv: src/Assignment2/user_analysis/DataA2.qmd
	quarto render src/Assignment2/user_analysis/DataA2.qmd

src/Assignment2/user_analysis/visuals/beautyvsgaming.png \ src/Assignment2/user_analysis/visuals/cor_beauty_video.png \ src/Assignment2/user_analysis/visuals/missing_comparison.png \ src/Assignment2/user_analysis/visuals/satiation_pref.png: \
	src/Assignment2/user_analysis/analysis.R Data/cleaned_platform_users.csv
	Rscript src/Assignment2/user_analysis/analysis.R

##########################################################################################################################################################
# watch_events
# download raw data
Data/watch_events.csv: src/Assignment2/watch_events/download_data.R
	Rscript src/Assignment2/watch_events/download_data.R

# download cleaned data
Data/watch_events_clean.csv: src/Assignment2/watch_events/clean_data.R
	Rscript src/Assignment2/watch_events/clean_data.R

# visualize the data (plots)
src/Assignment2/watch_events/plots/actions.png src/Assignment2/watch_events/plots/events_per_day.png src/Assignment2/watch_events/plots/watch_time_vs_length.png: \
	src/Assignment2/watch_events/visualize.R Data/watch_events_clean.csv
	Rscript src/Assignment2/watch_events/visualize.R

##########################################################################################################################################################
##########################################################################################################################################################

# ASSIGNMENT 4 (FOLDER ASSIGNMENT 3)

