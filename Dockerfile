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
