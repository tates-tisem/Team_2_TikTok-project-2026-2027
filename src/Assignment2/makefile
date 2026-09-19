OUTPUTS = visuals/missing_comparison.png visuals/satiation_pref.png visuals/cor_beauty_video.png visuals/beautyvsgaming.png

all: $(OUTPUTS)

$(OUTPUTS): analysis.R
	Rscript analysis.R

clean:
	rm -rf visuals ../../Data/DataA2/cleaned_platform_users.csv

.PHONY: all clean
