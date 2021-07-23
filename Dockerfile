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

# Add VS Code extensions
COPY ./config/extension_list /tmp/extension_list
COPY ./config/install_extensions.sh /config/custom-cont-init.d/install_extensions