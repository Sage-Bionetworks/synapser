
<!-- README.md is generated from README.Rmd. Please modify README.Rmd and run `pkgdown::build_site()` to update README.md -->

# synapser

## Upcoming Changes to the R Client (synapser)

The next major release (version 3.0.0) will offer improved compatibility with newer versions of the reticulate and rjson package.

This release will also include non–backwards compatible changes. Please review the release notes carefully before upgrading, especially if you rely on specific behaviors or APIs from earlier versions.

## Important Note About the R Client

We maintain the R client to support our R user community, recognizing R as a foundational language in many data workflows. That said, the R client is built on top of the Synapse Python client via the reticulate package. This design allows us to solve complex engineering problems—such as multi-threaded uploads/downloads and file caching—at the Python layer and reuse those solutions in R.

While we aim to provide a reliable R experience, the dependency on Python introduces installation nuances, especially around environment management and package versions. If you encounter issues, we recommend using the Python client directly, which is actively developed and more broadly used.

We appreciate your patience and continued feedback as we work to improve the developer experience across both ecosystems.

The `synapser` package provides an interface to
[Synapse](http://www.synapse.org), a collaborative workspace for
reproducible data intensive research projects, providing support for:

* integrated presentation of data, code and text
* fine grained access control
* provenance tracking

The `synapser` package lets you communicate with the Synapse platform to
create collaborative data analysis projects and access data using the R
programming language. Other Synapse clients exist for
[Python](https://python-docs.synapse.org/build/html/index.html),
[Java](https://github.com/Sage-Bionetworks/Synapse-Repository-Services/tree/develop),
and [the web browser](https://www.synapse.org).

## Requirements

- R version 4.1.3 or higher (tested up to R 4.4.1)
- Python version 3.8 to 3.11 (Python 3.12+ not yet supported due to reticulate compatibility)
- [Synapse account](https://www.synapse.org/#!RegisterAccount:0)

**Note:** Since we're using reticulate 1.28 to interface with the Synapse Python Client **synapser is only compatible with Python versions earlier than 3.12**. Using Python 3.12 or later may result in errors. We have fully tested and recommend using Python 3.10 for optimal compatibility.

## Installation

`synapser` is available as a ready-built package for Microsoft Windows and Mac OSX. For Linux systems, it is available to install from source. Please also check out our [System Dependencies article](./articles/systemDependencies.html) for instructions on how to install system dependencies on Linux environments.

[**Check out the dedicated install guide for additional instructions**](./articles/installation.html)

In short you may install `synapser` via:

**For the latest version:**
```r
# Install remotes if not already installed
if (!require("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

# Install the latest version of synapser (handles compatible dependency versions automatically)
remotes::install_cran("synapser", repos = c("http://ran.synapse.org", "https://cloud.r-project.org"))
```



### Release Candidate Installation

If you have been asked to validate a release candidate, please use:

```r
remotes::install_cran("synapser", repos = c("http://staging-ran.synapse.org"))
```

### Troubleshooting Installation Issues

If you encounter dependency conflicts (particularly with rjson versions), please see our [Troubleshooting vignette](./articles/troubleshooting.html) for detailed resolution steps.

#### R Version Compatibility

**Important**: synapser versions 2.1.0+ require R versions 4.1.3 ≤ R < 4.5. If you are using R ≥ 4.5, the installation will fall back to synapser 2.0.0 instead of the latest version. To use the newest synapser features:

- **For R ≥ 4.5 users**: You must downgrade to R 4.4.x or earlier to install synapser 2.1.1+
- **Check your R version**: Run `R.version.string` in R to see your current version
- **Consequence of incompatible R version**: Installation will automatically select synapser 2.0.0 instead of the latest 2.1.1


Under the hood, `synapser` uses `reticulate` and the synapsePythonClient, which
is why you are required to have an installation of Python if you don't already.
See instructions below on installing/upgrading Python below.

## Usage

To get started, try logging into Synapse. If you don’t already have a
Synapse account, register [here](https://www.synapse.org/register):


```r
library(synapser)
synLogin()
```

Please visit the `synapser` [docs site](https://r-docs.synapse.org/) or view our vignettes for using the `synapser` package:


```r
browseVignettes(package = "synapser")
```

### Usage Examples

#### [knit2synapse](https://github.com/Sage-Bionetworks/knit2synapse)

Knit RMarkdown files to Synapse wikis

#### [syndccutils](https://github.com/Sage-Bionetworks/syndccutils)

Code for managing data coordinating operations (e.g., development of the CSBC/PS-ON Knowledge Portal and individual Center pages) for Sage-supported communities through Synapse.

## How to Upgrade Python

### On Windows

- Download the Python installer from the Official Website of Python
[here](https://www.python.org/downloads/windows/).
- Install the Downloaded Python Installer
- check Install Python and Check the “Add python.ext to PATH”, then click on the “Install Now” button.
- Verify the Update

  
  ```bash
  python --version
  ```

- `Note` If it still shows the old version, you may restart your system. Or uninstall the old version from the control panel.

### On macOS

- Both python 2x and 3x can stay installed in a MAC. Mac comes with python 2x version. To check the default python version in your MAC, open the terminal and type

  
  ```bash
  python --version
  python3 --version
  ```

- If you don't then go ahead and install it with the installer. Go the the python's official site
[here](https://www.python.org/downloads/mac-osx/).

- Now restart the terminal and check again with both commands python —version

  
  ```bash
  python3 --version
  ```

- `Or` use to `install last version`

  
  ```bash
  brew install python3 && cp /usr/local/bin/python3 /usr/local/bin/python
  ```

### On Linux

- Add the repository and update

  
  ```bash
  sudo add-apt-repository ppa:deadsnakes/ppa
  sudo apt-get update
  ```

- Update the package list

  
  ```bash
  apt-get update
  ```

- Verify the updated Python packages list

    
    ```bash
    apt list | grep python3.10
    ```

- Install the Python 3.10 package using apt-get

    
    ```bash
    sudo apt-get install python3.10
    ```

- Add Python 3.8 & Python 3.10 to update-alternatives

  
  ```bash
  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2
  ```

- Update Python 3 for point to Python 3.10

  
  ```bash
  sudo update-alternatives --config python3
  ```

## How to Upgrade R

- Verify R version
  - Open RStudio > At the top of the Console you will see session info > The first line tells you which version of R you are using.
  - `or` write in console >'R.version.string' to print out the R version.
  - go to Tools > Check for Package Updates. If there's an update available for tidyverse, install it.

### On Windows

- To update R on Windows, try using the package installer (only for Windows).
- Got to Tools (at the top) > Check for package updates. If tidyverse shows up on the list, select it, then click “Install Updates.”

### On Mac

- Go to
[here](https://cloud.r-project.org/bin/macosx/).
- Click the link you need to update R pkg
- When the file finishes downloading, double-click to install. You should be able to click “Next” to all dialogs to finish the installation.
- From within RStudio, go to Help > Check for Updates to install newer version of RStudio (if available, optional).
- To update packages, go to Tools > Check for Package Updates. If updates are available, select All (or just tidyverse), and click Install Updates.
