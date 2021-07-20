FROM linuxserver/code-server:amd64-latest 

ARG R_VERSION=3.6.3

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
    libssl-dev \
    libcurl4-openssl-dev \
    cron \
    libhiredis-dev \
    unixodbc-dev \
    libxml2-dev \
    unixodbc \
    unixodbc-dev \
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
    libxml2-dev \
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
    libxml2-dev \
    libxslt-dev

# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py && rm get-pip.py

# Install R
RUN curl -O https://cdn.rstudio.com/r/ubuntu-1804/pkgs/r-${R_VERSION}_1_amd64.deb
RUN gdebi --non-interactive r-${R_VERSION}_1_amd64.deb

RUN ln -s /opt/R/${R_VERSION}/bin/R /usr/local/bin/R
RUN ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript

# Install R packages
COPY ./config/install_packages.R /tmp/install_packages.R
RUN Rscript /tmp/install_packages.R && rm /tmp/install_packages.R

# Install Radian console
RUN pip3 install -U radian

# setting up directories
#RUN chmod -R 777 /usr/local/lib/R
#RUN chmod -R 777 /config
#RUN mkdir -p /config/extensions

# install extensions
#RUN curl --retry 5 -JL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Ikuyadeu/vsextensions/r/0.6.1/vspackage | bsdtar -xvf - extension
#RUN mv extension /config/extensions/ikuyadeu.r-0.6.1

#RUN curl --retry 5 -JL  https://marketplace.visualstudio.com/_apis/public/gallery/publishers/REditorSupport/vsextensions/r-lsp/0.1.6/vspackage/ | bsdtar -xvf - extension
#RUN mv extension /config/extensions/r-lsp-0.1.6




