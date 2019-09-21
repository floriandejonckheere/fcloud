# Thalarion server config

This repository contains the server configuration files for Thalarion.

## Issue certificate

```sh
$ docker-compose up -d
$ docker exec acme.sh --issue -d florian.dejonckhee.re -d dejonckhee.re -w /letsencrypt
```