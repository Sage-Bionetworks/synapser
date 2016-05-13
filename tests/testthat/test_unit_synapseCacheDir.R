.setUp <-
	function()
{
	synapseClient:::.setCache("oldWarn", options('warn')[[1]])
	synapseClient:::.setCache("oldCacheDir", synapseCacheDir())
}

.tearDown <-
	function()
{
	options(warn=synapseClient:::.getCache("oldWarn"))
	synapseClient:::.deleteCache("oldWarn")

	for(d in synapseClient:::.getCache("fileChmod")){
		Sys.chmod(d,'0755')
		unlink(d, recursive=TRUE, force=TRUE)
	}
	synapseClient:::.deleteCache('fileChmod')

	for(d in synapseClient:::.getCache("removeDirs")){
		unlink(d, recursive=TRUE, force=TRUE)
	}
	synapseClient:::.deleteCache("removeDirs")
	synapseCacheDir(synapseClient:::.getCache("oldCacheDir"))
	synapseClient:::.deleteCache("oldCacheDir")
}

unitTestReglarFileWithSameNameExists <-
	function()
{
	dd <- tempfile()
	expect_true(!file.exists(dd))

	## create a regular file with this name
	cat("hello world!", file=dd)

	## make sure that no error is generated --expecting a warning instead
	options(warn=0)
	synapseCacheDir(dd)

	## now make sure that an error is generated
	options(warn=2)
	 expect_error(synapseCacheDir(dd))
}

unitTestNewDirReadOnlyParent <-
	function()
{
	if(Sys.info()[['sysname']] != "Windows"){
		parent = tempfile()
		dd = tempfile(tmpdir=parent)
		synapseClient:::.setCache("fileChmod", parent)
		dir.create(parent, showWarnings = FALSE)

		## set parent permissions to read only
		Sys.chmod(parent, "400")

		## make sure that we only get a warning
		options(warn=0)
		synapseCacheDir(dd)
		expect_equal(dd, synapseCacheDir())

		## make sure that a warning is produced
		options(warn=2)
		 expect_error(synapseCacheDir(dd))
	}
}

unitTestSetCacheDirNewDirDoesNotExists <-
	function()
{
	##fail if any warnings are generated
	options(warn=2)
	dd <- tempfile()
	expect_true(!file.exists(dd))

	synapseCacheDir(dd)
	expect_true(file.exists(dd))
	expect_true(file.info(dd)$isdir)

	expect_equal(dd, synapseCacheDir())

}

unitTestSetCacheDirUseTilde <-
	function()
{
	##fail if any warnings are generated
	options(warn=2)

	## make a cache Directory that is a subdir of ~/.synapseCache
	dd <- tempfile(,tmpdir="~/.synapseCache")

	synapseCacheDir(dd)
	expect_equal(dd, synapseCacheDir())

}




