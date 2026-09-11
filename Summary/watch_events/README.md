# TikTok Watch Events Analysis

Looks at the spread of user actions, how watch time relates to video
length, and normalises the mixed-format timestamps.

## How to run

Open a terminal in this folder (`Summary/watch_events`) and type:

        make -f makefile

(`-f makefile` is needed with older versions of make on Windows when the
folder path contains non-English characters. On other systems `make` is enough.)

Or run the scripts one by one:

    Rscript download_data.R
    Rscript clean_data.R
    Rscript visualize.R

## Output

- Raw data: `Data/raw/watch_events.csv`
- Clean data: `Data/clean/watch_events_clean.csv`
- Plots: `Summary/watch_events/plots/`

## Packages needed

`dplyr`, `lubridate`, `ggplot2`