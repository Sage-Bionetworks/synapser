unitTestDollarSignAccessor <-
	function()
{
	obj <- new("SynapseProperties")
	obj$foo <- "bar"
	expect_equal(obj$foo, "bar")
}

unitTestBracketAccessor <-
	function()
{
	obj <- new("SynapseProperties")
	obj$foo <- "bar"
	expect_equal(obj['foo'], list(foo="bar"))
	expect_equal(names(obj['foo']), 'foo')
	expect_equal(class(obj['foo']), 'list')
}

unitTestDoubleBracketAccessor <-
	function()
{
	obj <- new("SynapseProperties")
	obj$foo <- "bar"
	expect_equal(obj[['foo']], "bar")
	expect_equal(class(obj[['foo']]), 'character')
}

unitTestDollarSignReplacement <-
	function()
{
	obj <- new("SynapseProperties")
	obj$foo <- "bar"
	expect_equal(obj$foo, "bar")
	obj$foo <- "goo"
	expect_equal(obj$foo, "goo")
	obj$blah <- 'gah'
	expect_equal(obj$blah, "gah")
}

unitTestBracketReplacement <-
	function()
{
	obj <- new("SynapseProperties")
	obj['foo'] <- "bar"
	expect_equal(obj['foo'], list(foo="bar"))
	expect_equal(names(obj['foo']), 'foo')
	expect_equal(class(obj['foo']), 'list')
}

unitTestDoubleBracketReplacement <-
	function()
{
	obj <- new("SynapseProperties")
	obj[['foo']] <- "bar"
	expect_equal(obj['foo'], list(foo="bar"))
	expect_equal(names(obj['foo']), 'foo')
	expect_equal(class(obj['foo']), 'list')
	expect_equal(obj$foo, "bar")
}

unitTestSetPropertyValueReplacement <-
	function()
{
	obj <- new("SynapseProperties")
	propertyValue(obj, "foo") <- "bar"
	expect_equal(obj$foo, "bar")
}

unitTestPropertyValue <-
	function()
{
	obj <- new("SynapseProperties")
	propertyValue(obj, "foo") <- "bar"
	expect_equal(propertyValue(obj, "foo"), "bar")
}

unitTestPropertyValues <-
	function()
{
	obj <- new("SynapseProperties")
	propertyValue(obj, "foo") <- "bar"
	expect_equal(propertyValues(obj), "bar")
}

unitTestPropertyNames <-
	function()
{
	obj <- new("SynapseProperties")
	propertyValue(obj, "foo") <- "bar"
	expect_equal(propertyNames(obj), "foo")
}

unitTestAsList <-
	function()
{
	obj <- new("SynapseProperties")
	propertyValue(obj, "foo") <- "bar"
	propertyValue(obj, "goo") <- "boo"
	ans <- synapseClient:::as.list.SynapseProperties(obj)
	expect_equal(class(ans), "list")
	expect_true(all(names(ans) %in% c('foo','goo')))
	expect_true(all(c('foo','goo') %in% names(ans)))
	expect_equal(length(ans), 2L)
	expect_equal(ans$foo, obj$foo)
	expect_equal(ans$goo, obj$goo)
}

unitTestNames <-
	function()
{
	obj <- new("SynapseProperties")
	propertyValue(obj, "foo") <- "bar"
	propertyValue(obj, "goo") <- "boo"
	
	expect_equal(length(synapseClient:::names.SynapseProperties(obj)), 2L)
	expect_true(all(synapseClient:::names.SynapseProperties(obj) %in% c('foo','goo')))
	expect_true(all(c('foo','goo') %in% synapseClient:::names.SynapseProperties(obj)))
}

unitTestConstructorNoArg <-
	function()
{
	obj <- synapseClient:::SynapseProperties()
	expect_equal(synapseClient:::names.SynapseProperties(obj), character())
}

unitTestConstructorList <-
	function()
{
	obj <- synapseClient:::SynapseProperties(list(foo="character", boo="integer", goo="numeric"))
	expect_true(all(synapseClient:::names.SynapseProperties(obj) %in% c('foo','boo','goo')))
	expect_true(all(c('foo','boo','goo') %in% synapseClient:::names.SynapseProperties(obj)))

	expect_equal(obj[['foo']], NULL)
	expect_equal(obj[['boo']], NULL)
	expect_equal(obj[['goo']], NULL)
}

unitTestDeleteProperty <-
	function()
{
	obj <- new("SynapseProperties")
	propertyValue(obj, "foo") <- "bar"
	obj <- deleteProperty(obj, "foo")
	expect_equal(length(propertyNames(obj)), 0L)
}

unitTestSetPropertyNull <-
	function()
{
	## this should be the equivilant of calling deleteProperty
	obj <- new("SynapseProperties")
	propertyValue(obj, "foo") <- "bar"
	obj$foo <- NULL
	expect_equal(length(propertyNames(obj)), 0L)
}


