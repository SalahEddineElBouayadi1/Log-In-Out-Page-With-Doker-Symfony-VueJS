FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    libicu-dev \
    libpq-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl pdo pdo_mysql pdo_pgsql zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN chown -R www-data:www-data /var/www/html/var /var/www/html/vendor

EXPOSE 9000

CMD ["php-fpm"]
