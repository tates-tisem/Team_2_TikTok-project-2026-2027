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

