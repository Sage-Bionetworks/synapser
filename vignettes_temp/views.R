## ----collapse=TRUE------------------------------------------------------------
library(reticulate)
library(synapser)
syn <- reticulate::import("synapseclient")
EntityViewType <- syn$EntityViewType
synLogin()
# Create a new project
# use hex_digits to generate random string
hex_digits <- c(as.character(0:9), letters[1:6])
projectName <- sprintf("My unique project %s", paste0(sample(hex_digits, 32, replace = TRUE), collapse = ""))
project <- Project(projectName)
project <- synStore(project)

# Create some files
filePath <- tempfile()
connection <- file(filePath)
writeChar("this is the content of the first file", connection, eos = NULL)
close(connection)
file <- File(path = filePath, parent = project)
# Add some annotations
file$annotations = list(contributor = "UW", rank = "X")
file <- synStore(file)

filePath2 <- tempfile()
connection2 <- file(filePath2)
writeChar("this is the content of the second file", connection, eos = NULL)
close(connection2)
file2 <- File(path = filePath2, parent = project)
file2$annotations = list(contributor = "UW", rank = "X")
file2 <- synStore(file2)


## ----collapse=TRUE------------------------------------------------------------
view <- EntityViewSchema(name = "my first file view",
                         columns = c(
                           Column(name = "contributor", columnType = "STRING"),
                           Column(name = "class", columnType = "STRING"),
                           Column(name = "rank", columnType = "STRING")),
                         parent = project$properties$id,
                         scopes = project$properties$id,
                         includeEntityTypes = c(EntityViewType$FILE, EntityViewType$FOLDER),
                         add_default_columns = TRUE)

view <- synStore(view)

## ----collapse=TRUE------------------------------------------------------------
EntityViewType

## ----include = FALSE----------------------------------------------------------
# wait for the view to be created
Sys.sleep(10)

## ----collapse=TRUE------------------------------------------------------------
queryResults <- synTableQuery(sprintf("select * from %s", view$properties$id))

