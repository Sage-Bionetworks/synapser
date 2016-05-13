.setUp <-
	function()
{
	project <- synStore(Project())
	synapseClient:::.setCache("testProject", project)
	synapseClient:::.setCache("oldWarn", options("warn")[[1]])
}

.tearDown <-
	function()
{
	synDelete(synapseClient:::.getCache("testProject"))
	options(warn=synapseClient:::.getCache("oldWarn"))
	synapseClient:::.deleteCache("oldWarn")
}


integrationTestVersionedAnnotationsProject <-
	function()
{
  options(warn=2)
  
  project <- synapseClient:::.getCache("testProject")
	vers <- project$available.versions
	expect_equal(1L, nrow(vers))
	expect_equal("data.frame", class(vers))

	## versions the project
	project$annotations$aname <- "value1"
	project <- storeEntity(project)
	project$annotations$aname <- "value2"
	project <- storeEntity(project)
	vers <- project$available.versions
	expect_equal(1L, nrow(vers))

	## project versions do not change
  project <- getEntity(project$properties$id)
  expect_equal("value2", project$annotations$aname)
	project <- getEntity(project$properties$id, 1)
  expect_equal("value2", project$annotations$aname)
  
	}










