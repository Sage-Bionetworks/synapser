## test queryLimitAndOffset
## 
## Author: J. Christopher Bare <chris.bare@sagebase.org>
###############################################################################

unitTestQueryLimitAndOffset <- function() {
	q <- "select id, name, parentId from code limit 456 offset 123"
	result <- synapseClient:::.queryLimitAndOffset(q)
	checkTrue(!is.null(result))
	checkEquals(result$query, "select id, name, parentId from code")
	checkEquals(result$limit, 456)
	checkEquals(result$offset, 123)

	q <- "select * from dataset limit 100"
	result <- synapseClient:::.queryLimitAndOffset(q)
	checkTrue(!is.null(result))
	checkEquals(result$query, "select * from dataset")
	checkEquals(result$limit, 100)
	checkEquals(result$offset, 1)

	q <- "select id, name, parentId from dataset offset 100"
	result <- synapseClient:::.queryLimitAndOffset(q)
	checkTrue(!is.null(result))
	checkEquals(result$query, "select id, name, parentId from dataset")
	checkTrue(is.na(result$limit))
	checkEquals(result$offset, 100)
}
