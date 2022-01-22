# Florian Cloud

This repository contains the infrastructure setup for Florian Cloud.

## Setup

### Terraform

See [Terraform](terraform).

### Docker Compose

Setup a remote Docker context:

```
docker context create cloud --docker host=ssh://cloud@cloud.dejonckhee.re
docker context use cloud
```

Copy `.env.example` and fill in the environment variables:

```
cp .env.example .env
```

Deploy applications:

```
docker-compose up -d
```

Copy NGINX configuration to remote host:

```
docker-compose exec -T nginx tee /config/nginx/nginx.conf < nginx.conf
docker-compose exec nginx nginx -s reload
```
