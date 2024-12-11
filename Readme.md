# 🐳 Symfony Docker Stack
A complete stack for developing Symfony application.
* Multiple PHP versions
* Symfony CLI
* Supervisor to run async tasks
* MariaDB
* Node + NPM for building assets
* Composer v2
* [Maildev](https://maildev.github.io/maildev/)

## Installation
Edit the ```.env``` file

Build & run the stack :
```shell
$ docker-compose up -d
```
Connect to Shell inside webserver container :
```shell
$ docker exec -ti php-fpm /bin/bash
```
Install Symfony app :
```shell
$ symfony new ./ --webapp
```
Go to ```http://localhost:8080```
## Usage
Access to your app ```http://localhost:8080```

Access to Maildev ```http://localhost:8383```

## Configuration
You can configure PHP, Xdebug, Vhost and supervisor in ```/config```

To work with Maildev, you need to edit the Symfony ```.env``` :
```yaml
MAILER_DSN=smtp://mail:25
```

## Logs
You can check Caddy & Mysql logs in ```/logs```

Check container logs :
```shell
$ docker logs -f php-fpm
```

## Misc
### Supervisor
If you want to debug if supervisor handle some tasks, just type the following in the container shell to see the process logs :
```shell
$ supervisord
```
### Docker
Rebuild the stack :
```shell
$ docker-compose up --build -d
```
Stop the stack :
```shell
$ docker-compose down
```
List all containers :
```shell
$ docker ps
```