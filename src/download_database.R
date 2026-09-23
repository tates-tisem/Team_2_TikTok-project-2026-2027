# Download SQLite file from the provided URL

url <- "https://filesender.surf.nl/download.php??token=29803da2-2322-4844-aebf-7e0b95129957&files_ids=38390042"
destination_file <- "Data/tiktok_students.sqlite"

dir.create("Data", showWarnings = FALSE)

# Download the file (only if it is not there yet)

if (!file.exists(destination_file)) {
  options(timeout = 1000)   # large file: default 60s timeout cuts the download off
  download.file(url, destfile = destination_file, mode = "wb")
}

cat("File downloaded successfully to:", destination_file, "\n")
