PLATFORM_OS = $(shell uname)
UID = $(shell id -u)

install-dependencies:
	# Installation des dépendances PHP
	docker-compose exec app composer install
	docker-compose exec app npm install --no-save

dotenv:
	@[ ! -f .env ] && cp .env.dist .env || true

#-------------------------------------------------------------
# docker environment dev
#-------------------------------------------------------------

docker-build:
	docker-compose build --pull --build-arg PLATFORM_OS=$(PLATFORM_OS) --build-arg UID=$(UID)

docker-dev-install: dotenv docker-build
	docker-compose up -d
	make install-dependencies
	make docker-load-data

docker-clean:
	docker-compose down -v

docker-shell:
	docker-compose exec app bash

docker-restart:
	docker-compose stop
	docker-compose up -d
	make docker-dev-xdebug-enable

docker-reload:
	docker-compose up -d

docker-load-data:
	docker-compose exec app php artisan migrate

docker-reload-data:
	docker-compose exec app php artisan migrate:fresh
	docker-compose exec app php artisan db:seed

xdebug-enable:
	docker-php-ext-enable xdebug
	kill -USR2 1

xdebug-disable:
	sed -i '/zend_extension/d' $(PHP_INI_DIR)/conf.d/docker-php-ext-xdebug.ini
	kill -USR2 1

docker-dev-xdebug-enable:
	docker-compose exec -T -u 0 app make xdebug-enable

docker-dev-xdebug-disable:
	docker-compose exec -T -u 0 app make xdebug-disable

docker-clean-cache:
	docker-compose exec app php artisan view:clear
	docker-compose exec app php artisan route:clear
	docker-compose exec app php artisan config:clear

#-------------------------------------------------------------
# docker npm
#-------------------------------------------------------------

watch:
	docker-compose exec app npm run watch

dev:
	docker-compose exec app npm run dev

prod:
	docker-compose exec app npm run prod

#-------------------------------------------------------------
# docker tests dev
#-------------------------------------------------------------

test:
	docker-compose exec app php artisan test --testdox

phpcs:
	docker-compose exec app ./vendor/bin/phpcs

stan:
	docker-compose exec app ./vendor/bin/phpstan analyse --memory-limit=2G

