# Docker Swarm

## Setup

```
# Create Docker context
docker context create cloud --docker host=ssh://cloud@web.cloud.dejonckhee.re

# Set up context
docker context use cloud
```

## Deploy

Deploy Docker Swarm stack files in the subdirectories by executing the following commands:

```
# Deploy 
docker stack deploy --compose-file [MODULE]/docker-compose.yml [MODULE]
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
