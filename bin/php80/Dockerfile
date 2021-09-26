FROM php:8.0.10-apache-buster

ARG DEBIAN_FRONTEND=noninteractive

# Update
RUN apt-get -y update --fix-missing && \
 apt-get upgrade -y && \
 apt-get --no-install-recommends install -y apt-utils

# Install tools & libs
RUN apt-get -y update && \
 apt-get -y --no-install-recommends install nano \
 wget \
 gnupg2 \
 lsb-release \
 apt-transport-https \
 software-properties-common \
 apt-utils \
 build-essential \
 git \
 curl \
 zip \
 unzip \
 ssl-cert \
 xz-utils \
 ca-certificates \
 supervisor \
 openssl \
 fonts-inconsolata \
 fontconfig \
 xfonts-100dpi \
 xfonts-75dpi \
 xfonts-base \
 fonts-roboto \
 libxrender1 \
 libfreetype6-dev \
 libjpeg62-turbo \
 libx11-6 \
 libxcb1 \
 libmagickwand-dev \
 libxext6 \
 libpng-dev

# Install NodeJS & NPM
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN npm install

# PHP Extensions
RUN docker-php-ext-install pdo_mysql opcache

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN pecl install imagick && \
 docker-php-ext-enable imagick

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg && \
 docker-php-ext-install gd

# Wkhtmltopdf
RUN curl -L https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb -o wkhtmltox_0.12.5-1.stretch_amd64.deb && \
 dpkg -i wkhtmltox_0.12.5-1.stretch_amd64.deb

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Symfony CLI
ARG SYMFONY_CLI_VERSION
RUN wget https://github.com/symfony/cli/releases/download/v$SYMFONY_CLI_VERSION/symfony_linux_amd64.gz \
 && gzip -d symfony_linux_amd64.gz \
 && mv symfony_linux_amd64 symfony \
 && chmod +x symfony \
 && mv symfony /usr/local/bin/

# Git config
ARG GIT_MAIL
ARG GIT_NAME
RUN git config --global user.email $GIT_MAIL
RUN git config --global user.name $GIT_NAME

# Enable apache modules
RUN a2enmod rewrite headers

# Cleanup
RUN rm -rf /usr/src/* && \
 rm -rf /var/lib/apt/lists/*