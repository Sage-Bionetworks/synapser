# 
# Author: brucehoff
###############################################################################


integrationTestCreateColumn<-function() {
  name<-sprintf("R_Client_Integration_Test_Create_Column_%s", sample(999999999, 1))
  # note, for the test to work they must be in alphabetical order,
  # since the values returned by the server are in this order
  enumValues<-c("bar", "bas", "foo")
   
  tableColumn<-TableColumn(
    name=name, 
    columnType="STRING", 
    defaultValue="foo", 
    maximumSize=as.integer(30), 
    enumValues=enumValues)
  
  storedColumn<-synStore(tableColumn)
  
  # should be the same except for the ID
  checkTrue(!is.null(storedColumn$id))
  id<-storedColumn$id
  storedColumn$id<-character(0)
  checkTrue(identical(storedColumn, tableColumn))
  
  retrievedColumn<-synapseClient:::synGetColumn(id)
  storedColumn$id<-id
  checkTrue(identical(retrievedColumn, storedColumn))
}
