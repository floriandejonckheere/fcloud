# Docker Swarm

## Setup

```
# Create Docker context
docker context create cloud --docker host=ssh://cloud@web.cloud.dejonckhee.re

# Set up context
docker context use cloud
```

## Deploy

### Web

```
# Deploy reverse proxy
docker stack deploy --compose-file traefik/docker-compose.yml traefik
```

### Minecraft

```
# Deploy minecraft
docker stack deploy --compose-file minecraft/docker-compose.yml minecraft

# RCON console
ssh cloud@minecraft.cloud.dejonckhee.re 
docker exec -ti $(docker ps -q) rcon-cli

# Stop minecraft
docker stack rm minecraft
```
