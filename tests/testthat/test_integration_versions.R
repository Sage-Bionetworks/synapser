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
	checkEquals(1L, nrow(vers))
	checkEquals("data.frame", class(vers))

	## versions the project
	project$annotations$aname <- "value1"
	project <- storeEntity(project)
	project$annotations$aname <- "value2"
	project <- storeEntity(project)
	vers <- project$available.versions
	checkEquals(1L, nrow(vers))

	## project versions do not change
  project <- getEntity(project$properties$id)
  checkEquals("value2", project$annotations$aname)
	project <- getEntity(project$properties$id, 1)
  checkEquals("value2", project$annotations$aname)
  
	}










