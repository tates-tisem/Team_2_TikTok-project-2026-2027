all: ../../gen/figures/session_duration.png \
     ../../gen/figures/videos_viewed.png \
     ../../gen/figures/sessions_per_user.png \
     ../../gen/figures/daily_sessions.png

../../gen/figures/session_duration.png: analysis.R
	Rscript analysis.R

../../gen/figures/videos_viewed.png: analysis.R
	Rscript analysis.R

../../gen/figures/sessions_per_user.png: analysis.R
	Rscript analysis.R

../../gen/figures/daily_sessions.png: analysis.R
	Rscript analysis.R