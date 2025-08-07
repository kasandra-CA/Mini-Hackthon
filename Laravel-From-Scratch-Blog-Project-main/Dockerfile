# Usa una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias para Laravel
RUN apt-get update && apt-get install -y \
    libzip-dev unzip libpng-dev libonig-dev libxml2-dev zip curl \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql zip

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia el proyecto al contenedor
COPY . /var/www/html

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Da permisos correctos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Instala dependencias
RUN composer install --no-dev --optimize-autoloader

# Copia el .env.example como .env y genera clave
RUN cp .env.example .env \
    && php artisan key:generate \
    && php artisan migrate --force \
    && php artisan config:cache

# Expone el puerto por defecto de Apache
EXPOSE 80
