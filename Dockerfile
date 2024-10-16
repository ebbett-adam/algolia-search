# Use the official PHP image with Apache
FROM php:8.2-apache

# Install required tools and PHP extensions
RUN apt-get update && \
    apt-get install -y git unzip zip libzip-dev nano && \
    docker-php-ext-install pdo pdo_mysql zip

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory inside the container
WORKDIR /var/www/html

# Copy project files to the container
COPY . /var/www/html

# Install Composer dependencies
RUN composer install

# Start Apache in the foreground
CMD ["apache2-foreground"]