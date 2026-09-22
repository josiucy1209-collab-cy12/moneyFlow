FROM php:8.2-apache

# Install ekstensi PHP yang dibutuhkan CodeIgniter 4
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl pdo pdo_mysql mysqli gd zip

# Mengaktifkan mod_rewrite Apache
RUN a2enmod rewrite

# Mengarahkan dokumen utama Apache ke folder public
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/conf-available/*.conf

# Copy seluruh kode proyek
COPY . /var/www/html/

# Atur hak akses folder writable
RUN chown -R www-data:www-data /var/www/html/writable

EXPOSE 80
