FROM linuxserver/code-server:amd64-latest 

ARG R_VERSION

RUN apt-get update && \
    apt-get -y install ca-certificates && \
    apt-get clean

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    apt-get update && \
# ==================================================================
# tools
# freetds: TDS for talking to MSSQL databases
# unixodbc: ODBC driver
# libssl-dev: OpenSSL
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
    build-essential \
    libssl-dev \
    libffi-dev \
    libxslt-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    cron \
    libhiredis-dev \
    unixodbc-dev \
    unixodbc \
    freetds-common \ 
    freetds-bin \
    freetds-dev \
    tdsodbc \
    libssh2-1-dev \
    vim \
    htop \
    tmux \
    whois \
    software-properties-common \
    gnupg2 \
    libsodium-dev \
    bsdtar \
    && \
# ==================================================================
# shiny
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    wget \
# ==================================================================
# Python
# ------------------------------------------------------------------
    python3-dev \
    python3-pip



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


# Install R packages
COPY ./env_config/install_packages.R /tmp/install_packages.R
RUN Rscript /tmp/install_packages.R && rm /tmp/install_packages.R

# Install Radian console
RUN pip3 install -U radian

# Add VS Code extensions
COPY ./env_config/extension_list /tmp/extension_list
COPY ./env_config/install_extensions.sh /config/custom-cont-init.d/install_extensions.sh
