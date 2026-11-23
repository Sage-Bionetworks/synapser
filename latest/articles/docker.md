# Docker

## Docker

This guide shows how to build a Docker image with synapser 3.0.0
installed, starting from either the
[rocker/r-base](https://hub.docker.com/r/rocker/r-base) image or the
[rocker/rstudio](https://hub.docker.com/r/rocker/rstudio) image.

### What the image needs

R on Linux installs packages from source, so the image needs what is
listed under
[Linux](https://r-docs.synapse.org/latest/articles/installation.html#linux)
in the Installation vignette:

- **A C/C++ compiler.** Most of synapser’s dependencies (such as
  `reticulate`, `Rcpp`, and `rjson`) contain compiled code. The rocker
  images already include one.
- **The libpng development headers (`libpng-dev`).** The rocker images
  do not include them, and without them installing `png` fails with
  `png.h: No such file or directory`.

The image does **not** need Python. synapser 3.0.0 uses an environment
that reticulate manages: the first time
[`library(synapser)`](https://github.com/Sage-Bionetworks/synapser)
runs, reticulate uses [uv](https://docs.astral.sh/uv/) to download a
compatible Python and the Synapse Python client. Any Python you install
with `apt-get` is left unused. See [How synapser finds
Python](https://r-docs.synapse.org/latest/articles/installation.html#how-synapser-finds-python).

synapser 3.0.0 is installed from
[R-universe](https://sage-bionetworks.r-universe.dev). RAN
(`http://ran.synapse.org`) does not host synapser 3.0.0, so replace it
with R-universe in any existing Dockerfile.

### R image

    FROM rocker/r-base:4.6.1

    # R installs packages from source on Linux. rocker/r-base already has the
    # C/C++ compiler; the png dependency also needs the libpng headers.
    # Python is not installed here: synapser 3.0.0 uses reticulate's managed
    # environment, which downloads its own Python with uv.
    RUN apt-get update && \
        apt-get -y install --no-install-recommends libpng-dev && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

    RUN R -e "install.packages('synapser', repos = c('https://sage-bionetworks.r-universe.dev', 'https://cloud.r-project.org'))"

Build and run it:

``` bash
docker build -t synapser .
docker run -it --rm synapser R
```

### RStudio image

    # This builds the rstudio docker image
    FROM rocker/rstudio:4.6.1

    # The png dependency needs the libpng headers if it is built from source.
    # Python is not installed here: synapser 3.0.0 uses reticulate's managed
    # environment, which downloads its own Python with uv.
    RUN apt-get update && \
        apt-get -y install --no-install-recommends libpng-dev && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

    # Must install and load synapser as rstudio since we are relying on
    # the rstudio user to login.
    USER rstudio
    RUN R -e "install.packages('synapser', repos = c('https://sage-bionetworks.r-universe.dev', getOption('repos')))"
    # when starting the container, it must run as root
    USER root

reticulate caches the Python environment in the home directory of the
user who first loads synapser. Install and load synapser as the user who
will use it in the container (here `rstudio`), so that user reuses the
environment created during the build. Any other user downloads it again
on their first
[`library(synapser)`](https://github.com/Sage-Bionetworks/synapser).
Switch back to `root` at the end, because the rocker/rstudio image must
start as root.

Build and run it, then open <http://localhost:8787> and log in as
`rstudio` with the password you set:

``` bash
docker build -f Dockerfile.rstudio -t synapser-rstudio .
docker run --rm -p 8787:8787 -e PASSWORD=<choose a password> synapser-rstudio
```

### Logging in to Synapse from a container

Do not put your personal access token in the Dockerfile or the image.
Pass it when the container starts instead, either as the
`SYNAPSE_AUTH_TOKEN` environment variable:

``` bash
export SYNAPSE_AUTH_TOKEN="your_personal_access_token"
docker run -it --rm -e SYNAPSE_AUTH_TOKEN synapser R
```

`-e SYNAPSE_AUTH_TOKEN` with no value copies the variable from your
shell, so it must be set and exported there first. If it is not, Docker
passes nothing and does not warn you. You can check with
`echo $SYNAPSE_AUTH_TOKEN` before starting the container.

or by mounting your `~/.synapseConfig` file into the home directory of
the container’s user (`/root` for the R image):

``` bash
docker run -it --rm -v ~/.synapseConfig:/root/.synapseConfig:ro synapser R
```

Either way, you still log in inside R.
[`synLogin()`](https://r-docs.synapse.org/latest/reference/synLogin.md)
with no arguments finds the token in the environment variable or the
mounted config file:

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`synapser`](https://github.com/Sage-Bionetworks/synapser)`)`\
[`synLogin`](https://r-docs.synapse.org/latest/reference/synLogin.md)`(``)`

See the
[Authentication](https://r-docs.synapse.org/latest/articles/authentication.md)
vignette for other ways to log in.
