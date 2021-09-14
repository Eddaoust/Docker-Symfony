# Symfony Docker Stack
A complete stack for developing Symfony application.
* Multiple PHP versions
* Symfony CLI
* Supervisor to run async tasks
* Wkhtmltopdf for generating PDF files
* MySQL + PhpMyadmin
* Node + NPM for building assets
* Composer
* [Maildev](https://maildev.github.io/maildev/)

## Installation
Edit the ```.env``` file

Build & run the stack :
```shell
$ docker-compose up -d
```
Connect to Shell inside webserver container :
```shell
$ docker exec -ti eddaoust-php /bin/bash
```
Install Symfony app :
```shell
$ symfony new ./ --full
```
Go to ```http://localhost:8080```
## Usage
Access to your app ```http://localhost:8080```

Access to PHPMyAdmin ```http://localhost:8282```

Access to Maildev ```http://localhost:8383```

## Configuration
You can configure PHP, Xdebug, Vhost and supervisor in ```/config```

To work with Maildev, you need to edit the Symfony ```.env``` :
```yaml
MAILER_DSN=smtp://mail:25
```

## Logs
You can check Apache & Mysql logs in ```/logs```

Check container logs :
```shell
$ docker logs -f eddaoust-php
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
### Apache
Check server status :
```shell
$ /etc/init.d/apache2 status
```
Restart server :
```shell
$ /etc/init.d/apache2 restart
```