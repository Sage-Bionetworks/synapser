## test queryLimitAndOffset
## 
## Author: J. Christopher Bare <chris.bare@sagebase.org>
###############################################################################

unitTestQueryLimitAndOffset <- function() {
	q <- "select id, name, parentId from code limit 456 offset 123"
	result <- synapseClient:::.queryLimitAndOffset(q)
	expect_true(!is.null(result))
	expect_equal(result$query, "select id, name, parentId from code")
	expect_equal(result$limit, 456)
	expect_equal(result$offset, 123)

	q <- "select * from dataset limit 100"
	result <- synapseClient:::.queryLimitAndOffset(q)
	expect_true(!is.null(result))
	expect_equal(result$query, "select * from dataset")
	expect_equal(result$limit, 100)
	expect_equal(result$offset, 1)

	q <- "select id, name, parentId from dataset offset 100"
	result <- synapseClient:::.queryLimitAndOffset(q)
	expect_true(!is.null(result))
	expect_equal(result$query, "select id, name, parentId from dataset")
	expect_true(is.na(result$limit))
	expect_equal(result$offset, 100)
}
