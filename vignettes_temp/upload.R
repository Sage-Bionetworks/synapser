## ----collapse=TRUE------------------------------------------------------------
library(synapser)
synLogin()
# Create a new project
# use hex_digits to generate random string
hex_digits <- c(as.character(0:9), letters[1:6])
projectName <- sprintf("My unique project %s", paste0(sample(hex_digits, 32, replace = TRUE), collapse = ""))
project <- Project(projectName)
project <- synStore(project)

# Create a file
file_path <- tempfile("testUpload.txt")
connection <- file(file_path)
writeChar("this is the content of the file", connection, eos = NULL)
close(connection)
file <- File(path = file_path, parent = project)
file <- synStore(file)
file_id <- file$properties$id

## ----collapse=TRUE------------------------------------------------------------
# fetch the file in Synapse
file_to_update <- synGet(file_id, downloadFile = FALSE)

# create the second version as a separated file
file_path <- tempfile("testUpload.txt")
connection <- file(file_path)
writeChar("this is version 2", connection, eos = NULL)
close(connection)

# save the local path to the new version of the file
file_to_update$path <- file_path

# add a version comment
file_to_update$versionComment <- 'change the file content'

# store the new file
updated_file <- synStore(file_to_update)

## ----collapse=TRUE------------------------------------------------------------
# To create a new version of that file, make sure you store it with the exact same name
new_file <- synStore(File(file_path,  parentId = project$properties$id))

## ----collapse=TRUE------------------------------------------------------------
# Get file from Synapse, set downloadFile = FALSE since we are only updating annotations
file <- synGet(file_id, downloadFile = FALSE)

# Add annotations
file$annotations = c("fileType" = "bam", "assay" = "RNA-seq")

# Store the file without creating a new version
file <- synStore(file, forceVersion = FALSE)

## ----collapse=TRUE------------------------------------------------------------
# Get file from Synapse, set downloadFile = FALSE since we are only updating provenance
file <- synGet(file_id, downloadFile = FALSE)

# Store the file without creating a new version
file <- synStore(file,  activity = Activity(used = project$properties$id), forceVersion = FALSE)

## ----collapse=TRUE------------------------------------------------------------
entity <- synGet(file_id, version = 1)

## ----collapse=TRUE------------------------------------------------------------
synDelete(project)

