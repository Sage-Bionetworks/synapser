## test QueryResult object
## 
## Author: J. Christopher Bare <chris.bare@sagebase.org>
###############################################################################

unitTestQueryResult_LimitAndOffset <- function() {
  qr <- synapseClient:::QueryResult$new('select * from dataset limit 123 offset 456', blockSize=78)
  expect_equal(qr$limit, 123)
  expect_equal(qr$offset, 456)
  expect_equal(qr$blockSize, 78)
  expect_equal(qr$queryStatement, 'select * from dataset')
}

