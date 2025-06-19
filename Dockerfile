ARG PHP_VERSION
FROM composer:2.8 AS composer
FROM php:$PHP_VERSION-fpm-bookworm AS base

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
    zip \
    unzip \
    libzip-dev \
    libicu-dev \
    supervisor \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libwebp-dev \
    libmagickwand-dev

# Install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Symfony CLI
ARG SYMFONY_CLI_VERSION
RUN wget https://github.com/symfony-cli/symfony-cli/releases/download/v$SYMFONY_CLI_VERSION/symfony-cli_linux_amd64.tar.gz \
 && tar -xvzf symfony-cli_linux_amd64.tar.gz \
 && chmod +x symfony \
 && mv symfony /usr/local/bin/

# Copy custom entrypoint script into the image
COPY --link --chmod=755 /docker/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
# Set it as the container entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["php-fpm"]

# PHP Extensions
RUN docker-php-ext-install pdo_mysql opcache zip intl

# Install and enable imagick
# imagick is not yet supported by PHP8.3+ (https://serverpilot.io/docs/how-to-install-the-php-imagemagick-extension/)
RUN pecl install imagick-beta \
 && docker-php-ext-enable imagick

# Install GD
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
 && docker-php-ext-install gd

# Cleanup
RUN rm -rf /usr/src/* \
 && rm -rf /var/lib/apt/lists/*
