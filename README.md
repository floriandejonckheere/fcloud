# Florian Cloud

This repository contains the infrastructure setup for Florian Cloud.

## Setup

### Terraform

See [Terraform](terraform).

### Docker Compose

Setup a remote Docker context:

```
docker context create cloud --docker host=ssh://cloud@web.cloud.dejonckhee.re
docker context use cloud
```

Deploy applications:

```
docker-compose up -d
```
