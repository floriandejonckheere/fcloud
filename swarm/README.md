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

### Traefik

Traefik is the reverse proxy used as frontend to all other services.

```
# Generate a htpasswd file for Traefik dashboard
htpasswd -c traefik/.htpasswd florian
```

### Cheatsheet

```
# Minecraft RCON console
ssh -tt cloud@minecraft.cloud.dejonckhee.re docker exec -ti \$\(docker ps -q -f name=minecraft_minecraft\) rcon-cli

# PostgreSQL shell
ssh -tt cloud@web.cloud.dejonckhee.re docker exec -ti \$\(docker ps -q -f name=postgres_postgres\) psql -U postgres

# Nextcloud shell
sh -tt cloud@web.cloud.dejonckhee.re docker exec -ti \$\(docker ps -q -f name=nextcloud_nextcloud\) sh
```
