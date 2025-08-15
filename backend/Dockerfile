# PHP 8.2 with FPM (FastCGI Process Manager)
FROM php:8.2-fpm

# System Dependencies (Nginx, Git, etc.)
RUN apt-get update && apt-get install -y \
    nginx \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    supervisor

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy Nginx config
COPY ./docker/nginx.conf /etc/nginx/sites-available/default

# Copy application files
COPY . /var/www

# Install dependencies
RUN composer install --optimize-autoloader --no-dev

# Set permissions
RUN chown -R www-data:www-data /var/www/storage
RUN chmod -R 775 /var/www/storage

# Copy supervisor config
COPY ./docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port 80 for Nginx
EXPOSE 80

# Start services using supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
