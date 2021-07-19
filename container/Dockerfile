FROM php:7.4-fpm
LABEL maintainer="jslmorrison@gmail.com"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    libicu-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libpq-dev \
    libsodium-dev \
    libxml2-dev \
    libxslt-dev \
    unzip \
    zip \
    zlib1g-dev \
    --no-install-recommends \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-install -j$(nproc) \
    gd \
    intl \
    pdo_mysql \
    xsl

COPY --from=docker.io/library/composer:latest /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html/app
