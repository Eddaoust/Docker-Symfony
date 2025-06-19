# 🐳 Symfony Docker Stack
A complete stack for developing Symfony application.
* Multiple PHP versions
* Symfony CLI
* Supervisor to run async tasks
* MariaDB
* Node(18) + NPM(9) for building assets
* Composer v2
* [Maildev](https://maildev.github.io/maildev/)

## Installation
Edit the ```.env.docker``` file

Build & run the stack :
```shell
$ docker compose --env-file .env.docker up -d --build
```
> **Note:** The first time you run this command, the script will check if a Symfony application already exists. If not, it will automatically install a fresh one based on the env variables. This process can take a few minutes, so please be patient.
>

Connect to Shell inside webserver container :
```shell
$ docker exec -ti php /bin/bash
```
Stop the containers :
```shell
$ docker compose down --remove-orphans
```
Go to ```http://localhost:8080```
## Usage
Access to your app ```http://localhost:8080```

Access to Maildev ```http://localhost:8383```

## Configuration
You can configure PHP, Caddy, and supervisor in ```/config```

To work with Maildev, you need to edit the Symfony ```.env``` :
```yaml
MAILER_DSN=smtp://mail:25
```
