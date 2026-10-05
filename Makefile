# git bash and powershell had some issues with "render quarto", these do run in powershell
# I made multiple versions for clean for powershell of command promt but i couldn't get it to work. 
# So git bash: whole file except quarto render lines; powershell/ command promt: everything except clean target.

.PHONY: all clean

# target: build everything
all: Data/tiktok_students.sqlite \
src/Assignment1/summary.html \
Data/data_impressions.csv \
Data/cleaned_data_impressions.csv \
src/Assignment2/impressions-analysis/png/score_graph.png \
src/Assignment2/impressions-analysis/png/source_plot.png \
Data/sessions.csv \
src/Assignment2/session-analysis/figures/duration_vs_videos.png \
src/Assignment2/session-analysis/figures/duration_vs_watch.png \
src/Assignment2/session-analysis/figures/videos_vs_watch.png \
src/Assignment2/session-analysis/figures/session_duration.png \
src/Assignment2/session-analysis/figures/videos_viewed.png \
src/Assignment2/session-analysis/figures/sessions_per_user.png \
src/Assignment2/session-analysis/figures/daily_sessions.png \
Data/platform_users.csv \
Data/cleaned_platform_users.csv \
src/Assignment2/users_analysis/visuals/beautyvsgaming.png \
src/Assignment2/users_analysis/visuals/cor_beauty_video.png \
src/Assignment2/users_analysis/visuals/missing_comparison.png \
src/Assignment2/users_analysis/visuals/satiation_pref.png \
Data/watch_events.csv \
Data/watch_events_clean.csv \
src/Assignment2/watch_events/plots/actions.png \
src/Assignment2/watch_events/plots/events_per_day.png \
src/Assignment2/watch_events/plots/watch_time_vs_length.png \
gen/regression_figures/exposure_plot.png \
gen/regression_figures/interaction_plot.png \
gen/regression_figures/regression_summary.txt \
gen/regression_figures/video_length_plot.png \
src/Assignment3/final_report.pdf

# download the SQLite database
Data/tiktok_students.sqlite: src/download_database.R
	Rscript src/download_database.R

##########################################################################################################################################################
##########################################################################################################################################################

# ASSIGNMENT 1 
# this one only runs with powershell not with git bash 
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
Data/sessions.csv: src/Assignment2/session-analysis/analysis.R
	Rscript src/Assignment2/session-analysis/analysis.R

src/Assignment2/session-analysis/figures/duration_vs_videos.png src/Assignment2/session-analysis/figures/duration_vs_watch.png src/Assignment2/session-analysis/figures/videos_vs_watch.png: \
	src/Assignment2/session-analysis/analysis2.R 
	Rscript src/Assignment2/session-analysis/analysis2.R
	
src/Assignment2/session-analysis/figures/session_duration.png src/Assignment2/session-analysis/figures/videos_viewed.png src/Assignment2/session-analysis/figures/sessions_per_user.png src/Assignment2/session-analysis/figures/daily_sessions.png: \
	src/Assignment2/session-analysis/analysis.R 
	Rscript src/Assignment2/session-analysis/analysis.R

##########################################################################################################################################################
# user_analysis

# download raw data
Data/platform_users.csv: src/Assignment2/users_analysis/analysis.R
	Rscript src/Assignment2/users_analysis/analysis.R

# download cleaned data
Data/cleaned_platform_users.csv: src/Assignment2/users_analysis/analysis.R
	Rscript src/Assignment2/users_analysis/analysis.R

src/Assignment2/users_analysis/visuals/beautyvsgaming.png src/Assignment2/users_analysis/visuals/cor_beauty_video.png src/Assignment2/users_analysis/visuals/missing_comparison.png src/Assignment2/users_analysis/visuals/satiation_pref.png: \
	src/Assignment2/users_analysis/analysis.R Data/cleaned_platform_users.csv
	Rscript src/Assignment2/users_analysis/analysis.R

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

# regression
gen/regression_figures/exposure_plot.png gen/regression_figures/interaction_plot.png gen/regression_figures/regression_summary.txt gen/regression_figures/video_length_plot.png: \
	src/Assignment3/regression_sql.R Data/tiktok_students.sqlite
	Rscript src/Assignment3/regression_sql.R

# final analysis (to turn qmd into pdf, the library tinytex needs to be installed, I put the line for that in the final_report.qmd file)
src/Assignment3/final_report.pdf: src/Assignment3/final_report.qmd Data/tiktok_students.sqlite
	quarto render src/Assignment3/final_report.qmd --to pdf

##########################################################################################################################################################
##########################################################################################################################################################

# this works in git bash not in command prompt or powershell
clean:
	rm -f Data/tiktok_students.sqlite \
src/Assignment1/summary.html \
Data/data_impressions.csv \
Data/cleaned_data_impressions.csv \
src/Assignment2/impressions-analysis/png/score_graph.png \
src/Assignment2/impressions-analysis/png/source_plot.png \
Data/sessions.csv \
src/Assignment2/session-analysis/figures/duration_vs_videos.png \
src/Assignment2/session-analysis/figures/duration_vs_watch.png \
src/Assignment2/session-analysis/figures/videos_vs_watch.png \
src/Assignment2/session-analysis/figures/session_duration.png \
src/Assignment2/session-analysis/figures/videos_viewed.png \
src/Assignment2/session-analysis/figures/sessions_per_user.png \
src/Assignment2/session-analysis/figures/daily_sessions.png \
Data/platform_users.csv \
Data/cleaned_platform_users.csv \
src/Assignment2/users_analysis/visuals/beautyvsgaming.png \
src/Assignment2/users_analysis/visuals/cor_beauty_video.png \
src/Assignment2/users_analysis/visuals/missing_comparison.png \
src/Assignment2/users_analysis/visuals/satiation_pref.png \
Data/watch_events.csv \
Data/watch_events_clean.csv \
src/Assignment2/watch_events/plots/actions.png \
src/Assignment2/watch_events/plots/events_per_day.png \
src/Assignment2/watch_events/plots/watch_time_vs_length.png \
gen/regression_figures/exposure_plot.png \
gen/regression_figures/interaction_plot.png \
gen/regression_figures/regression_summary.txt \
gen/regression_figures/video_length_plot.png \
src/Assignment3/final_report.pdf
	

#SHELL := C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe
#.SHELLFLAGS := -NoProfile -Command
#.PHONY: all clean

#clean:
#	$$files = @(
#		'Data/tiktok_students.sqlite',
#		'src/Assignment1/summary.html',
#		'Data/data_impressions.csv',
#		'Data/cleaned_data_impressions.csv',
#		'src/Assignment2/impressions-analysis/png/score_graph.png',
#		'src/Assignment2/impressions-analysis/png/source_plot.png',
#		'Data/sessions.csv',
#		'src/Assignment2/session-analysis/figures/duration_vs_videos.png',
#		'src/Assignment2/session-analysis/figures/duration_vs_watch.png',
#		'src/Assignment2/session-analysis/figures/videos_vs_watch.png',
#		'src/Assignment2/session-analysis/figures/session_duration.png',
#		'src/Assignment2/session-analysis/figures/videos_viewed.png',
#		'src/Assignment2/session-analysis/figures/sessions_per_user.png',
#		'src/Assignment2/session-analysis/figures/daily_sessions.png',
#		'Data/platform_users.csv',
#		'Data/cleaned_platform_users.csv',
#		'src/Assignment2/users_analysis/visuals/beautyvsgaming.png',
#		'src/Assignment2/users_analysis/visuals/cor_beauty_video.png',
#		'src/Assignment2/users_analysis/visuals/missing_comparison.png',
#		'src/Assignment2/users_analysis/visuals/satiation_pref.png',
#		'Data/watch_events.csv',
#		'Data/watch_events_clean.csv',
#		'src/Assignment2/watch_events/plots/actions.png',
#		'src/Assignment2/watch_events/plots/events_per_day.png',
#		'src/Assignment2/watch_events/plots/watch_time_vs_length.png',
#		'gen/regression_figures/exposure_plot.png',
#		'gen/regression_figures/interaction_plot.png',
#		'gen/regression_figures/regression_summary.txt',
#		'gen/regression_figures/video_length_plot.png',
#		'src/Assignment3/final_report.pdf'
#	)
#	Remove-Item -Force -ErrorAction SilentlyContinue $$files



# CLEAN This usually works on windows if you use powershell but somehow it is not working this time
#	del Data/tiktok_students.sqlite
#	del src/Assignment1/summary.html
#	del Data/data_impressions.csv
#	del Data/cleaned_data_impressions.csv
#	del src/Assignment2/impressions-analysis/png/score_graph.png
#	del src/Assignment2/impressions-analysis/png/source_plot.png
#	del Data/sessions.csv
#	del src/Assignment2/session-analysis/figures/duration_vs_videos.png
#	del src/Assignment2/session-analysis/figures/duration_vs_watch.png
#	del src/Assignment2/session-analysis/figures/videos_vs_watch.png
#	del src/Assignment2/session-analysis/figures/session_duration.png
#	del src/Assignment2/session-analysis/figures/videos_viewed.png
#	del src/Assignment2/session-analysis/figures/sessions_per_user.png
#	del src/Assignment2/session-analysis/figures/daily_sessions.png
#	del Data/platform_users.csv 
#	del Data/cleaned_platform_users.csv
#	del src/Assignment2/users_analysis/visuals/beautyvsgaming.png
#	del src/Assignment2/users_analysis/visuals/cor_beauty_video.png
#	del src/Assignment2/users_analysis/visuals/missing_comparison.png
#	del src/Assignment2/users_analysis/visuals/satiation_pref.png
#	del Data/watch_events.csv 
#	del Data/watch_events_clean.csv
#	del src/Assignment2/watch_events/plots/actions.png
#	del src/Assignment2/watch_events/plots/events_per_day.png
#	del src/Assignment2/watch_events/plots/watch_time_vs_length.png
#	del gen/regression_figures/exposure_plot.png
#	del gen/regression_figures/interaction_plot.png
#	del gen/regression_figures/regression_summary.txt
#	del gen/regression_figures/video_length_plot.png
#	del src/Assignment3/final_report.pdf