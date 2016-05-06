## test QueryResult object
## 
## Author: J. Christopher Bare <chris.bare@sagebase.org>
###############################################################################

## to run:
## synapseClient:::.integrationTest(testFileRegexp="test_QueryResult.R")

.setUp <-
  function()
{
  ## create a project to fill with entities
  project <- createEntity(Project())
  synapseClient:::.setCache("testProject", project)
}

.tearDown <-
  function()
{
  ## delete the test project
  deleteEntity(synapseClient:::.getCache("testProject"))
}

integrationTestQueryResult_Fetch <- function() {
  project <- synapseClient:::.getCache("testProject")$properties$id

  ## add some children
  folder <- Folder(parentId=project)
  lapply(1:10, function(i) createEntity(folder))

  qr <- synapseClient:::QueryResult$new(sprintf("select id, name, parentId from entity where parentId=='%s'", project), blockSize=5)
  df <- qr$fetch()
  checkEquals(nrow(df),5)
  checkEquals(ncol(df),3)
  df <- qr$fetch()
  checkEquals(nrow(df),5)
  checkEquals(ncol(df),3)

  # test length and names functions
  checkEquals(length(qr), 5)
  checkEquals(class(names(qr)), "character")
  checkEquals(length(names(qr)), 3)
}

integrationTestQueryResult_Collect <- function() {
  project <- synapseClient:::.getCache("testProject")$properties$id

  ## add some children
  folder <- Folder(parentId=project)
  lapply(1:10, function(i) createEntity(folder))

  qr <- synapseClient:::QueryResult$new(sprintf("select id, name, parentId from entity where parentId=='%s'", project), blockSize=3)
  df <- qr$collect()
  checkEquals(nrow(df),3)
  checkEquals(ncol(df),3)
  df <- qr$collect()
  checkEquals(nrow(df),3)
  checkEquals(ncol(df),3)
  df <- qr$collect()
  checkEquals(nrow(df),3)
  checkEquals(ncol(df),3)

  df <- qr$as.data.frame()
  checkEquals(nrow(df),9)
  checkEquals(ncol(df),3)
}

integrationTestQueryResult_CollectAll <- function() {
  project <- synapseClient:::.getCache("testProject")$properties$id

  ## add some children
  folder <- Folder(parentId=project)
  lapply(1:10, function(i) createEntity(folder))

  qr <- synapseClient:::QueryResult$new(sprintf("select id, name, parentId from entity where parentId=='%s' LIMIT 10", project), blockSize=7)
  qr$collect()
  df <- qr$collectAll()
  checkEquals(nrow(df), 10)
}

integrationTestQueryResult_EmptyResult <- function() {
  # query that should have no results
  qr <- synapseClient:::QueryResult$new(
    'select id, name, parentId from entity where parentId=="-1" limit 100', blockSize=25)
  checkEquals(length(qr), 0)
  df <- qr$collect()
  # should result in an empty data frame
  checkEquals(class(df), "data.frame")
  checkEquals(nrow(df), 0)
  checkEquals(ncol(df), 0)
}


