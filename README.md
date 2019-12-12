# Thalarion server config

This repository contains the server configuration files for Thalarion.

## Set up

**Download sources**

```bash
git clone git@github.com:floriandejonckheere/thalarion.git thalarion
cd thalarion
docker-compose up -d
```

**Configure TLS certificates**

Edit the `certbot/certbot.sh` file with the domains you wish to request Let's Encrypt certificates for.
Rebuild the image and execute the file in the container to issue the certificates.

```bash
docker-compose build certbot
docker-compose up -d certbot
docker-compose exec certbot sh -c /certbot.sh
```

The certbot container runs a cron job that will renew the certificates every night when necessary.

**Configure NGINX**

Enable domains by symlinking config files in `nginx/sites-enabled/*` to existing files in `nginx/sites-available`.

**Configure Nyctelios share**

```bash
cat fstab | sudo tee -a /etc/fstab
sudo mount /data
```
