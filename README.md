# TikTok-project-template-2026
This repository is a template for the Data preparation and programming skills in fall 2026. 

##  1. Set up project folder structure
### Data\raw
1. Code to download the raw data. 
2. File path for the downloaded CSV file of the raw data.

###  .gitignore
1. Ignore specific (data) files to not be committed to repocitory.

### Summary
1. Quadro code to transform raw data into analysable data sets.
2. Run specific codes to understand, change, group data to conclude what can be derived from data.

### AI.md
1. Explain and keep track of AI use for this project.


## 2. Describe the goal of the project
The goal of this project is to become familiar with the GitHub work space and collaborative work. 

Contextwise, the project allows us to implement the quadro verbs in a way to analyse the data and derive conclusions from its output. 

The methods used are described in 3. and 4. 


## 3. Explain how to set up the environment / install dependencies

### GitHub
1. One member forks repository from the given link.
2. This members enables issues and invites collaborators.
3. Each individual members clones the forked repository to their local working space and open it in Positron.

### Data\raw 
1. Create a folder called data\raw in the "Team_2_TIKTOK-PROJECT-2026-2027" folder.
2. Create a quatro document in the data\raw folder and write a script to download the data from the URL.
3. Define folder and file path for the destination of the data. Folder name: data\raw.
4. Download the url to the designated file.
5. In same code cell: add code to check if file already exists, if it exists, skip download.
6. In different code cell: add command to open data in new variable named "video_view". This can later be used for data analysis in the summary.qmd. 
* Steps 1 & 2 are done by one team member then pushed to the other members. 

### .gitignore
1. To not commit specific files, implement .gitignore
2. Add file called .gitignore and add in the raw data files 
3. This is done because the source can be accessed through the "data\raw" folder and stored locally and does not need to be committed to version control. If it were committed, the repository could become too big, which could cause difficulties with pushing and pulling. Since the data can be accessed otherwise, it is not necessary. 
4. In other instances, it can be used to ignore files that contain sensitive information. Furthermore, it improves effectiveness of data analysis when the raw data continously changes. Instead of continously saving the change in data, the code directly pulls the raw data from the designated source. 

### AI.md
1. Create a new file called AI.md
2. Keep track of how AI is used throughout the document.
3. Command on how it the team members validated the output of the AI tools.


## 4. Explain how to reproduce the analysis (which scripts to run, in which order)

### Summary CSV files
1. Create a quadro file called "summary.qmd" to annalyse the TikTok video dataset and put it into the already existing "summary"folder.
2. Load the CSV file from the data\raw folder (this means that the video_view.qmd is the script to run before the summary.qmd).
3. The goal is to determine whether short videos keep the audience for longer than longer videos.
4. Start by summarising the total videos, total creators, average video length, and average watch rate.
5. Then group by creator by summarizing the number of videos, the total impressions, and average watch rate. Then arrange from most to least total impressions.
6. Create a group variable to determine the impact of video length on audience's watch behavior. Therefore, define "short" and "long" watchtime. Group by "short" and "long" watchtime and summarise based on videos, watch rate average and watch share average.
7. Conclude on what the data tells you: 
    - The data sets includes more "short" videos than "long" videos, meaning that there is more information on how short videos perfom, which should be taken into account when commenting on the data set.
    - Short videos have a higer watchtime, thus people finish watching shorter videos more often
    - Longer videos still have an audience, but people drop out before the end. 

## Data source

All data is stored directly in the `Data` folder (no subfolders).

`src/download_database.R` downloads the SQLite database `Data/tiktok_students.sqlite`.
`src/compare_csv_sqlite.R` compares the old CSV files with the database tables.

| Data         | Source          | Reason |
|--------------|-----------------|--------|
| video_view   | SQLite database | All columns present |
| sessions     | CSV             | No sessions table in the database (can be rebuilt from `watch_logs`) |
| users        | CSV             | `pref_*`, `satiation_decay`, `need_interaction` missing in database |
| impressions  | CSV             | `score_total`, `feed_rank` missing in database |
| watch_events | CSV             | `action`, `started_at_raw`, `ended_at` missing in database |

Note: the database is a larger dataset than the old CSVs (e.g. 50,000 instead of 15,000 videos), so results in `summary.qmd` changed.

## 5. List the group members and their contributions

## Assignment 1
### Melek Zohre Ikikardes
1. Work together with team on the data\raw code.
2. Work together with team on .gitignore file.
3. Figure out with the team how to use the push and pull function.
4. Work on the summary.qmd file.
5. Add to AI.md when necessary.

### Suna Bayhan
1. Work together with team on the data\raw code.
2. Work together with team on .gitignore file.
3. Figure out with the team how to use the push and pull function.
4. Work on the summary.qmd file.
5. Add to AI.md when necessary.

### Zulnara Mahmut
1. Work together with team on the data\raw code.
2. Work together with team on .gitignore file.
3. Figure out with the team how to use the push and pull function.
4. Create the AI.md file.
5. Add to AI.md when necessary.

### Tuana Ates

1. Fork repository
2. Work together with team on the data\raw code.
3. Work together with team on .gitignore file.
4. Figure out with the team how to use the push and pull function.
5. Complete the README assignment (including project structue).
6. (Re)organize project structure.
7. Solve error in summary.qmd code. 
8. Solve nestled folder problem.
9. Add to AI.md when necessary.


# Assignment 4

## Regression analysis
The question is: does it change how long people watch a video if they have seen the creator before? And is this different for short and long videos?
The data comes from the SQLite database (Data/tiktok_students.sqlite). I joined the tables watch_logs and video_view on video_id with SQL. The script is src/Assignment3/regression_sql.R. Run src/download_database.R first, or just run make.

Variables:
1. seen_before: 1 if the user has seen this creator before (impression number higher than 1), 0 if it is the first time.
2. long_video: 1 if the video is longer than the median video length, 0 if not.

Models:
1. m1: watch_seconds ~ seen_before
2. m2: m1 + long_video
3. m3: seen_before * long_video (interaction)
4. m4: same as m3, but with log(watch_seconds + 1) because watch time is skewed
5. m5: logistic regression, was_watched ~ seen_before * long_video (chance that a video is watched)

The output is saved in gen/regression_figures: regression_summary.txt and three plots. 
The plots show the average watch time of the same groups, so they help to check the model results.

Conclusion:
Having seen a creator before is related to a slightly shorter watch time and a slightly lower chance that the video is watched. 
The effect is small and it is the same for short and long videos. This is only a relation, not a cause.

## Makefile
The Makefile I made runs every target created by each of the past targets. We were not aware that Makefiles are supposed to be written during the issues, we thought it was afterwards. But the normal use for make is by optimizing automation so a specific target can be made or regenerated by running make "that specific target". It also helps to keep an oversight of changes that are made in the repository. For instance, a team member can change a script which leads to changing of the file produced from this script. If you don't rerun the changed script, you will have the old output instead of the modified version. Make makes sure that the most recent version is accessed by removing the need to run every single file yourself. 

- .PHONY: This tells the makefile that "all" and "clean" are tasks and not files
- all: when running make, these targets will be rebuild in case there are changes in the script
    - targets after all are written by there exact file path, the backward slash behind it means the line continues on the next line for oversight
- individual targets: these are written as 
    the target (output): script and files it needs to build the target (input)
        Rscript/ render quatro (original file that writes the code to build the target)
    if you want to run a single target, write "make <name target> 
- clean: automation to delete all files at once, also good trick to see if "make" works well. 


Git Bash works fine and according to AI it should also run the quarto render lines, it is probably my laptop that makes it difficult. The Powershell versions should technically work too but it is not working, left them in anyways.

### Melek Zohre Ikikardes
1. Added a script to automate the download of the SQLite database.
2. Implemented a validation script to compare legacy CSV files against SQLite tables.
3. Updated the pipeline to load video_view directly from the SQLite database and removed the obsolete CSV download process.
4. Resolved file paths using here() and ensured all CSV outputs are saved directly to the Data directory.
5. Added the SQLite dependency to the primary Makefile and corrected relative paths in the sub-Makefiles.
6. Documented all project data sources in the README file.
7. Merged Pull Request #20 from tates-tisem/sqlite-import into the main branch.
   
### Suna Bayhan
1. Wrote the code for regression models in src/Assignment3/regression_sql.R
2. Created the variables seen_before and long_video
3. Added plots in gen/regression_figures

### Zulnara Mahmut
1. Worked on Assignment 4 and added the corresponding analysis
2. Contributed to the final report and the analysis/results section
3. Worked on the reproducible project pipeline and README documentation
### Tuana Ates
1. Worked on folder structure and implementing feedback of last assignment
2. Included all targets generated by all past assignments into Makefile
3. Created Makefile versions for Git Bash, Powershell, and Command Prompt
