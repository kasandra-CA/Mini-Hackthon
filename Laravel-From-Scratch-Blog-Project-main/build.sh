#!/usr/bin/env bash
set -o errexit

# Instala dependencias de Laravel
composer install --no-dev --optimize-autoloader

# Mueve el .env.example a .env si no existe
cp .env.example .env

# Genera clave de aplicación
php artisan key:generate

# Crea las tablas y datos de ejemplo
php artisan migrate --force --seed

# Da permisos (opcional si da error de logs o cache)
chmod -R 775 storage bootstrap/cache
