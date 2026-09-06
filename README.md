# TikTok-project-template-2026
This repository is a template for the Data preparation and programming skills in fall 2026. 

##  1. Set up project folder structure
### Data\raw
1. Code to download the raw data. 
2. File path for the downloaded CSV file of the raw data.

###  .gitignore
1. Ignore specific (data) files to not be committed to repocitory.
### Src
1. Quadro code to transform raw data into analysable data sets.
2. Run specific codes to understand, change, group data to conclude what can be derived from data.

### AI.md
1. Explain and keep track of AI use for this project.


## 2. Describe the goal of the project
The goal of this project is to become familiar with the GitHub work space and collaborative work. 

Contextwise, the project allows us to implement the quadro verbs in a way to analyse the data and derive conclusions from its output. 


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
6. In different code cell: add command to open data in new variable named "video_view".
7. Steps 1 & 2 are done by one team member then pushed to the other members. 

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
1. Create a quadro file called "summary.qmd" to annalyse the TikTok video dataset and put it into the already existing "src"folder.
2. Load the CSV file from the data\raw folder.
3. The goal is to determine whether short videos keep the audience for longer than longer videos.
4. Start by summarising the total videos, total creators, average video length, and average watch rate.
5. Then group by creator by summarizing the number of videos, the total impressions, and average watch rate. Then arrange from most to least total impressions.
6. Create a group variable to determine the impact of video length on audience's watch behavior. Therefore, define "short" and "long" watchtime. Group by "short" and "long" watchtime and summarise based on videos, watch rate average and watch share average.
7. Conclude on what the data tells you: 
    - The data sets includes more "short" videos than "long" videos, meaning that there is more information on how short videos perfom, which should be taken into account when commenting on the data set.
    - Short videos have a higer watchtime, thus people finish watching shorter videos more often
    - Longer videos still have an audience, but people drop out before the end. 


## 5. List the group members and their contributions

### Melike Ikikardes
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
5. Complete the README (including project structue) assignment.
6. Add to AI.md when necessary.