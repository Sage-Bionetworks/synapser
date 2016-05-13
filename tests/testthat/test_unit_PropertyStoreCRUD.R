#
# 
# Author: furia
###############################################################################

unitTestPropertyNames <-
  function()
{
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "aProp", "aVal")
  
  expect_equal(propertyNames(ps), "aProp")
}

unitTestClearProperty <-
  function()
{
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "aProp", "aVal")
  
  ps <- synapseClient:::setUpdatePropValue(ps, "aProp")
  expect_equal(propertyNames(ps), character()) 
}

unitTestGetSetProperty <-
  function()
{
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "aProp", "aVal")
  expect_equal(synapseClient:::propertyType(ps, "aProp"), "stringAnnotations")
  expect_equal(synapseClient:::getProperty(ps, "aProp"), "aVal")
  expect_equal(class(synapseClient:::getProperty(ps, "aProp")), "character")
  
  ps <- synapseClient:::setProperty(ps, "aProp", 1L)
  expect_equal(synapseClient:::propertyType(ps, "aProp"), "longAnnotations")
  expect_equal(synapseClient:::getProperty(ps, "aProp"), 1L)
  expect_equal(class(synapseClient:::getProperty(ps, "aProp")), "integer")
  
  ps <- synapseClient:::setProperty(ps, "aProp", 1.0)
  expect_equal(synapseClient:::propertyType(ps, "aProp"), "doubleAnnotations")
  expect_equal(synapseClient:::getProperty(ps, "aProp"), 1.0)
  expect_equal(class(synapseClient:::getProperty(ps, "aProp")), "numeric")
  
  ps <- synapseClient:::setProperty(ps, "aProp", 2.0)
  expect_equal(synapseClient:::propertyType(ps, "aProp"), "doubleAnnotations")
  expect_equal(synapseClient:::getProperty(ps, "aProp"), 2.0)
  expect_equal(class(synapseClient:::getProperty(ps, "aProp")), "numeric")
  
  now <- Sys.time()
  ps <- synapseClient:::setProperty(ps, "aProp", now)
  expect_equal(synapseClient:::propertyType(ps, "aProp"), "dateAnnotations")
  expect_true("POSIXct" %in% class(synapseClient:::getProperty(ps, "aProp")))
}

unitTestGetSetVectorProperties <-
  function()
{
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "nums", c(1.0, 2.2, 3.14159, 4.2, 5.0))
  ps <- synapseClient:::setProperty(ps, "stooges", c("Larry", "Moe", "Curly"))
  ps <- synapseClient:::setProperty(ps, "foo", "bar")
  expect_equal(synapseClient:::propertyType(ps, "nums"), "doubleAnnotations")
  expect_equal(synapseClient:::propertyType(ps, "stooges"), "stringAnnotations")
  expect_equal(synapseClient:::propertyType(ps, "foo"), "stringAnnotations")
  expect_equal(synapseClient:::getProperty(ps, "nums"), c(1.0, 2.2, 3.14159, 4.2, 5.0))
  expect_equal(synapseClient:::getProperty(ps, "stooges"), c("Larry", "Moe", "Curly"))
  expect_equal(synapseClient:::getProperty(ps, "foo"), "bar")
}

unitTestIdentical<- function() {
  ps1 <- synapseClient:::TypedPropertyStore()
  ps1 <- synapseClient:::setProperty(ps1, "foo", "bar")
  ps2 <- synapseClient:::TypedPropertyStore()
  ps2 <- synapseClient:::setProperty(ps2, "foo", "bar")
  expect_true(identical(ps1, ps2))
  
  # assign values in a different order
  ps1 <- synapseClient:::TypedPropertyStore()
  ps1 <- synapseClient:::setProperty(ps1, "foo", "bar")
  ps1 <- synapseClient:::setProperty(ps1, "bas", "goo")
  ps2 <- synapseClient:::TypedPropertyStore()
  ps2 <- synapseClient:::setProperty(ps2, "bas", "goo")
  ps2 <- synapseClient:::setProperty(ps2, "foo", "bar")
  expect_true(identical(ps1, ps2))
  
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
  expect_true(all(c("nums", "stooges", "foo", "wazoo") %in% names(vals)))
  expect_equal(vals$nums, c(1.0, 2.2, 3.14159, 4.2, 5.0))
  expect_equal(vals$stooges, c("Larry", "Moe", "Curly"))
  expect_equal(vals$foo, "bar")
  expect_equal(vals$wazoo, 123)
}

unitTestDeleteProperty <-
    function()
{
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "aProp", "aVal")
  
  expect_equal(propertyNames(ps), "aProp")
  ps <- synapseClient:::deleteProperty(ps, "aProp")
  expect_equal(propertyNames(ps), character())
  
  ps <- synapseClient:::TypedPropertyStore()
  ps <- synapseClient:::setProperty(ps, "aProp", "aVal")
  ps <- synapseClient:::setProperty(ps, "aProp2", "aVal2")
  ps <- synapseClient:::setProperty(ps, "anInt", 1L)
  
  expect_equal(length(synapseClient:::propertyNames(ps)), 3L)
  expect_true(all(c("aProp", "aProp2", "anInt") %in% synapseClient:::propertyNames(ps)))
  
  ps <- synapseClient:::deleteProperty(ps, "anInt")
  expect_equal(length(synapseClient:::propertyNames(ps)), 2L)
  expect_true(all(c("aProp", "aProp2") %in% synapseClient:::propertyNames(ps)))
  
}



