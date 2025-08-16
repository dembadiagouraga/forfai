FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    # Core system packages
    curl \
    git \
    unzip \
    zip \
    nginx \
    supervisor \
    # PHP extension dependencies
    libzip-dev \
    libgmp-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    # PDF generation (wkhtmltopdf)
    wkhtmltopdf \
    xvfb \
    # Image processing
    libmagickwand-dev \
    # Redis support
    redis-server \
    # Additional utilities
    ca-certificates \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*


# Install PHP extensions (parallel compilation for speed)
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) pdo_mysql mbstring exif pcntl bcmath gd zip gmp curl dom fileinfo json simplexml

# Install ImageMagick PHP extension
RUN pecl install imagick && docker-php-ext-enable imagick

# Install Redis PHP extension
RUN pecl install redis && docker-php-ext-enable redis

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy existing application directory contents
COPY . /var/www/

# Copy existing application directory permissions
COPY --chown=www-data:www-data . /var/www/

# Install Composer dependencies
RUN composer install --optimize-autoloader --no-dev

# Set permissions for Laravel
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Copy Nginx configuration
COPY docker/nginx.conf /etc/nginx/sites-available/default

# Create supervisord configuration
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port 80
EXPOSE 80

# Start supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]