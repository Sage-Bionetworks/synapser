# synapser 0.3

## New features

* Added the convenience function `synBuildTable` that creates a Table Schema based on the given data, and returns a Table object that can be stored in Synapse using `synStore`.

## Minor bug fixes and improvements

* Fixed C-stack error in `synStore`
* Fixed problems with creating 50+ Links at a time
* Cleaned up warnings from Python
* Cleaned up `synapser` namespace
* Added NEWS.md
* Added [System Dependencies vignette](./articles/systemDependencies.html)
* Added examples on [how to move a file](./articles/synapser.html#organizing-data-in-a-project)
* Added [examples R packages that depends on `synapser`](https://github.com/Sage-Bionetworks/synapser#usage)
* Linked to `synapserutils` package for [Synapse Utilities](./articles/synapser.html#synapse-utilities)

