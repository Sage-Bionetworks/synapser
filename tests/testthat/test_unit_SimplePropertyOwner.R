# TODO: test for SYNR-529
# 
# Author: brucehoff
###############################################################################


# tests that SYNR-529 is fixed
unitTestDollarAssignment <-function()
{
  e<-Evaluation()
  checkTrue(is(e, "Evaluation"))
  e$id<-"123"
  checkTrue(is(e, "Evaluation"))
  checkEquals("123", e$id)
}
