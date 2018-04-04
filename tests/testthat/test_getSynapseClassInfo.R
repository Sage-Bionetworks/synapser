context("test getSynapseClassInfo")

nameMethods <- list(list(name="name", doc="doc", args=list()), list(name="name", doc="doc", args=list()))

test_that("omitClasses returns class", {
  class<-list(name="name", constructorArgs=list(args=list("arg"), varargs=list("varargs"), keywords=list(), defaults=list()), doc="doc", methods=nameMethods)
  expect_equal(.synapseClientClassFilter(class), class)
})

test_that("omitClasses omits Entity class", {
  entityClass<-list(name="Entity", constructorArgs=list(args=list("arg"), varargs=list("varargs"), keywords=list(), defaults=list()), doc="doc", methods=nameMethods)
  expect_equal(.synapseClientClassFilter(entityClass), NULL)
})

test_that("omitClasses omits methods", {
  withMethodToOmit<-list(list(name="name", doc="doc", args=list()), list(name="postURI", doc="doc", args=list()))
  class<-list(name="name", constructorArgs=list(args=list("arg"), varargs=list("varargs"), keywords=list(), defaults=list()), doc="doc", methods=withMethodToOmit)
  withMethodOmitted<-list(list(name="name", doc="doc", args=list()))
  classWithMethodOmitted<-list(name="name", constructorArgs=list(args=list("arg"), varargs=list("varargs"), keywords=list(), defaults=list()), doc="doc", methods=withMethodOmitted)
  expect_equal(.synapseClientClassFilter(class), classWithMethodOmitted)
})
