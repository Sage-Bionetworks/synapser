.setUp <- 
  function()
{
  dir<-tempdir()
  filePath<-sprintf("%s/efatest.txt", dir)
  synapseClient:::unlockFile(filePath)
}

.tearDown <-
  function()
{
}

integrationTestHappyPath <-
  function()
{
  # lock file
  dir<-tempdir()
  filePath<-sprintf("%s/efatest.txt", dir)
  lockExpirationTimeStamp<-synapseClient:::lockFile(filePath, maxWaitSeconds=2, ageTimeoutSeconds=5)
  checkTrue(!is.na(lockExpirationTimeStamp))
  # expiration is in 5 seconds, so should be less than 10 seconds from now
  checkTrue(lockExpirationTimeStamp<Sys.time()+10)
  checkTrue(file.exists(sprintf("%s.lock", filePath)))
  # write file
  content<-"my dog has fleas!"
  synapseClient:::writeFileAndUnlock(filePath, content, lockExpirationTimeStamp)
  # read file
  checkEquals(content, synapseClient:::readFile(filePath))
  # check that directory is gone
  checkTrue(!file.exists(file.path(dirname(filePath), ".lock")))
}

# test locking a file which already exists
integrationTestLockTimeout <-
  function()
{
  # lock file
  dir<-tempdir()
  filePath<-sprintf("%s/efatest.txt", dir)
  lockExpirationTimeStamp<-synapseClient:::lockFile(filePath, maxWaitSeconds=2, ageTimeoutSeconds=5)
  # assume the lock is held by a process that died
  # second "process" should be able to get the lock
  lockExpirationTimeStamp2<-synapseClient:::lockFile(filePath, ageTimeoutSeconds=5)
  checkTrue(lockExpirationTimeStamp2>=lockExpirationTimeStamp)
  synapseClient:::unlockFile(filePath)
  # check that directory is gone
  checkTrue(!file.exists(file.path(dirname(filePath), ".lock")))
}

integrationTestAcquireLockFailure <-
  function()
{
  # lock file
  dir<-tempdir()
  filePath<-sprintf("%s/efatest.txt", dir)
  lockExpirationTimeStamp<-synapseClient:::lockFile(filePath, maxWaitSeconds=2, ageTimeoutSeconds=5)
  # assume the lock is held by a process that died
  # second "process" fails to get the lock because it doesn't wait long enough
  result<-try(synapseClient:::lockFile(filePath, maxWaitSeconds=.5, ageTimeoutSeconds=5), silent=TRUE)
  checkTrue(class(result)=="try-error")
  synapseClient:::unlockFile(filePath)
  # check that directory is gone
  checkTrue(!file.exists(file.path(dirname(filePath), ".lock")))
}