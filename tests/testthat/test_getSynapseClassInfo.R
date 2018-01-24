context("test getSynapseClassInfo")

name1Methods <- list(list(name="n1m1", doc="doc", args=list()), list(name="n1m2", doc="doc", args=list()))
name2Methods <- list(list(name="n1m1", doc="doc", args=list()), list(name="n1m2", doc="doc", args=list()))
name3Methods <- list(list(name="n1m1", doc="doc", args=list()), list(name="n1m2", doc="doc", args=list()))

test_that(".removeOmittedClassesAndMethods happy case works", {
	class1<-list(name="name1", constructorArgs=list(args=list("arg1"), varargs=list("varargs1"), keywords=list(), defaults=list()), doc="doc", methods=name1Methods)
	class2<-list(name="name2", constructorArgs=list(args=list("arg1"), varargs=list("varargs1"), keywords=list(), defaults=list()), doc="doc", methods=name2Methods)
	class3<-list(name="name3", constructorArgs=list(args=list("arg1"), varargs=list("varargs1"), keywords=list(), defaults=list()), doc="doc", methods=name3Methods)
	simple<-list(class1, class2, class3)
	result<-.removeOmittedClassesAndMethods(simple)
	expect_equal(result, simple)
})

test_that(".removeOmittedClassesAndMethods omits Entity class", {
	class1<-list(name="name1", constructorArgs=list(args=list("arg1"), varargs=list("varargs1"), keywords=list(), defaults=list()), doc="doc", methods=name1Methods)
	entityClass<-list(name="Entity", constructorArgs=list(args=list("arg1"), varargs=list("varargs1"), keywords=list(), defaults=list()), doc="doc", methods=name2Methods)
	class3<-list(name="name3", constructorArgs=list(args=list("arg1"), varargs=list("varargs1"), keywords=list(), defaults=list()), doc="doc", methods=name3Methods)
	classToOmit<-list(class1, entityClass, class3)
	result<-.removeOmittedClassesAndMethods(classToOmit)
	expect_equal(result, list(class1, class3))
})

test_that(".removeOmittedClassesAndMethods omits Entity class", {
	class1<-list(name="name1", constructorArgs=list(args=list("arg1"), varargs=list("varargs1"), keywords=list(), defaults=list()), doc="doc", methods=name1Methods)
	withMethodToOmit<-list(list(name="n1m1", doc="doc", args=list()), list(name="postURI", doc="doc", args=list()))
	class2<-list(name="name3", constructorArgs=list(args=list("arg1"), varargs=list("varargs1"), keywords=list(), defaults=list()), doc="doc", methods=withMethodToOmit)
	classes<-list(class1, class2)
	result<-.removeOmittedClassesAndMethods(classes)
	withMethodOmitted<-list(list(name="n1m1", doc="doc", args=list()))
	class2WithMethodOmitted<-list(name="name3", constructorArgs=list(args=list("arg1"), varargs=list("varargs1"), keywords=list(), defaults=list()), doc="doc", methods=withMethodOmitted)
	expected<-list(class1, class2WithMethodOmitted)
	expect_equal(result, expected)
})


