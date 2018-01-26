
<!-- README.md is generated from README.Rmd. Please modify README.Rmd and run `pkgdown::build_site()` to update README.md -->
synapser
========

The `synapser` package provides an interface to [Synapse](http://www.synapse.org), a collaborative workspace for reproducible data intensive research projects, providing support for:

-   integrated presentation of data, code and text
-   fine grained access control
-   provenance tracking

The `synapser` package lets you communicate with the Synapse platform to create collaborative data analysis projects and access data using the R programming language. Other Synapse clients exist for [Python](http://docs.synapse.org/python), [Java](https://github.com/Sage-Bionetworks/Synapse-Repository-Services/tree/develop/client/synapseJavaClient%3E), and [the web browser](https://www.synapse.org).

Installation
------------

`synapser` is available as a ready-built package for Microsoft Windows and Mac OSX. For Linux systems, it is available to install from source. It can be installed or upgraded using the standard `install.packages()` command, adding the [Sage Bionetworks R Archive Network (RAN)](https://sage-bionetworks.github.io/ran) to the repository list, e.g.:

``` r
install.packages("synapser", repos=c("https://sage-bionetworks.github.io/ran", "http://cran.fhcrc.org"))
```

Alternatively, edit your `~/.Rprofile` and configure your default repositories:

``` r
options(repos=c("https://sage-bionetworks.github.io/ran", "http://cran.fhcrc.org"))
```

after which you may run `install.packages` without specifying the repositories:

``` r
install.packages("synapser")
```

If you have been asked to validate a release candidate, please replace the URL <https://sage-bionetworks.github.io/ran> with <https://sage-bionetworks.github.io/staging-ran>, that is:

``` r
install.packages("synapser", repos=c("https://sage-bionetworks.github.io/staging-ran", "http://cran.fhcrc.org"))
```

Usage
-----

To get started, try logging into Synapse. If you don't already have a Synapse account, register [here](https://www.synapse.org/register):

``` r
library(synapser)
synLogin()
```

Please visit the `synapser` [docs site](http://sage-bionetworks.github.io/synapser/articles/synapser.html) or view our vignettes for using the `synapser` package:

``` r
browseVignettes(package="synapser")
```
