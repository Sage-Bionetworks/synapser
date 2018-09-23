FROM r-base
RUN rm /etc/apt/apt.conf.d/default
RUN apt-get update -y
RUN apt-get install -y dpkg-dev zlib1g-dev libssl-dev libffi-dev
RUN apt-get install -y curl libcurl4 libcurl4-openssl-dev
RUN R -e "install.packages('synapser', repos=c('https://sage-bionetworks.github.io/ran', 'http://cran.fhcrc.org'))"
