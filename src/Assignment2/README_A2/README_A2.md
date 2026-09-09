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
     * I put the Directory and README_A2 folder in the same folder to keep assignment two seperated from the main branch folder structure. 
4. In the "Data" folder, a second folder called "DataA2" can be found. 
- DataA2: code to download raw data and location for the derived data table. 
    * At first I put DataA2 in the Assignment2 folder, since our .gitignore included all csv files and not the "Data" file itself. 
    * After asking about it during the tutorial, I got adviced to never put data files in the same place as the source files and to put it in the data file to keep everything together. 
    * Otherwise you risk accidentally pushing the data to GitHub if the .gitignore refers to the Data folder. 


## How to reproduce the analysis
### DataA2
1. In this folder create a quadro code that enables downloading the raw data and transform it into a data table (saved locally, not pushed).
2. Clean data if necessary by...

### Directory
1. In this folder create a quadro code that accesses the data table from the DataA2 folder.
2. Add code chuncks to analyse the data using the quadro verbs.
3. Visualize the data with ggplot2 and ggsave as .png into a different folder. 
    - This folder is called:...

### Makefile
1. Create a makefile that runs the scripts based on the existence of the outputs 


## Completion
When everything runs correctly, create a Pull request on GitHub from your forked repository branch to your forked repository main branch (not to the main repository). Leave a small message to a reviewer introducing your feature and asking them to look at it closely. Do not close the pull request or merge the branch!




Make a script that downloads the data into a separate data folder (use dir.create to automatically create a folder if needed). Download the data from https://raw.githubusercontent.com/hannesdatta/course-dprep/refs/heads/main/material/project/coaching_2_data/users.csv

