# synapser 0.4

## Deprecation

* `synQuery()` and `synChunkedQuery()` are deprecated and removed. To query for entities filter by annotations, please use `EntityViewSchema` feature.
* `synUploadFileHandle()` and `synUploadSynapseManagedFileHandle()` are deprecated in synapser 0.4, and will be removed in synapser 0.5.

## Bug Fixes

* In synapser 0.4, we lock down the version of the Python package `keyring` to ensure stable installation on Linux environment. ([SYNR-1345](https://sagebionetworks.jira.com/browse/SYNR-1345))


# synapser 0.3

## New Features

* New convenience function `synBuildTable` creates a Table Schema based on the given data, and returns a Table object that can be stored in Synapse using `synStore`.
* New convenience function `synMove` allows users to move entities to a different parent.

## Minor Bug Fixes and Improvements

* `synStore` now uses a single thread to avoid the C stack limit error ([SYNR-1323](https://sagebionetworks.jira.com/browse/SYNR-1323)).
* Create 50 or more Links at a time ([SYNR-1276](https://sagebionetworks.jira.com/browse/SYNR-1276)).
* Python warning messages are no longer printed.
* `synapser` namespace no longer contains `PythonEmbedInR` and other R package functions ([SYNR-1274](https://sagebionetworks.jira.com/browse/SYNR-1274)).
* New NEWS.md provides the change log for each released version ([SYNR-1315](https://sagebionetworks.jira.com/browse/SYNR-1325)).
* New [System Dependencies vignette](./articles/systemDependencies.html) explains what dependencies are required and how to install them ([SYNR-1328](https://sagebionetworks.jira.com/browse/SYNR-1328)).
* New examples on [how to move a file](./articles/synapser.html#organizing-data-in-a-project) shows how `synMove` can be used ([SYNR-1296](https://sagebionetworks.jira.com/browse/SYNR-1296)).
* New [example R packages that depends on `synapser`](https://github.com/Sage-Bionetworks/synapser#usage) showcases two R packages developed by Sage Bionetworks' scientists ([SYNR-1317](https://sagebionetworks.jira.com/browse/SYNR-1317)).
* New section [Synapse Utilities](./articles/synapser.html#synapse-utilities) links to `synapserutils` package for high level utilities functions ([SYNR-1314](https://sagebionetworks.jira.com/browse/SYNR-1314)).
