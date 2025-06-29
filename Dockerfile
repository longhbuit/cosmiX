# Dockerfile - PHP + Apache + CodeIgniter 4
FROM php:8.2-apache

# Cài extension cần thiết
RUN apt-get update && apt-get install -y libicu-dev \
    && docker-php-ext-install intl pdo pdo_mysql mysqli

# Bật mod_rewrite cho Apache
RUN a2enmod rewrite

# Cài đặt pnpm và build Next.js
RUN apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm
# Copy code vào container
COPY ./api /var/www/html
COPY ./web /web
RUN cd /web && rm -rf node_modules && \
    rm -rf out && \
    rm -rf .next && \
    rm -rf .nuxt && \
    rm -rf dist
RUN cd /web && pnpm install && pnpm build && \
    ls -lah out && \
    mkdir -p /var/www/html/public && cp -r out/* /var/www/html/public/
# Set quyền cho Apache
RUN chown -R www-data:www-data /var/www/html

# Chỉnh thư mục gốc cho Apache thành /public
WORKDIR /var/www/html
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf