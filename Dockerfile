FROM linuxserver/code-server:amd64-latest 

ARG R_VERSION

LABEL author="Carson Sprock <csprock@gmail.com>"
LABEL source="https://github.com/csprock/code_server"
LABEL description="Extends linuxserver/code-server image with R and rocker/tidyverse packages"
LABEL rversion=${R_VERSION}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	bash-completion \
	ca-certificates \
	ed \
	file \ 
	fonts-texgyre \
	g++ \
	gfortran \
	gsfonts \
	less \
	libblas-dev \
	libbz2-1.0 \
	libcairo2-dev \
	libcurl4 \
	libfreetype6-dev \
	libfribidi-dev \
	libgit2-dev \
	libharfbuzz-dev \
#	libicu63 \
	libjpeg-dev \
#	libjpeg62-dev \
	liblzma5 \
	libmariadbclient-dev \
	libmariadbd-dev \
	libopenblas-dev \
	libpangocairo-1.0-0 \
	libpcre3 \
	libpng-dev \
	libpng16-16 \
	libpq-dev \
	libreadline7 \
	libsasl2-dev \
	libsqlite-dev \
	libssh2-1-dev \
        libssl-dev \
	libtiff5 \
	libtiff5-dev \
	libxml2-dev \
	make \
        software-properties-common \
	unixodbc-dev \
	unzip \
	vim-tiny \
	wget \
        whois \
	zip \
	zlib1g \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*


### Install R ### 

# source: https://cran.r-project.org/bin/linux/ubuntu/fullREADME.html
RUN echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/" > /etc/apt/sources.list.d/r.list
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc


# source: https://github.com/rocker-org/rocker/blob/master/r-base/4.1.2/Dockerfile#L49
RUN apt-get update \
        && apt-get install -y --no-install-recommends \
                libopenblas-dev \
		littler \
                r-cran-littler \
		r-base=${R_VERSION}-* \
		r-base-dev=${R_VERSION}-* \
                r-base-core=${R_VERSION}-* \
		r-recommended=${R_VERSION}-* \
	&& ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
	&& ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
	&& ln -s /usr/lib/R/site-library/littler/examples/installBioc.r /usr/local/bin/installBioc.r \
	&& ln -s /usr/lib/R/site-library/littler/examples/installDeps.r /usr/local/bin/installDeps.r \
	&& ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
	&& ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
	&& install.r docopt \
	&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
	&& rm -rf /var/lib/apt/lists/*


# Install Tidyverse 
RUN install2.r --error \
    --deps TRUE \
    tidyverse \
    dplyr \
    devtools \
    formatR \
    remotes \
    selectr \
    caTools \ 
#    BiocManager \
    languageserver \
    httpgd


### Install Pip3 ###
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-dev \
    python3-pip \
    && python3 -m pip install --upgrade pip \
    && pip3 install --upgrade setuptools
    
# Install Radian console
RUN pip3 install -U radian
