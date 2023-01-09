# LKT PHP 7.2 Apache

A pre-configured docker file, so you can have an apache php 7.2 server working in just five minutes.

## Included configuration:
- Apache2 mod_rewrite
- PDO, PDO MySQL, mysqli, mariadb-client
- LDAP2
- XDebug
- Zip
- Intl

## Installation
Simply clone this repo.

## Build lkt-php72-apache
Move to this directory and type in a terminal:

```shell
sudo docker build -t lkt-php72-apache:latest .
```

## Launch a container
```shell
sudo docker run -d -p 80:80 --name lkt-php72-apache lkt-php72-apache:latest
```

## Open container terminal
```shell
sudo docker exec -ti lkt-php72-apache bash
```

## Stop
```shell
sudo docker stop lkt-php72-apache
```

## Remove
```shell
sudo docker rm lkt-php72-apache
```