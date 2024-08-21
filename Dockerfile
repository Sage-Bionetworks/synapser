FROM rocker/r-base:4.2.2

RUN apt-get update && \
    apt-get -y install libpng-dev \
        python3 \
        python3-dev \
        python3-pip \
        python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages('synapser', repos=c('http://ran.synapse.org', 'https://cloud.r-project.org'))"
