
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
[Java](https://github.com/Sage-Bionetworks/Synapse-Repository-Services/tree/develop),
and [the web browser](https://www.synapse.org).

## Quick Start

To get started, follow the instructions below. If you encounter a problem, the installation section below has more details.

### Requirements

- R version 4.1.3 or higher
- Python version 3.8 or higher
- [Synapse account](https://www.synapse.org/#!RegisterAccount:0)

### Build and Install

- Build package from R console:

  ``` r
  R CMD BUILD .
  ```

- Install package from R console:

  ``` r
  R CMD INSTALL synapser_1.0.0.tar.gz
  ```

## Installation

`synapser` is available as a ready-built package for Microsoft Windows
and Mac OSX. For Linux systems, it is available to install from source.
Please also check out our [System Dependencies
article](https://r-docs.synapse.org/articles/systemDependencies.html) for instructions on how to
install system dependencies on Linux environments.

## How to Upgrade Python on Windows

- Download the Python installer from the official Python website
[here](https://www.python.org/downloads/windows/).
- Run the Python Installer
- Check the boxes for Install Python and “Add python.ext to PATH”, then click on the “Install Now” button.
- Verify the Update

  ``` cmd
  python --version
  ```

- `Note` If it still shows the old version, you may need to restart your system. You may also need to uninstall the old version from the control panel.

## How to Upgrade Python on macOS

- Both python 2 and 3 will coexist on a Mac as some versions of Mac OS still ship with Python 2 that cannot be removed. To check the default python version in your Mac, run the following terminal command:

  ``` cmd
  python --version
  Python3 --version
  ```

- If you don't see at least Python 3.6, proceed to install it using the official installer from Python's official site
[here](https://www.python.org/downloads/mac-osx/).

- Now restart the terminal and check again with both commands-
python —version

  ``` cmd
  Python3 --version
  ```

- `Or` use to `install last version`

  ``` cmd
  brew install python3 && cp /usr/local/bin/python3 /usr/local/bin/python
  ```

## How to Upgrade Python on Linux

- Add the repository and update

  ``` cmd
  sudo add-apt-repository ppa:deadsnakes/ppa
  sudo apt-get update
  ```

- Update the package list

  ``` cmd
  $apt-get update
  ```

- Verify the updated Python packages list

  ``` cmd
  $apt list | grep python3.10
  ```

- Install the Python 3.10 package using apt-get

  ``` cmd
  $sudo apt-get install python3.10
  ```

- Add Python 3.8 & Python 3.10 to update-alternatives

  ``` cmd
  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2
  ```

- Configure Python 3 to point to Python 3.10

  ``` cmd
  sudo update-alternatives --config python3
  ```

## How to Upgrade R on Windows

- Verify R version
  - Run RStudio > At the top of the console you will see session info > The first line tells you which version of R you are using.
  - `or` write in console >'R.version.string' to print out the R version.
  - Go to Tools > Check for package updates. If there’s an update available for tidyverse, install it.

## for Windows

- To update R on Windows, try using the package installer (only for Windows).
- Go to Tools > Check for package updates. If there’s an update available for tidyverse, install it.

## for Mac

- Go
[here](https://cloud.r-project.org/bin/macosx/).
- Click the link you need to update R pkg
- When the file finishes downloading, double-click to install. You should be able to click “Next” to all dialogs to finish the installation.
- From within RStudio, go to Help > Check for Updates to install newer version of RStudio (if available, optional).
- To update packages, go to Tools > Check for Package Updates. If updates are available, select all (or just tidyverse), and click install updates.

## To build and install follow these steps

- Build package from R console:

  ``` r
  R CMD BUILD .
  ```

- Install package from R console:

  ``` r
  R CMD INSTALL synapser_1.0.0.tar.gz
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
