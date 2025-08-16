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
    # PDF generation (wkhtmltopdf) - install from external source
    xvfb \
    wget \
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
RUN docker-php-ext-install -j$(nproc) pdo_mysql mbstring exif pcntl bcmath gd zip gmp

# Install ImageMagick PHP extension
RUN pecl install imagick && docker-php-ext-enable imagick

# Install Redis PHP extension
RUN pecl install redis && docker-php-ext-enable redis

# Install wkhtmltopdf manually (not available in Debian Trixie repos)
RUN wget -q https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-3/wkhtmltox_0.12.6.1-3.bookworm_amd64.deb \
    && dpkg -i wkhtmltox_0.12.6.1-3.bookworm_amd64.deb || apt-get install -f -y \
    && rm wkhtmltox_0.12.6.1-3.bookworm_amd64.deb

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Allow composer to run as root in container
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install PHP dependencies first (before copying full app to avoid .env parsing)
COPY composer.json composer.lock* ./
# Important: disable scripts here because artisan is not present yet (belt-and-suspenders)
RUN COMPOSER_NO_SCRIPTS=1 composer install --no-dev --prefer-dist --no-interaction --no-scripts --optimize-autoloader

# Copy existing application directory contents
COPY . /var/www/

# Copy existing application directory permissions  
COPY --chown=www-data:www-data . /var/www/

# Remove any .env files that might cause parsing issues during build
RUN rm -f /var/www/.env /var/www/.env.local /var/www/.env.production || true

# Now that the full application (including artisan) is present, run composer scripts
RUN composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader

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