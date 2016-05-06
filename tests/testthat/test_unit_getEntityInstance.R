.setUp <-
  function()
{
  synapseClient:::resetFactory(new("FileCacheFactory"))
}

.tearDown <-
  function()
{
  synapseClient:::resetFactory(new("FileCacheFactory"))
}

xxxxTestGetDuplicateWithId <-
  function()
{
  file <- tempfile()
  cat("THIS IS A TEST", file= file)
  root <- tempfile()
  url <- sprintf("http://fakedomain.com%s", root)

  entity <- list(
    id=basename(tempdir()),
    concreteType = "org.sagebionetworks.repo.model.Data",
    locations = list(list('path'= url))
  )

  ee <- synapseClient:::getEntityInstance(entity)
  ee2 <- synapseClient:::getEntityInstance(entity)

  addFile(ee, file)
  checkEquals(ee$files, ee2$files)
  checkEquals(ee$cacheDir, ee2$cacheDir)
}

xxxxTestGetDuplicateNoId <-
  function()
{
  file <- tempfile()
  cat("THIS IS A TEST", file= file)
  root <- tempfile()
  url <- sprintf("http://fakedomain.com%s", root)

  entity <- list(
    concreteType = "org.sagebionetworks.repo.model.Data",
    locations = list(list('path'= url))
  )

  ee <- synapseClient:::getEntityInstance(entity)
  ee2 <- synapseClient:::getEntityInstance(entity)

  addFile(ee, file)
  checkEquals(ee$files, ee2$files)
  checkEquals(ee$cacheDir, ee2$cacheDir)
}
