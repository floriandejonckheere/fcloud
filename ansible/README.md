# Ansible setup

This directory contains the Ansible infrastructure setup.

## Setup

```
# Edit credentials
cp .env.example .env
vim .env
source .env

# List inventory
ansible-inventory --list

# Ping hosts
ansible all -m ping
```

## Playbooks

### docker.yml

Installs Docker and Docker Compose on all machines.
Initializes Docker Swarm on Swarm manager and joins Swarm workers to the Swarm.
