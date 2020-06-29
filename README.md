
<!-- README.md is generated from README.Rmd. Please modify README.Rmd and run `pkgdown::build_site()` to update README.md -->

# synapser

The `synapser` package provides an interface to
[Synapse](http://www.synapse.org), a collaborative workspace for
reproducible data intensive research projects, providing support for:

  - integrated presentation of data, code and text
  - fine grained access control
  - provenance tracking

The `synapser` package lets you communicate with the Synapse platform to
create collaborative data analysis projects and access data using the R
programming language. Other Synapse clients exist for
[Python](http://docs.synapse.org/python),
[Java](https://github.com/Sage-Bionetworks/Synapse-Repository-Services/tree/develop/client/synapseJavaClient%3E),
and [the web browser](https://www.synapse.org).

## Installation

`synapser` is available as a ready-built package for Microsoft Windows
and Mac OSX. For Linux systems, it is available to install from source.
Please also check out our [System Dependencies
article](https://r-docs.synapse.org/articles/systemDependencies.html) for instructions on how to
install system dependencies on Linux environments.

`synapser` can be installed or upgraded using the standard
`install.packages()` command, adding the [Sage Bionetworks R Archive
Network (RAN)](http://ran.synapse.org) to the repository list,
e.g.:

``` r
install.packages("synapser", repos=c("http://ran.synapse.org", "http://cran.fhcrc.org"))
```

Alternatively, edit your `~/.Rprofile` and configure your default
repositories:

``` r
options(repos=c("http://ran.synapse.org", "http://cran.fhcrc.org"))
```

after which you may run `install.packages` without specifying the
repositories:

``` r
install.packages("synapser")
```

If you have been asked to validate a release candidate, please use:

``` r
install.packages("synapser", repos=c("http://staging-ran.synapse.org", "http://cran.fhcrc.org"))
```

### Note for Windows and Mac users

If you are running on Windows or Mac OSX **and** compiled R from source rather than installing it from a pre-built installer, by default R will attempt to install packages by compiling them from source as well rather than using the available ready-built packages. The toolchain necessary to build synapser includes some dependencies that may not be available even on a system that successfully compiled R and installation may fail as a result. In such an environment you can force R to use the available ready-built packages by explicitly specifying the `type` argument of `install.packages`, e.g.:

On Mac

```
install.packages("synapser", repos=c("http://ran.synapse.org", "http://cran.fhcrc.org"), type="mac.binary")
```

On Windows:

```
install.packages("synapser", repos=c("http://ran.synapse.org", "http://cran.fhcrc.org"), type="win.binary")
```

## Usage

To get started, try logging into Synapse. If you don’t already have a
Synapse account, register [here](https://www.synapse.org/register):

``` r
library(synapser)
synLogin()
```

Please visit the `synapser` [docs
site](http://sage-bionetworks.github.io/synapser/articles/synapser.html)
or view our vignettes for using the `synapser` package:

``` r
browseVignettes(package="synapser")
```

### Usage Examples:

#### [knit2synapse](https://github.com/Sage-Bionetworks/knit2synapse)

Knit RMarkdown files to Synapse wikis

#### [syndccutils](https://github.com/Sage-Bionetworks/syndccutils)

Code for managing data coordinating operations (e.g., development of the
CSBC/PS-ON Knowledge Portal and individual Center pages) for
Sage-supported communities through Synapse.
