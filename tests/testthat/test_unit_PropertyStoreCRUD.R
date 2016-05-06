#
# 
# Author: furia
###############################################################################

unitTestPropertyNames <-
  function()
{
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "aProp", "aVal")
  
  checkEquals(propertyNames(ps), "aProp")
}

unitTestClearProperty <-
  function()
{
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "aProp", "aVal")
  
  ps <- synapseClient:::setUpdatePropValue(ps, "aProp")
  checkEquals(propertyNames(ps), character()) 
}

unitTestGetSetProperty <-
  function()
{
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "aProp", "aVal")
  checkEquals(synapseClient:::propertyType(ps, "aProp"), "stringAnnotations")
  checkEquals(synapseClient:::getProperty(ps, "aProp"), "aVal")
  checkEquals(class(synapseClient:::getProperty(ps, "aProp")), "character")
  
  ps <- synapseClient:::setProperty(ps, "aProp", 1L)
  checkEquals(synapseClient:::propertyType(ps, "aProp"), "longAnnotations")
  checkEquals(synapseClient:::getProperty(ps, "aProp"), 1L)
  checkEquals(class(synapseClient:::getProperty(ps, "aProp")), "integer")
  
  ps <- synapseClient:::setProperty(ps, "aProp", 1.0)
  checkEquals(synapseClient:::propertyType(ps, "aProp"), "doubleAnnotations")
  checkEquals(synapseClient:::getProperty(ps, "aProp"), 1.0)
  checkEquals(class(synapseClient:::getProperty(ps, "aProp")), "numeric")
  
  ps <- synapseClient:::setProperty(ps, "aProp", 2.0)
  checkEquals(synapseClient:::propertyType(ps, "aProp"), "doubleAnnotations")
  checkEquals(synapseClient:::getProperty(ps, "aProp"), 2.0)
  checkEquals(class(synapseClient:::getProperty(ps, "aProp")), "numeric")
  
  now <- Sys.time()
  ps <- synapseClient:::setProperty(ps, "aProp", now)
  checkEquals(synapseClient:::propertyType(ps, "aProp"), "dateAnnotations")
  checkTrue("POSIXct" %in% class(synapseClient:::getProperty(ps, "aProp")))
}

unitTestGetSetVectorProperties <-
  function()
{
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "nums", c(1.0, 2.2, 3.14159, 4.2, 5.0))
  ps <- synapseClient:::setProperty(ps, "stooges", c("Larry", "Moe", "Curly"))
  ps <- synapseClient:::setProperty(ps, "foo", "bar")
  checkEquals(synapseClient:::propertyType(ps, "nums"), "doubleAnnotations")
  checkEquals(synapseClient:::propertyType(ps, "stooges"), "stringAnnotations")
  checkEquals(synapseClient:::propertyType(ps, "foo"), "stringAnnotations")
  checkEquals(synapseClient:::getProperty(ps, "nums"), c(1.0, 2.2, 3.14159, 4.2, 5.0))
  checkEquals(synapseClient:::getProperty(ps, "stooges"), c("Larry", "Moe", "Curly"))
  checkEquals(synapseClient:::getProperty(ps, "foo"), "bar")
}

unitTestIdentical<- function() {
  ps1 <- synapseClient:::TypedPropertyStore()
  ps1 <- synapseClient:::setProperty(ps1, "foo", "bar")
  ps2 <- synapseClient:::TypedPropertyStore()
  ps2 <- synapseClient:::setProperty(ps2, "foo", "bar")
  checkTrue(identical(ps1, ps2))
  
  # assign values in a different order
  ps1 <- synapseClient:::TypedPropertyStore()
  ps1 <- synapseClient:::setProperty(ps1, "foo", "bar")
  ps1 <- synapseClient:::setProperty(ps1, "bas", "goo")
  ps2 <- synapseClient:::TypedPropertyStore()
  ps2 <- synapseClient:::setProperty(ps2, "bas", "goo")
  ps2 <- synapseClient:::setProperty(ps2, "foo", "bar")
  checkTrue(identical(ps1, ps2))
  
}

unitTestPropertyValues <-
  function()
{
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "foo", "bar")
  ps <- synapseClient:::setProperty(ps, "wazoo", 123)
  
  ps <- synapseClient:::setProperty(ps, "nums", c(1.0, 2.2, 3.14159, 4.2, 5.0))
  ps <- synapseClient:::setProperty(ps, "stooges", c("Larry", "Moe", "Curly"))
  
  expected <- list(
    nums=c(1.0, 2.2, 3.14159, 4.2, 5.0),
    stooges=c("Larry", "Moe", "Curly"),
    foo="bar",
    wazoo=123
  )

  vals <- synapseClient:::propertyValues(ps)
  checkTrue(all(c("nums", "stooges", "foo", "wazoo") %in% names(vals)))
  checkEquals(vals$nums, c(1.0, 2.2, 3.14159, 4.2, 5.0))
  checkEquals(vals$stooges, c("Larry", "Moe", "Curly"))
  checkEquals(vals$foo, "bar")
  checkEquals(vals$wazoo, 123)
}

unitTestDeleteProperty <-
    function()
{
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "aProp", "aVal")
  
  checkEquals(propertyNames(ps), "aProp")
  ps <- synapseClient:::deleteProperty(ps, "aProp")
  checkEquals(propertyNames(ps), character())
  
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "aProp", "aVal")
  ps <- synapseClient:::setProperty(ps, "aProp2", "aVal2")
  ps <- synapseClient:::setProperty(ps, "anInt", 1L)
  
  checkEquals(length(synapseClient:::propertyNames(ps)), 3L)
  checkTrue(all(c("aProp", "aProp2", "anInt") %in% synapseClient:::propertyNames(ps)))
  
  ps <- synapseClient:::deleteProperty(ps, "anInt")
  checkEquals(length(synapseClient:::propertyNames(ps)), 2L)
  checkTrue(all(c("aProp", "aProp2") %in% synapseClient:::propertyNames(ps)))
  
}



