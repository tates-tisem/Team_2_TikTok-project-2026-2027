all: ../../gen/figures/session_duration.png \
     ../../gen/figures/videos_viewed.png \
     ../../gen/figures/sessions_per_user.png \
     ../../gen/figures/daily_sessions.png \
     ../../gen/figures/duration_vs_videos.png \
     ../../gen/figures/duration_vs_watch.png \
		 ../../gen/figures/videos_vs_watch.png
../../gen/figures/session_duration.png ../../gen/figures/videos_viewed.png ../../gen/figures/sessions_per_user.png ../../gen/figures/daily_sessions.png: analysis.R 
	Rscript analysis.R
../../gen/figures/duration_vs_videos.png ../../gen/figures/duration_vs_watch.png ../../gen/figures/videos_vs_watch.png: analysis2.R
	Rscript analysis2.R
clean:
	rm -f ../../gen/figures/*.png