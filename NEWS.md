## synapser 0.6
___

### New Features

* New method `set_entity_views` in `EntityViewSchema` allows replacing the entity types that will appears in a view.
* New message on package load notifies users when a new `synapser` version is available on Sage's ran.

### Improvements

* `synSetAnnotations()` documentation now clearly states that the function will replace the existing annotations. ([SYNR-1361](https://sagebionetworks.jira.com/browse/SYNR-1361))
* The `Table()` reference documentation now has a link to the Table vignette. ([SYNR-1365](https://sagebionetworks.jira.com/browse/SYNR-1365))
* The synapser vignette now has a link to the Manage Synapse Credentials vignette. ([SYNR-1382](https://sagebionetworks.jira.com/browse/SYNR-1382))
* The Manage Synapse Credentials vignette now has instructions on how to login using Synapse API key. ([SYNR-1383](https://sagebionetworks.jira.com/browse/SYNR-1383))
* Table vignettes has new examples using `synGetTableColumns`. ([SYNR-1384](https://sagebionetworks.jira.com/browse/SYNR-1384))
* `synBuild_table()` no longer shows up in the synapser package's namespace. ([SYNR-1387](https://sagebionetworks.jira.com/browse/SYNR-1387))
* synapser installation instructions now has a link to System Dependencies vignette. ([SYNR-1393](https://sagebionetworks.jira.com/browse/SYNR-1393))



## synapser 0.5
___

### New Features

* New parameter `includeEntityTypes` in `EntityViewSchema` allows configuring Synapse Views with all available Entity types. ([SYNR-1350](https://sagebionetworks.jira.com/browse/SYNR-1350))

### Bug Fixes

* In synapser 0.5, we locked down the version of the Python package `keyring.alt` to ensure stable installation in the Linux environment. ([SYNR-1375](https://sagebionetworks.jira.com/browse/SYNR-1375))
* `as.data.frame(synTableQuery(...))` now correctly returns R `data.frame` with column types matching the Table column types. ([SYNR-1275](https://sagebionetworks.jira.com/browse/SYNR-1275), [SYNR-1322](https://sagebionetworks.jira.com/browse/SYNR-1322), and [SYNR-1325](https://sagebionetworks.jira.com/browse/SYNR-1325))

### Improvements

* New [Troubleshooting](troubleshooting.html) vignette with more information about package installation on Windows with network drive configuration. ([SYNR-1248](https://sagebionetworks.jira.com/browse/SYNR-1248))
* New [File Upload](upload.html) vignette with more information about uploading a new version of a file. ([SYNR-1360](https://sagebionetworks.jira.com/browse/SYNR-1360))
* New [Manage Synapse Credentials](manageSynapseCredentials.html) vignette with more ways to login to Synapse. ([SYNR-1367](https://sagebionetworks.jira.com/browse/SYNR-1367))
* Improve `synGetChildren()` documentation. ([SYNR-1280](https://sagebionetworks.jira.com/browse/SYNR-1280), and [SYNR-1374](https://sagebionetworks.jira.com/browse/SYNR-1374))
* Improve `synSetAnnotations()` documentation. ([SYNR-1165](https://sagebionetworks.jira.com/browse/SYNR-1165))
* Simplify docs for deleting Table rows. ([SYNR-1340](https://sagebionetworks.jira.com/browse/SYNR-1340))
* Document accessing md5 with `synGet()`. ([SYNR-1359](https://sagebionetworks.jira.com/browse/SYNR-1359))
* Document `synSendMessage()` for one receipient. ([SYNR-1362](https://sagebionetworks.jira.com/browse/SYNR-1362))
* Improve `Table()` documentation. ([SYNR-1365](https://sagebionetworks.jira.com/browse/SYNR-1365))



## synapser 0.4
___

### Deprecation

* `synQuery()` and `synChunkedQuery()` are deprecated and removed. To query for entities filter by annotations, please use `EntityViewSchema` feature.
* `synUploadFileHandle()` and `synUploadSynapseManagedFileHandle()` are deprecated in synapser 0.4, and will be removed in synapser 0.5.

### Bug Fixes

* In synapser 0.4, we locked down the version of the Python package `keyring` to ensure stable installation on Linux environment. ([SYNR-1345](https://sagebionetworks.jira.com/browse/SYNR-1345))



## synapser 0.3
___

### New Features

* New convenience function `synBuildTable` creates a Table Schema based on the given data, and returns a Table object that can be stored in Synapse using `synStore`.
* New convenience function `synMove` allows users to move entities to a different parent.

### Minor Bug Fixes and Improvements

* `synStore` now uses a single thread to avoid the C stack limit error ([SYNR-1323](https://sagebionetworks.jira.com/browse/SYNR-1323)).
* Create 50 or more Links at a time ([SYNR-1276](https://sagebionetworks.jira.com/browse/SYNR-1276)).
* Python warning messages are no longer printed.
* `synapser` namespace no longer contains `PythonEmbedInR` and other R package functions ([SYNR-1274](https://sagebionetworks.jira.com/browse/SYNR-1274)).
* New NEWS.md provides the change log for each released version ([SYNR-1315](https://sagebionetworks.jira.com/browse/SYNR-1325)).
* New [System Dependencies vignette](./articles/systemDependencies.html) explains what dependencies are required and how to install them ([SYNR-1328](https://sagebionetworks.jira.com/browse/SYNR-1328)).
* New examples on [how to move a file](./articles/synapser.html#organizing-data-in-a-project) shows how `synMove` can be used ([SYNR-1296](https://sagebionetworks.jira.com/browse/SYNR-1296)).
* New [example R packages that depends on `synapser`](https://github.com/Sage-Bionetworks/synapser#usage) showcases two R packages developed by Sage Bionetworks' scientists ([SYNR-1317](https://sagebionetworks.jira.com/browse/SYNR-1317)).
* New section [Synapse Utilities](./articles/synapser.html#synapse-utilities) links to `synapserutils` package for high level utilities functions ([SYNR-1314](https://sagebionetworks.jira.com/browse/SYNR-1314)).
