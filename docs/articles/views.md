# Views

## Views

A view is a view of all entities (File, Folder, Project, Table, Docker
Repository, View) within one or more Projects or Folders. Views can:

- Provide a way of isolating or linking data based on similarities
- Provide the ability to link entities together by their annotations
- Allow view/editing entities attributes in bulk
- Allow entities to be easily searched and queried

Preliminaries:

``` r
library(reticulate)
library(synapser)
## 
## TERMS OF USE NOTICE:
##   When using Synapse, remember that the terms and conditions of use require that you:
##   1) Attribute data contributors when discussing these data or results from these data.
##   2) Not discriminate, identify, or recontact individuals or groups represented by the data.
##   3) Use and contribute only data de-identified to HIPAA standards.
##   4) Redistribute data only under these same terms of use.
syn <- reticulate::import("synapseclient")
EntityViewType <- syn$EntityViewType
synLogin()
## NULL
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
```

Creating a View:

``` r
view <- EntityViewSchema(name = "my first file view",
                         columns = c(
                           Column(name = "contributor", columnType = "STRING"),
                           Column(name = "class", columnType = "STRING"),
                           Column(name = "rank", columnType = "STRING"),
                           Column(name = "string_list", columnType = "STRING_LIST")),
                         parent = project$properties$id,
                         scopes = project$properties$id,
                         includeEntityTypes = c(EntityViewType$FILE, EntityViewType$FOLDER),
                         add_default_columns = TRUE)

view <- synStore(view)
```

We support the following entity type in a View:

``` r
EntityViewType
## <enum 'EntityViewType'>
```

To see the content of your newly created View, use synTableQuery():

``` r
queryResults <- synTableQuery(sprintf("select * from %s", view$properties$id))
```

``` r
data <- as.data.frame(queryResults)
data
```

    ##     ROW_ID ROW_VERSION                             ROW_ETAG          id
    ## 1 74360965           1 4f2a65ed-c85e-41b3-921c-21e95f9a6a8c syn74360965
    ## 2 74360966           1 9def15d0-ad5f-4858-a08d-80a586fb1a0e syn74360966
    ##               name description           createdOn createdBy
    ## 1 file560448300ea6        <NA> 2026-04-06 17:35:06   3324230
    ## 2 file56044b11d950        <NA> 2026-04-06 17:35:09   3324230
    ##                                   etag          modifiedOn modifiedBy
    ## 1 4f2a65ed-c85e-41b3-921c-21e95f9a6a8c 2026-04-06 17:35:06    3324230
    ## 2 9def15d0-ad5f-4858-a08d-80a586fb1a0e 2026-04-06 17:35:09    3324230
    ##                                                                  path type
    ## 1 My unique project c6be45eee35844e7ec1d6ada44bc15ee/file560448300ea6 file
    ## 2 My unique project c6be45eee35844e7ec1d6ada44bc15ee/file56044b11d950 file
    ##   currentVersion    parentId benefactorId   projectId dataFileHandleId
    ## 1              1 syn74360964  syn74360964 syn74360964        170773083
    ## 2              1 syn74360964  syn74360964 syn74360964        170773085
    ##       dataFileName dataFileSizeBytes                   dataFileMD5Hex
    ## 1 file560448300ea6                37 47dfe7f5eaa49a5413c7b79b67ab9c43
    ## 2 file56044b11d950                38 ba01e01b9e3ffea3ebef95efa62998b0
    ##                               dataFileConcreteType        dataFileBucket
    ## 1 org.sagebionetworks.repo.model.file.S3FileHandle proddata.sagebase.org
    ## 2 org.sagebionetworks.repo.model.file.S3FileHandle proddata.sagebase.org
    ##                                                     dataFileKey contributor
    ## 1 3324230/eae86388-fad2-4394-b98d-651d81cb470e/file560448300ea6          UW
    ## 2 3324230/3531c016-c7c3-4cc6-8b86-e8a068c977f9/file56044b11d950          UW
    ##   class rank string_list
    ## 1  <NA>    X        <NA>
    ## 2  <NA>    X        <NA>

## Updating Annotations using View

To update ‘class’ and ‘string_list’ annotations for all files in the
view, simply update the view:

``` r
data["class"] <- list(c("V", "VI"))
# update string_list annotation
string_list_values <- list(list("a,b,c"), list("d,e,f"))
data["string_list"] <- sapply(string_list_values, function(x) rjson::toJSON(x))
synStore(Table(view$properties$id, data))
```

The change in annotations is reflected in synGetAnnotations():

``` r
synGetAnnotations(file2$properties$id)
```

A unique etag is associated with every file that updates when changes
are made to a file, including the contents, annotations, or metadata.
Any updates pushed to Synapse will change an object’s etag.

``` r
data$etag
```

There may be cases where you want to update the annotations on a subset
of files in a view. In order to preserve the etag, and thus the file
history, you will need to store only the rows that have been modified.

``` r
data$contributor[1] <- c("Sage Bionetworks")
synStore(Table(view$properties$id, data[1,]))
## <synapseclient.table.CsvFileTable object at 0x14634c0a0>
```

## Update View’s Content

A view can contain different types of entity. To change the types of
entity that will show up in a view:

``` r
view <- synGet(view$properties$id)
view$set_entity_types(list(EntityViewType$FILE))
```

A View is a Table. Please visit [Tables
vignettes](https://r-docs.synapse.org/articles/tables.md) to see how to
change schema, update content, and other operations that can be done on
View.

``` r
synDelete(project)
## NULL
```
