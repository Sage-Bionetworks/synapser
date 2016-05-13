## test mergeColumns object
## 
## Author: J. Christopher Bare <chris.bare@sagebase.org>
###############################################################################

unitTestMergeColumns <- function() {

	df <- data.frame(a=c(1,2,3), b=c('foo','bar','bat'), stringsAsFactors=FALSE)
	df2 <- synapseClient:::.mergeColumns(df, c('a.new.column','another.new.column'))
	expect_equal(ncol(df2), 4)
	expect_equal(nrow(df2), 3)
	expect_equal(df2$a, c(1,2,3))
	expect_equal(df2$b, c('foo','bar','bat'))
	expect_true(all(is.na(df2$a.new.column)))
	expect_true(all(is.na(df2$another.new.column)))

	# no new columns
	df2 <- synapseClient:::.mergeColumns(df, c('a','b'))
  expect_equal(df,df2)

  # empty data.frame
  dfe <- synapseClient:::.mergeColumns(data.frame(), c('a','b','c'))
  expect_equal(nrow(dfe), 0)
}
