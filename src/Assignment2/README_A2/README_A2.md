# This is the README for Assignment 2 (individual)
## By Tuana Ates

## Goal
The TikTok research has produced a large table of platform users. Each row is one user, with their profile identifiers and a set of behavioural traits (how often they tend to log in, how quickly they get bored, how many videos they usually watch, and their taste for each content category).
It is time to inspect and analyze this user data: 

1. look at how the traits are distributed
2. check whether values are missing or implausible
3. explore how different types of users compare.


## Setup
"Create a new branch in Git and give it an appropriate name, make sure to never merge it into main."
- Name created: "tates_ind_assign_2"

Create a new folder in the code source folder (src), this will be your directory from which you will run your analysis.

1. For the last assignment we had changed "src" to "Summary", I changed it back to src. 
2. I created a new folder in the src folder called "Assignment2".
3. In the Assignment2 folder I added a "Directory" folder and "README_A2" folder. 
    
- Directory: code for data analysis
- README_A2: readme for assignment 
     * I put the Directory and README_A2 folder in the same folder to keep assignment two separated from the main branch folder structure. 
4. In the "Data" folder, a second folder called "DataA2" can be found. 
- DataA2: code to download raw data and location for the derived data table. 
    * At first I put DataA2 in the Assignment2 folder, since our .gitignore included all csv files and not the "Data" file itself. 
    * After asking about it during the tutorial, I got adviced to never put data files in the same place as the source files and to put it in the data file to keep everything together. 
    * Otherwise you risk accidentally pushing the data to GitHub if the .gitignore refers to the Data folder. 

* Note: I also made folder called "Assignment1" to transfer all of assignment one source codes but I am not sure if this was necessary.

## Folder layout

```
Data/DataA2/         download code (DataA2.qmd) and the local data files
src/Assignment2/
    analysis.R       build script: downloads, cleans and writes every figure
    makefile         runs analysis.R when a figure is missing or out of date
    visuals/         the four .png figures
    Directory/       directory2.qmd, the write-up of the analysis
    README_A2/       this readme
```

The two csv files in `Data/DataA2` are never pushed; `.gitignore` covers
`*.csv`.

## Requirements

- R
- Make
- Quarto (only needed to render the .qmd files)
- R packages:

```r
install.packages(c("tidyverse", "here", "viridis", "knitr"))
```

## How to run the analysis

Open a terminal in `src/Assignment2` and run:

```
make
```

That runs `analysis.R`, which downloads `users.csv` into `Data/DataA2`
(about 32 MB, skipped if it is already there), writes
`cleaned_platform_users.csv` next to it, and saves the four figures into
`visuals/`. Running `make` again does nothing while the figures are newer
than the script, which is what "based on the existence of the outputs"
means here.

To force a rebuild:

```
make clean
make
```

`make clean` removes `visuals/` and the cleaned csv, but keeps the
downloaded raw data so it does not have to be fetched again.

## What the analysis does

### Data (Data/DataA2/DataA2.qmd)
1. Downloads the raw data and stores it locally (not pushed).
2. Inspects the data and removes rows containing NAs; `distinct()` is
   applied as a safe measure, it changes nothing.
3. Checks for implausible values: no negative values in
   `base_videos_watched_mean` or `base_videos_watched_sd`.
4. Writes the cleaned table as a separate csv, so raw and cleaned stay
   separate.

`analysis.R` performs the same download and cleaning steps, so the build
does not depend on anyone running the .qmd by hand first.

### Analysis (src/Assignment2/Directory/directory2.qmd)
1. Reads the cleaned data table from `Data/DataA2`.
2. Analyses the data with dplyr verbs and discusses each figure.
3. The figures themselves are produced by `analysis.R` and saved into
   `visuals/`; the document includes them.
4. `missing_comparison.png` compares the raw and cleaned data.
5. `satiation_pref.png` compares satiation decay between users who prefer
   Beauty/Fashion and users who prefer Gaming. No noticeable difference.
6. `cor_beauty_video.png` uses a random sample of 800 users (set.seed(77)
   so the sample stays the same) to check whether Beauty/Fashion
   preference relates to the number of videos watched. No clear trend.
7. `beautyvsgaming.png` compares the need for interaction of the top 100
   Beauty/Fashion users against the top 100 Gaming users.
8. Conclusions for all of the visuals can be found in the document.

### Makefile
1. Runs `analysis.R` based on the existence of the outputs.
2. It sits in `src/Assignment2`, next to the script it runs, and is run
   from that folder.
3. All four figures are declared as outputs, so removing any one of them
   makes `make` rebuild.


## Completion
When everything runs correctly, create a Pull request on GitHub from your forked repository branch to your forked repository main branch (not to the main repository). Leave a small message to a reviewer introducing your feature and asking them to look at it closely. Do not close the pull request or merge the branch!





