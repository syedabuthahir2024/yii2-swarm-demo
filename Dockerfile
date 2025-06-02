# Use official PHP 8.2 image with Apache server
FROM php:8.2-apache

# Install required system packages and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer globally by copying from the official Composer image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory inside the container
WORKDIR /var/www/html

# Copy composer.json and composer.lock first for better caching
COPY composer.json composer.lock ./

# Install PHP dependencies without dev packages and optimize autoloader
RUN composer install --no-dev --optimize-autoloader

# Copy application source code to container
COPY . .

# Set Apache DocumentRoot to Yii2 "web" directory
ENV APACHE_DOCUMENT_ROOT=/var/www/html/web

# Update Apache configuration to use the new DocumentRoot
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Suppress Apache ServerName warning
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Enable Apache mod_rewrite for Yii2 URL management
RUN a2enmod rewrite

# Fix permissions for Yii2 runtime and assets directories
RUN mkdir -p /var/www/html/runtime /var/www/html/web/assets \
    && chown -R www-data:www-data /var/www/html/runtime /var/www/html/web/assets \
    && chmod -R 775 /var/www/html/runtime /var/www/html/web/assets

# Set environment variable to production mode for Yii2
ENV YII_ENV=prod

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Apache in the foreground (default command)
CMD ["apache2-foreground"]
