## ----eval = FALSE-------------------------------------------------------------
#  install.packages("synapser", repos = c("http://ran.synapse.org", "http://cran.fhcrc.org"))

## ----eval = FALSE-------------------------------------------------------------
#  options(repos = c("http://ran.synapse.org", "http://cran.fhcrc.org"))

## ----eval = FALSE-------------------------------------------------------------
#  install.packages("synapser")

## ----collapse=TRUE------------------------------------------------------------
library(synapser)
synLogin()

## ----eval = FALSE-------------------------------------------------------------
#  ?synLogin
#  ?synLogout

## ----collapse = TRUE----------------------------------------------------------
# use hex_digits to generate random string
hex_digits <- c(as.character(0:9), letters[1:6])
projectName <- sprintf("My unique project %s", paste0(sample(hex_digits, 32, replace = TRUE), collapse = ""))
project <- Project(projectName)
project <- synStore(project)

# Create some files
filePath <- tempfile()
connection <- file(filePath)
writeChar("a \t b \t c \n d \t e \t f \n", connection, eos = NULL)
close(connection)
file <- File(path = filePath, parent = project)
# Add a version comment
file$properties$versionComment <- 'Some sort of comment about the new version of the file.'
file <- synStore(file)
synId <- file$properties$id

## ----collapse = TRUE----------------------------------------------------------
fileEntity <- synGet(synId)

## ----collapse = TRUE----------------------------------------------------------
print(fileEntity)

## ----collapse = TRUE----------------------------------------------------------
read.table(fileEntity$path, nrows = 2)

## ----eval = FALSE, collapse = TRUE--------------------------------------------
#  synOnweb(synId)

## ----collapse = TRUE, eval = FALSE--------------------------------------------
#  entity <- synGet("syn00123", downloadLocation = "/path/to/folder")

## ----eval = FALSE-------------------------------------------------------------
#  ?synGet
#  ?synOnweb

## ----collapse = TRUE, eval = FALSE--------------------------------------------
#  project <- Project(projectName)
#  project <- synStore(project)

## ----collapse = TRUE----------------------------------------------------------
dataFolder <- Folder("Data", parent = project)
dataFolder <- synStore(dataFolder)

## ----collapse = TRUE----------------------------------------------------------
filePath <- tempfile()
connection <- file(filePath)
writeChar("this is the content of the file", connection, eos = NULL)
close(connection)
file <- File(path = filePath, parent = dataFolder)
file <- synStore(file)

## ----collapse = TRUE----------------------------------------------------------
file$properties

## ----collapse = TRUE----------------------------------------------------------
file$properties$name <- "different name"

## ----collapse = TRUE----------------------------------------------------------
file <- synStore(file)
file$properties

## ----collapse = TRUE----------------------------------------------------------
children <- synGetChildren(project$properties$id)
as.list(children)

## ----collapse = TRUE----------------------------------------------------------
filesAndFolders <- synGetChildren(project$properties$id, includeTypes = c("file", "folder"))
as.list(filesAndFolders)

## ----collapse = TRUE----------------------------------------------------------
children <- synGetChildren(project$properties$id)
tryCatch({
  while (TRUE) {
    child <- nextElem(children)
    print(child)
  }
}, error = function(e) {
    print("Reached end of list.")
})

## ----collapse = TRUE----------------------------------------------------------
newFolder <- Folder("New Parent", parent = project)
newFolder <- synStore(newFolder)

file <- synMove(file, newFolder)

## ----collapse = TRUE----------------------------------------------------------
synDelete(file)

## ----collapse = TRUE----------------------------------------------------------
folderId <- dataFolder$properties$id
synDelete(project)
tryCatch(
  synGet(folderId),
  error = function(e) {
    message(sprintf("Retrieving a deleted folder causes: %s", as.character(e)))
  },
  silent = TRUE
)

## ----eval = FALSE-------------------------------------------------------------
#  ?Project
#  ?Folder
#  ?File
#  ?Link
#  ?synStore

## ----collapse = TRUE----------------------------------------------------------
# (We use a time stamp just to help ensure uniqueness.)
projectName <- sprintf("My unique project created on %s", format(Sys.time(), "%a %b %d %H%M%OS4 %Y"))
project <- Project(projectName)
# This will erase all existing annotations
project$annotations <- list(annotationName = "annotationValue")
project <- synStore(project)

## ----collapse = TRUE----------------------------------------------------------
project <- synGet(project$properties$id)
project$annotations
synGetAnnotations(project)

## ----collapse = TRUE----------------------------------------------------------
act <- Activity(
  name = "clustering",
  description = "whizzy clustering",
  used = c("syn1234", "syn1235"),
  executed = "syn4567")

## ----collapse = TRUE----------------------------------------------------------
act <- Activity(name = "clustering", description = "whizzy clustering")
act$used(c("syn12345", "syn12346"))
act$executed("syn4567")

## ----collapse = TRUE----------------------------------------------------------
  act$used("syn12345")
  act$used(project)
  act$used(target = "syn12345", targetVersion = 2)

## ----collapse=TRUE------------------------------------------------------------
  act$used("http://mydomain.com/my/awesome/data.RData")
  act$used(url = "http://mydomain.com/my/awesome/data.RData", name = "Awesome Data")
  act$used(url = "https://github.com/joe_hacker/code_repo", name = "Gnarly hacks", wasExecuted = TRUE)

## ----collapse = TRUE----------------------------------------------------------
project <- synGet(project$properties$id)
project <- synStore(project, activity = act)

## ----collapse = TRUE----------------------------------------------------------
project <- synStore(
  project,
  activityName = "data-r-us",
  activityDescription = "downloaded from data-r-us",
  used = "http://data-r-us.com/excellent/data.xyz")

## ----eval = FALSE-------------------------------------------------------------
#  ?Activity
#  ?synDeleteProvenance

## ----collapse = TRUE----------------------------------------------------------
project <- synGet(project$properties$id)
content <- "
# My Wiki Page

Here is a description of my **fantastic** project!
"
# attachment
filePath <- tempfile()
connection <- file(filePath)
writeChar("this is the content of the file", connection, eos = NULL)
close(connection)

wiki <- Wiki(owner = project,
             title = "My Wiki Page",
             markdown = content,
             attachments = list(filePath))
wiki <- synStore(wiki)

## ----collapse = TRUE----------------------------------------------------------
project <- synGet(project$properties$id)
wiki <- synGetWiki(project)
wiki.markdown <- "
# My Wiki Page

Here is a description of my **fantastic** project! Let's
*emphasize* the important stuff.
"

wiki <- synStore(wiki)

## ----eval = FALSE-------------------------------------------------------------
#  ?Wiki
#  ?synGetWiki

## ----collapse = TRUE----------------------------------------------------------
eval <- Evaluation(
  name = sprintf("My unique evaluation created on %s", format(Sys.time(), "%a %b %d %H%M%OS4 %Y")),
  description = "testing",
  contentSource = project$properties$id,
  submissionReceiptMessage = "Thank you for your submission!",
  submissionInstructionsMessage = "This evaluation only accepts files.")
eval <- synStore(eval)

## ----collapse = TRUE----------------------------------------------------------
eval <- synGetEvaluation(eval$id)
eval

## ----collapse = TRUE----------------------------------------------------------
# first create a file to submit
filePath <- tempfile()
connection <- file(filePath)
writeChar("this is my first submission", connection, eos = NULL)
close(connection)
file <- File(path = filePath, parent = project)
file <- synStore(file)
# submit the created file
submission <- synSubmit(eval, file)

## ----collapse = TRUE----------------------------------------------------------
submissions <- synGetSubmissionBundles(eval)
as.list(submissions)

## ----collapse = TRUE, eval = FALSE--------------------------------------------
#  # Not evaluating this section because of SYNPY-235
#  submission <- synGetSubmission(submission$id)
#  submission

## ----collapse = TRUE----------------------------------------------------------
submissionStatus <- synGetSubmissionStatus(submission)
submissionStatus

## ----collapse = TRUE----------------------------------------------------------
submissionStatus$submissionAnnotations

## ----collapse = TRUE, eval = FALSE--------------------------------------------
#  submissionStatus$annotations["doubleAnnos"] <- list(c("rank" = 3))
#  synStore(submissionStatus)

## ----collapse = TRUE----------------------------------------------------------
queryString <- sprintf("query=select * from evaluation_%s LIMIT %s OFFSET %s'", eval$id, 10, 0)
synRestGET(paste("/evaluation/submission/query?", URLencode(queryString), sep = ""))

## ----eval = FALSE-------------------------------------------------------------
#  ?synGetEvaluation
#  ?synSubmit
#  ?synGetSubmissionBundles
#  ?synGetSubmission
#  ?synGetSubmissionStatus

## ----collapse = TRUE----------------------------------------------------------
synGetAcl(project, principal_id = "273950")

## ----collapse = TRUE----------------------------------------------------------
acl <- synSetPermissions(project, principalId = 273949, accessType = list("READ"))
acl

## ----collapse = TRUE----------------------------------------------------------
synGetAcl(project, principal_id = 273950)

## ----collapse = TRUE----------------------------------------------------------
permissions = synGetPermissions(project)
permissions$can_view

## ----eval = FALSE-------------------------------------------------------------
#  ?synGetAcl
#  ?synSetPermissions
#  ?synGetPermissions

## ----collapse = TRUE----------------------------------------------------------
synDelete(project)

## ----eval = FALSE-------------------------------------------------------------
#  ?synRestGET
#  ?synRestPOST
#  ?synRestPUT
#  ?synRestDELETE

