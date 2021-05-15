FROM php:7.4-fpm

LABEL maintainer="Adel ZEMZEMI <adelzemzemi@hotmail.com>"

# Copy composer.lock and composer.json
COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN set -xe; \
    apt-get update && apt-get install -y \
    build-essential \
    unzip \
    libfreetype6-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libzip-dev \
    libgeoip-dev \
    libxml2-dev \
    libxslt-dev \
    libtidy-dev \
    libssl-dev \
    zlib1g-dev \
    libpng-dev \
    libwebp-dev \
    libgmp-dev \
    libjpeg-dev \
    libaio1 \
    libldap2-dev \
    libonig-dev \
    apt-file \
    wget \
    vim \
    gnupg \
    gnupg2 \
    zip \
    git \
    gcc \
    g++ \
    autoconf \
    libc-dev \
    pkg-config \
    locales \
    default-mysql-client \
    redis-tools \
    redis-server \
    ssh \
    curl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd calendar gmp ldap sysvmsg pcntl iconv bcmath xml mbstring pdo tidy gettext intl pdo_mysql mysqli simplexml xml xsl xmlwriter zip opcache exif sockets

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install node and npm
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt install -y nodejs; \
    npm install -g npm

# Install and enable xDebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www:www .. /var/www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
