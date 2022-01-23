# fcloud

This repository contains the infrastructure setup for fcloud.

## Setup

### Terraform

Set up Terraform configuration:

```
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars

# Set backend config
cp backend.tfvars.example backend.tfvars
nano backend.tfvars
```

Initialize Terraform:

```
terraform init -backend-config=backend.tfvars
```

Synchronize infrastructure:

```
terraform apply
```

#### Minecraft

To set up the Minecraft server, run:

```
terraform apply -var minecraft=true -target=module.minecraft 
```

To tear down the Minecraft server, run:

```
terraform apply -var minecraft=false -target=module.minecraft
```


### Docker Compose

Setup a remote Docker context:

```
docker context create cloud --docker host=ssh://cloud@cloud.dejonckhee.re
docker context use cloud
```

Configure Docker Compose:

```
cp .env.example .env
nano .env
```

Configure applications:

```
for APP in bitwarden codered pydio trivial wireguard; do cp ${APP}.env.example ${APP}.env; nano ${APP}.env; done
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
