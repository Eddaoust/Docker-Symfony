FROM composer:2.6.2 as composer
FROM php:8.3-rc-fpm AS base

ARG DEBIAN_FRONTEND=noninteractive

# Update
RUN apt-get -y update --fix-missing \
 && apt-get upgrade -y \
 && apt-get --no-install-recommends install -y apt-utils

# Install tools & libs
RUN apt-get -y update \
 && apt-get -y --no-install-recommends install zip \
    ca-certificates \
    curl \
    nodejs \
    npm \
    gnupg \
    wget \
    libzip-dev \
    libicu-dev \
    supervisor \
    git

# Install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# PHP Extensions
RUN docker-php-ext-install pdo_mysql opcache zip intl

# Symfony CLI
ARG SYMFONY_CLI_VERSION
RUN wget https://github.com/symfony-cli/symfony-cli/releases/download/v$SYMFONY_CLI_VERSION/symfony-cli_linux_amd64.tar.gz \
 && tar -xvzf symfony-cli_linux_amd64.tar.gz \
 && chmod +x symfony \
 && mv symfony /usr/local/bin/

# Cleanup
RUN rm -rf /usr/src/* \
 && rm -rf /var/lib/apt/lists/*