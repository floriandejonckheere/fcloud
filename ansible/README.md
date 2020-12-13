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

```
# Install Docker and Docker Compose on all hosts
ansible-playbook docker.yml

# Initialize Docker Swarm on Swarm manager and join Swarm workers to the Swarm
ansible-playbook docker-swarm-create.yml

# Release all hosts and uninitialize the Swarm
ansible-playbook docker-swarm-destroy.yml
```
