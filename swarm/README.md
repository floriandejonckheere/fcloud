# Docker Swarm

## Setup

```
# Create Docker context
docker context create cloud --docker host=ssh://cloud@web.cloud.dejonckhee.re

# Set up context
docker context use cloud
```

## Deploy

```
# Deploy reverse proxy
docker stack deploy --compose-file traefik/docker-compose.yml traefik
```
