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

initAutoGenerateRdFiles(sourceRootDir)

rawString<-":param modified_time: float representing seconds since unix epoch"
expected<-"\nmodified_time: float representing seconds since unix epoch"
expect_equal(pyVerbiageToLatex(rawString), expected)


rawString<-":parameter bitFlags: Bit flags representing which entity components to return"
expected<-"\nbitFlags: Bit flags representing which entity components to return"
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-":parameter team: A :py:class:`Team` object or a team's ID."
expected<-"\nteam: A Team object or a team's ID."
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-":var id:              An immutable ID issued by the platform"
expected<-"\nid:              An immutable ID issued by the platform"
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-":type enumValues: array of strings"
expected<-"\nenumValues: array of strings"
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-"An updated :py:class:`synapseclient.activity.Activity` object"
expected<-"An updated Activity object"
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-"Once that's done, you'll be able to load the library, create a :py:class:`Synapse` object and login"
expected<-"Once that's done, you'll be able to load the library, create a Synapse object and login"
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-"See also: :py:func:`synapseclient.Synapse.chunkedQuery`"
expected<-"See also: synChunkedQuery"
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-"- :py:func:`Synapse.login`"
expected<-"- synLogin"
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-"See also: :py:func:`synapseclient.Synapse.chunkedQuery` ... More robust than :py:func:`synapseclient.Synapse.query`"
expected<-"See also: synChunkedQuery ... More robust than synQuery"
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-"See: :py:mod:`synapseclient.table.Column`"
expected<-"See: Column"
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-":py:meth:`synapseclient.Synapse.store`."
expected<-"synStore."
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-"foo dict() -> new empty dictionary\ndict(mapping) -> new dictionary initialized from a mapping object's\n    (key, value) pairs\ndict(iterable) -> new dictionary initialized as if via:\n    d = {}\n    for k, v in iterable:\n        d[k] = v\ndict(**kwargs) -> new dictionary initialized with the name=value pairs\n    in the keyword argument list.  For example:  dict(one=1, two=2) bar"
expected<-"foo \nConstructor accepts named arguments.\n bar"
dictDocString<-getDictDocString(sourceRootDir)	
expect_equal(pyVerbiageToLatex(rawString), expected)

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

rawString<-":parameter team: A :py:class:`Team` object or a team's ID.\n:returns: a generator over :py:class:`TeamMember` objects."
expected<-list(team=" A :py:class:`Team` object or a team's ID.")
actual<-parseArgDescriptionsFromDetails(rawString)
expect_equal(actual, expected, info=toJSON(actual))

rawString<-"`reference objects <http://docs.synapse.org/rest/org/sagebionetworks/repo/model/Reference.html>`_"
expected<-"\\href{http://docs.synapse.org/rest/org/sagebionetworks/repo/model/Reference.html}{reference objects}"
expect_equal(changeSphinxHyperlinksToLatex(rawString), expected)

rawString<-"may involve some loss of information. See :py:func:`_getRawAnnotations` to get"
expected<-"may involve some loss of information. See _getRawAnnotations to get"
expect_equal(pyVerbiageToLatex(rawString), expected)

rawString<-":returns:This is the returned value.\n\nand not this"
expected<-"This is the returned value."
expect_equal(getReturned(rawString), expected)

rawString<-":return:This is the returned value.\r\n\nand not this"
expected<-"This is the returned value."
expect_equal(getReturned(rawString), expected)

rawString<-":return:This is the returned value.\r\n\nand not this\n\nor this"
expected<-"This is the returned value."
expect_equal(getReturned(rawString), expected)

rawString<-"Get the permissions that a user or group has on an Entity.\n\n:param entity:      An Entity or Synapse ID to lookup\n:param principalId: Identifier of a user or group (defaults to PUBLIC users)\n\n:returns: An array containing some combination of\n\t\t['READ', 'CREATE', 'UPDATE', 'DELETE', 'CHANGE_PERMISSIONS', 'DOWNLOAD', 'PARTICIPATE']\n\t\t or an empty array\n\n"
expected<-" An array containing some combination of\n\t\t['READ', 'CREATE', 'UPDATE', 'DELETE', 'CHANGE_PERMISSIONS', 'DOWNLOAD', 'PARTICIPATE']\n\t\t or an empty array"
expect_equal(getReturned(rawString), expected)

rawString<-"Represents the provenance of a Synapse Entity.\n\r\n:param name:        name of the Activity\n:param description: a short text description of the Activity"
expected<-"Represents the provenance of a Synapse Entity."
expect_equal(getDescription(rawString), expected)

rawString<-"Get the permissions that a user or group has on an Entity.\n\n:param entity:      An Entity or Synapse ID to lookup\n:param principalId: Identifier of a user or group (defaults to PUBLIC users)\n\n:returns: An array containing some combination of\n\t\t['READ', 'CREATE', 'UPDATE', 'DELETE', 'CHANGE_PERMISSIONS', 'DOWNLOAD', 'PARTICIPATE']\n\t\t or an empty array\n\n"
expected<-"Get the permissions that a user or group has on an Entity."
expect_equal(getDescription(rawString), expected)

rawString<-"Represent a `Synapse Team <http://docs.synapse.org/rest/org/sagebionetworks/repo/model/Team.html>`_\nUser definable fields are:\n:param icon:          fileHandleId for icon image of the Team"
expected<-"Represent a `Synapse Team <http://docs.synapse.org/rest/org/sagebionetworks/repo/model/Team.html>`_\nUser definable fields are:"
actual<-getDescription(rawString)
expect_equal(actual, expected)

# if there is no description, should return nothing
rawString<-":param wiki: the Wiki object for which ...\n:return: a list of ..."
expected<-""
actual<-getDescription(rawString)
expect_equal(actual, expected)


rawString<-"Convenience method to create a Synapse object and login.\r\n\nSee :py:func:`synapseclient.Synapse.login` for arguments and usage.\n\nExample::\n\n\timport synapseclient\n\tsyn = synapseclient.login()"
expected<-"\timport synapseclient\n\tsyn = synapseclient.login()"
expect_equal(getExample(rawString), expected)

rawString<-"Convenience method to create a Synapse object and login.\r\n\nSee :py:func:`synapseclient.Synapse.login` for arguments and usage.\n\nExample::\n\n\timport synapseclient\n\tsyn = synapseclient.login()\n\nsome more content"
expected<-"\timport synapseclient\n\tsyn = synapseclient.login()"
expect_equal(getExample(rawString), expected)


rawString<-"\nGets an Evaluation object from Synapse.\n\nSee: :py:mod:`synapseclient.evaluation`\n\nExample::\n\n\tevaluation = syn.getEvalutation(2005090)"
expected<-"\tevaluation = syn.getEvalutation(2005090)"
expect_equal(getExample(rawString), expected)


