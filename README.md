# Docker - Laravel

Simplified Docker environment for local development Laravel Project (Linux, NGINX, MySQL, PHP, Xdebug, Adminer, Redis, MailHog) with PHP-CS (PHP Coding Standards) and PHPStan (PHP Static Analysis Tool).

## Ports

Ports used in the project:
| Software | Port |
|-------------- | -------------- |
| **nginx** | 8080 |
| **adminer** | 8081 |
| **mysql** | 3306 |
| **php** | 9000 |
| **xdebug** | 9001 |
| **redis** | 6379 |
| **mailhog** | 8025 |

## Use

To get started, make sure you have [Docker installed](https://docs.docker.com/) on your system and [Docker Compose](https://docs.docker.com/compose/install/), and then clone this repository.

1. Clone this project:

   ```sh
   git clone https://github.com/zemzemi/laravel-app.git
   ```

2. Inside the folder `laravel-app` and Generate your own `.env` to docker compose with the next command:

   ```sh
   make dotenv
   ```

3. Build the project whit the next commands:

   ```sh
   make docker-dev-install
   ```

---

## Special Cases

Get a bash shell in the container:

```sh
make docker-shell
```

To Down and remove the volumes we use the next command:

```sh
make docker-clean
```

Install dependencies:

```sh
make install-dependencies
```

Run compiler (Webpack.mix.js) or Show the view compiler in node:

```sh
make dev
```

Run all migrations
```sh
make docker-load-data
```

Run all tests

```sh
make docker-load-data
```

Run php-cs - PHP Coding Standards

```sh
make phpcs
```

Run PHPStan - PHP Static Analysis Tool

```sh
make stan
```

---

## ❤️ Support The Development

Do you like this project? Support it by donating
- [Buy me a coffee](https://www.buymeacoffee.com/AdelZEMZEMI)
