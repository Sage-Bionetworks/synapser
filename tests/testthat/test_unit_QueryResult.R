## test QueryResult object
## 
## Author: J. Christopher Bare <chris.bare@sagebase.org>
###############################################################################

unitTestQueryResult_LimitAndOffset <- function() {
  qr <- synapseClient:::QueryResult$new('select * from dataset limit 123 offset 456', blockSize=78)
  checkEquals(qr$limit, 123)
  checkEquals(qr$offset, 456)
  checkEquals(qr$blockSize, 78)
  checkEquals(qr$queryStatement, 'select * from dataset')
}

