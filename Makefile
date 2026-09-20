.PHONY: all clean

# default target: build everything
all: Data/data_impressions.csv Data/cleaned_data_impressions.csv src/Assignment2/impressions-analysis/png/score_graph.png src/Assignment2/impressions-analysis/png/source_plot.png

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