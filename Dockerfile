# syntax=docker/dockerfile:1.7
# Stage 1 — vendor: composer dependencies only (cacheable)
FROM composer:2 AS vendor
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install \
        --no-dev \
        --no-interaction \
        --no-scripts \
        --no-autoloader \
        --prefer-dist \
        --ignore-platform-req=ext-pcntl

# Stage 2 — assets: Node + PHP
FROM node:22-alpine AS assets
RUN apk add --no-cache \
        php84 php84-cli php84-tokenizer php84-xml php84-mbstring \
        php84-fileinfo php84-exif php84-dom php84-session php84-ctype \
        php84-openssl php84-phar php84-pdo php84-pdo_sqlite php84-pdo_pgsql php84-pgsql \
    && ln -sf /usr/bin/php84 /usr/bin/php
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY --from=vendor /app/vendor ./vendor
COPY --from=vendor /usr/bin/composer /usr/bin/composer
COPY . .
RUN composer dump-autoload --optimize --no-dev --no-interaction
RUN cp .env.example .env \
 && php -r "echo 'APP_KEY=base64:'.base64_encode(random_bytes(32)).PHP_EOL;" >> .env
ARG VITE_APP_NAME
ARG VITE_REVERB_APP_KEY
ARG VITE_REVERB_HOST
ARG VITE_REVERB_PORT
ARG VITE_REVERB_SCHEME
RUN npm run build
RUN rm -f .env

# Stage 3 — runtime: PHP only, no Node. Runs as non-root.
FROM php:8.4-cli-alpine AS app
RUN apk add --no-cache --virtual .build-deps \
        postgresql-dev sqlite-dev icu-dev libzip-dev oniguruma-dev linux-headers \
 && apk add --no-cache \
        libpq sqlite-libs icu libzip oniguruma curl \
 && docker-php-ext-install -j$(nproc) \
        pdo_pgsql pgsql pdo_sqlite intl zip bcmath opcache pcntl exif \
 && apk del .build-deps \
 && addgroup -S www \
 && adduser -S -G www www

RUN { \
        echo "opcache.enable=1"; \
        echo "opcache.enable_cli=1"; \
        echo "opcache.memory_consumption=256"; \
        echo "opcache.interned_strings_buffer=16"; \
        echo "opcache.max_accelerated_files=20000"; \
        echo "opcache.validate_timestamps=0"; \
        echo "opcache.save_comments=1"; \
        echo "opcache.jit=1255"; \
        echo "opcache.jit_buffer_size=128M"; \
    } > /usr/local/etc/php/conf.d/opcache.ini \
 && { \
        echo "memory_limit=256M"; \
        echo "max_execution_time=60"; \
        echo "upload_max_filesize=64M"; \
        echo "post_max_size=64M"; \
        echo "expose_php=Off"; \
    } > /usr/local/etc/php/conf.d/production.ini

WORKDIR /var/www/html
COPY --chown=www:www --from=assets /app/vendor ./vendor
COPY --chown=www:www . .
COPY --chown=www:www --from=assets /app/public/build ./public/build
COPY --chown=www:www --from=assets /app/resources/js/actions ./resources/js/actions
COPY --chown=www:www --from=assets /app/resources/js/routes ./resources/js/routes
COPY --chown=www:www --from=assets /app/resources/js/wayfinder ./resources/js/wayfinder
RUN chmod +x start.sh

RUN cp .env.example .env \
 && php -r "echo 'APP_KEY=base64:'.base64_encode(random_bytes(32)).PHP_EOL;" >> .env \
 && php artisan package:discover --ansi \
 && php artisan route:cache \
 && php artisan view:cache \
 && rm .env \
 && chown -R www:www bootstrap/cache database storage

USER www
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -fsS http://localhost:8000/up || exit 1
CMD ["./start.sh"]
