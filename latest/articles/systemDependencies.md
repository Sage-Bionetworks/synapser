# System Dependencies

## System Dependencies

A dependency is a broad software engineering term used to refer when
software relies on other software in order to be functional. For R
package dependencies, the installation of the `synapser` package will
take care of installing other R packages that `synapser` depends on,
using dependencies specified in the
[DESCRIPTION](https://r-docs.synapse.org/latest/DESCRIPTION) file.
However, lower level system dependencies are not automatically
installed.

Most Windows and Mac machines have the required system dependencies.
Linux machines, including most Amazon Web Services EC2 machines, will
need to be configured before installing `synapser`.

### Required System Dependencies

- libssl-dev
- libcurl-dev
- libffi-dev
- zlib-dev

### Python Version Requirements

**Important:** In addition to system dependencies, synapser requires
specific Python version compatibility:

- **Supported Python versions:** 3.11 to 3.15, the range supported by
  synapseclient 4.15

You do not need to install Python yourself: when synapser is loaded,
reticulate (1.44.0 or later) downloads a compatible Python into a
managed environment. These limits only matter if you point synapser at a
Python you manage yourself. See the [Installation
vignette](https://r-docs.synapse.org/latest/articles/installation.md)
for details.

### Ubuntu Installation

To install these system dependencies on Ubuntu machines:

    apt-get update -y
    apt-get install -y dpkg-dev zlib1g-dev libssl-dev libffi-dev
    apt-get install -y curl libcurl4-openssl-dev

### Redhat Installation

To install these system dependencies on Redhat machines:

    yum update -y
    yum install -y openssl-devel curl-devel libffi-devel zlib-devel
    yum install -y R
