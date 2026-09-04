# AI use

For this project , we used chatgpt(OpenAI, GPT-5.6 Sol, default settings)

We mainly used ChatGPT when we were unsure about R code or Git commands. For example, we used it to help us write and understand the code for creating the `Data/raw` folder and downloading `video_view.csv`.

## Examples of AI-assisted code
```r
data_dir <- file.path("Data", "raw")
data_file <- file.path(data_dir, "video_view.csv")

if (!dir.exists(data_dir)) {
  dir.create(data_dir, recursive = TRUE)
}

if (!file.exists(data_file)) {
  download.file(
    url = data_url,
    destfile = data_file,
    mode = "wb"
  )
}
```
## Git and GitHub troubleshooting

We also used ChatGPT to troubleshoot Git and GitHub issues. For example, we used it to understand why our changes were not pushed successfully, how to check the repository status, and how to configure Git correctly.

ChatGPT helped us understand commands such as:

```bash
git status
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git push origin main


```
## Review and validation

We did not use AI outputs without checking them. For R code, we ran the code in Positron and checked whether the files were created in the correct folders and whether the dataset was downloaded successfully.

For Git and GitHub, we checked the output of commands such as `git status` and `git push`. We also checked the GitHub repository after pushing to confirm whether the files actually appeared there.

When an AI suggestion did not solve the problem immediately, we checked the error message and adjusted the commands step by step.