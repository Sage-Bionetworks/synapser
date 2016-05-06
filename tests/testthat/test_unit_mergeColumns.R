## test mergeColumns object
## 
## Author: J. Christopher Bare <chris.bare@sagebase.org>
###############################################################################

unitTestMergeColumns <- function() {

	df <- data.frame(a=c(1,2,3), b=c('foo','bar','bat'), stringsAsFactors=FALSE)
	df2 <- synapseClient:::.mergeColumns(df, c('a.new.column','another.new.column'))
	checkEquals(ncol(df2), 4)
	checkEquals(nrow(df2), 3)
	checkEquals(df2$a, c(1,2,3))
	checkEquals(df2$b, c('foo','bar','bat'))
	checkTrue(all(is.na(df2$a.new.column)))
	checkTrue(all(is.na(df2$another.new.column)))

	# no new columns
	df2 <- synapseClient:::.mergeColumns(df, c('a','b'))
  checkEquals(df,df2)

  # empty data.frame
  dfe <- synapseClient:::.mergeColumns(data.frame(), c('a','b','c'))
  checkEquals(nrow(dfe), 0)
}
