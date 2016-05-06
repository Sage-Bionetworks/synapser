## Unit tests for checking for integer values
##
## Author: Matthew D. Furia <matt.furia@sagebase.org>
###############################################################################

unitTestCheckSingleValue <-
  function()
{
  val <- 5
  checkTrue(synapseClient:::checkInteger(val))
  
  val <- 5L
  checkTrue(synapseClient:::checkInteger(val))
  
  val <- "5"
  checkTrue(!synapseClient:::checkInteger(val))
  
  val <- 5.0000000
  checkTrue(synapseClient:::checkInteger(val))
  
  val <- "5L"
  checkTrue(!synapseClient:::checkInteger(val))
  
  val <- 5 + .Machine$double.eps
  checkTrue(synapseClient:::checkInteger(val))
  
  val <- 5 - .Machine$double.eps
  checkTrue(synapseClient:::checkInteger(val))
  
  val <- -5
  checkTrue(synapseClient:::checkInteger(val))
  
  
  val <- "5l"
  checkTrue(!synapseClient:::checkInteger(val))
  
  val <- "A"
  checkTrue(!synapseClient:::checkInteger(val))
  
  val <- File(name="foo", parentId="bar")
  checkTrue(!synapseClient:::checkInteger(val))
  
  val <- sum
  checkTrue(!synapseClient:::checkInteger(val))
  
  val <- 5.00001
  checkTrue(!synapseClient:::checkInteger(val))
  
  val <- "53082535172170281e54918781912015"
  checkTrue(!synapseClient:::checkInteger(val))
  
  val <- "-12345e12345"
  checkTrue(!synapseClient:::checkInteger(val))
  
  val <- "--12345"
  checkTrue(!synapseClient:::checkInteger(val))
  
  val <- "12345e+0"
  checkTrue(!synapseClient:::checkInteger(val))
  
  val <- "12345e-0"
  checkTrue(!synapseClient:::checkInteger(val))
}

unitTestFactors <-
  function()
{
  val <- factor(c('a','b','c'))
  checkTrue(all(!synapseClient:::checkInteger(val)))
}

unitTestS4Class <-
  function()
{
  checkTrue(!synapseClient:::checkInteger(new("Entity")))
}

unitTestMultipleValues <-
  function()
{
  checkTrue(all(synapseClient:::checkInteger(1:1000)))
  checkTrue(all(!synapseClient:::checkInteger(c('a','ab','foo','d'))))
  val <- factor(c('a','b','c'))
  
}

unitTestMultipleValuesMixedTypes <-
  function()
{
  val <- c(1, 3.001, "a", 6, 7, sum, File(name="foo", parentId="bar"))
  res <- c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE)
  checkTrue(all(synapseClient:::checkInteger(val) == res))
}

unitTestNamedList <-
  function()
{
  emptyNamedList<-structure(list(), names = character()) # copied from RJSONIO
  checkTrue(!synapseClient:::checkInteger(emptyNamedList))
  
  val <- list()
  emptyNamedList<-structure(list(), names = character()) # copied from RJSONIO
  val[[2]] <- emptyNamedList
  res <- c(FALSE, FALSE)
  checkTrue(all(res == synapseClient:::checkInteger(val)))
  
  
}

unitTestListContainingLists <-
  function()
{
  val <- list()
  val[[1]] <- 1L
  val[[2]] <- list(a=1,b=2)
  
  res <- c(TRUE, FALSE)
  
  checkTrue(all(res == synapseClient:::checkInteger(val)))
}

unitTestConvertIntegersToCharacters<-function() {
  checkEquals(list(list(c(foo="1",bar="2"),c(foo="1",bar="2"))),
    synapseClient:::convertIntegersToCharacters(list(list(c(foo=1,bar=2),c(foo=1,bar=2))))
  )
}

