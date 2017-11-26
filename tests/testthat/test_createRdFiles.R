# This script runs all the markdown files and tests that they do not fail
# 
# Author: bhoff
###############################################################################

require(testthat)
require(rjson)
require(synapser)

context("test_createRdFiles")

sourceRootDir<-"../.."
source(file.path(sourceRootDir, "tools/createRdFiles.R"))

rawString<-":param modified_time: float representing seconds since unix epoch"
expected<-"\nmodified_time: float representing seconds since unix epoch"
expect_equal(processDetails(rawString), expected)


rawString<-":parameter bitFlags: Bit flags representing which entity components to return"
expected<-"\nbitFlags: Bit flags representing which entity components to return"
expect_equal(processDetails(rawString), expected)

rawString<-":parameter team: A :py:class:`Team` object or a team's ID."
expected<-"\nteam: A Team object or a team's ID."
expect_equal(processDetails(rawString), expected)

rawString<-":var id:              An immutable ID issued by the platform"
expected<-"\nid:              An immutable ID issued by the platform"
expect_equal(processDetails(rawString), expected)

rawString<-":type enumValues: array of strings"
expected<-"\nenumValues: array of strings"
expect_equal(processDetails(rawString), expected)

rawString<-":returns: some returned value"
expected<-"returns: some returned value"
expect_equal(processDetails(rawString), expected)

rawString<-"foo bar.  Example:: for example..."
expected<-"foo bar.  "
expect_equal(processDetails(rawString), expected)

rawString<-"end of the text we want:: text we don't want"
expected<-"end of the text we want"
expect_equal(processDetails(rawString), expected)

rawString<-"An updated :py:class:`synapseclient.activity.Activity` object"
expected<-"An updated Activity object"
expect_equal(processDetails(rawString), expected)

rawString<-"Once that's done, you'll be able to load the library, create a :py:class:`Synapse` object and login"
expected<-"Once that's done, you'll be able to load the library, create a Synapse object and login"
expect_equal(processDetails(rawString), expected)

rawString<-"See also: :py:func:`synapseclient.Synapse.chunkedQuery`"
expected<-"See also: synChunkedQuery"
expect_equal(processDetails(rawString), expected)

rawString<-"- :py:func:`Synapse.login`"
expected<-"- synLogin"
expect_equal(processDetails(rawString), expected)

rawString<-"See also: :py:func:`synapseclient.Synapse.chunkedQuery` ... More robust than :py:func:`synapseclient.Synapse.query`"
expected<-"See also: synChunkedQuery ... More robust than synQuery"
expect_equal(processDetails(rawString), expected)

rawString<-"See: :py:mod:`synapseclient.table.Column`"
expected<-"See: Column"
expect_equal(processDetails(rawString), expected)

rawString<-":py:meth:`synapseclient.Synapse.store`."
expected<-"synStore."
expect_equal(processDetails(rawString), expected)

rawString<-"foo dict() -> new empty dictionary\ndict(mapping) -> new dictionary initialized from a mapping object's\n    (key, value) pairs\ndict(iterable) -> new dictionary initialized as if via:\n    d = {}\n    for k, v in iterable:\n        d[k] = v\ndict(**kwargs) -> new dictionary initialized with the name=value pairs\n    in the keyword argument list.  For example:  dict(one=1, two=2) bar"
expected<-"foo \nConstructor accepts arbitrary named arguments.\n bar"
dictDocString<-getDictDocString(sourceRootDir)	
expect_equal(processDetails(rawString, dictDocString), expected)

rawString<-"some junk:parameter bitFlags: Bit flags representing which entity components to return\r\n\nsome trailing gobbledygook"
expected<-list(bitFlags=" Bit flags representing which entity components to return")
expect_equal(parseArgDescriptionsFromDetails(rawString), expected)

rawString<-":parameter foo:bar :parameter bitFlags: Bit flags representing which entity components to return\r\n\nsome trailing gobbledygook"
expected<-list(foo="bar ", bitFlags=" Bit flags representing which entity components to return")
actual<-parseArgDescriptionsFromDetails(rawString)
expect_equal(actual, expected)

rawString<-":parameter foo:fooDescription:parameter bar:barDescription"
expected<-list(foo="fooDescription", bar="barDescription")
actual<-parseArgDescriptionsFromDetails(rawString)
expect_equal(actual, expected)

rawString<-":parameter foo:fooDescription:parameter bar:\"barDescription\""
expected<-list(foo="fooDescription", bar="\"barDescription\"")
actual<-parseArgDescriptionsFromDetails(rawString)
expect_equal(actual, expected)

rawString<-":parameter foo:fooDescription:parameter bar:{barDescription}"
expected<-list(foo="fooDescription", bar="{barDescription}")
actual<-parseArgDescriptionsFromDetails(rawString)
expect_equal(actual, expected)

rawString<-":parameter foo:fooDescription:parameter bar:bar\\Description"
expected<-list(foo="fooDescription", bar="bar\\Description")
actual<-parseArgDescriptionsFromDetails(rawString)
expect_equal(actual, expected)

rawString<-"`reference objects <http://docs.synapse.org/rest/org/sagebionetworks/repo/model/Reference.html>`_"
expected<-"\\href{http://docs.synapse.org/rest/org/sagebionetworks/repo/model/Reference.html}{reference objects}"
expect_equal(changeSphinxHyperlinksToLatex(rawString), expected)
