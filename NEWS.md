# synapser 0.3

## New features

* New convenience function `synBuildTable` creates a Table Schema based on the given data, and returns a Table object that can be stored in Synapse using `synStore`.
* New convenienve function `synMove` allows users to move entities to a different parent.

## Minor bug fixes and improvements

* `synStore` now uses single threaded to avoid the C-stack limit error (SYNR-1323).
* Creating Links now works for creating 50+ Links at a time (SYNR-1276).
* Warnings from Python is no longer shown.
* `synapser` namespace is no longer contains `PythonEmbedInR` and other R packages functions (SYNR-1274).
* New NEWS.md provides the change log for each released version (SYNR-1315).
* New [System Dependencies vignette](./articles/systemDependencies.html) explains what dependencies are required and how to installed them (SYNR-1328).
* New examples on [how to move a file](./articles/synapser.html#organizing-data-in-a-project) shows how `synMove` can be used (SYNR-1296).
* New [examples R packages that depends on `synapser`](https://github.com/Sage-Bionetworks/synapser#usage) showcases two R packages developed by Sage Bionetworks' scientists (SYNR-1317).
* New section [Synapse Utilities](./articles/synapser.html#synapse-utilities) links to `synapserutils` package for high level utilities functions (SYNR-1314).

