# TODO: test for SYNR-529
# 
# Author: brucehoff
###############################################################################


# tests that SYNR-529 is fixed
unitTestDollarAssignment <-function()
{
  e<-Evaluation()
  expect_true(is(e, "Evaluation"))
  e$id<-"123"
  expect_true(is(e, "Evaluation"))
  expect_equal("123", e$id)
}
