#!/usr/bin/env bash

WORKER_TOKEN=$(ssh web docker swarm join-token --quiet worker)
MANAGER_TOKEN=$(ssh web docker swarm join-token --quiet worker)

WEB=web.cloud.dejonckhee.re
VPN=vpn.cloud.dejonckhee.re
MC=minecraft.cloud.dejonckhee.re

WEB_IP=$(dig +short ${WEB})
VPN_IP=$(dig +short ${VPN})
MC_IP=$(dig +short ${MC})

# Init swarm
echo "Initializing swarm"
ssh ${WEB} "docker node ls > /dev/null || docker swarm init --advertise-addr ${WEB_IP}:2377"

# Join vpn
echo "Joining VPN to swarm"
ping -c 1 -W 1 ${VPN} > /dev/null && ssh ${VPN} "(docker info | grep 'Swarm: active') || docker swarm join --token ${WORKER_TOKEN} --advertise-addr ${VPN_IP} ${WEB_IP} > /dev/null"

# Join minecraft
echo "Joining Minecraft to swarm"
ping -c 1 -W 1 ${MC} > /dev/null && ssh ${MC} "(docker info | grep 'Swarm: active') || docker swarm join --token ${WORKER_TOKEN} --advertise-addr ${MC_IP} ${WEB_IP} > /dev/null"
