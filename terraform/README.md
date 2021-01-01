# Terraform setup

This directory contains the multi-cloud infrastructure setup in Terraform format.

## Setup

```
# Set variables
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars

# Set backend config
cp backend.tfvars.example backend.tfvars
nano backend.tfvars

# Initialize Terraform
terraform init -backend-config=backend.tfvars
```

## Minecraft

To set up the Minecraft server, run:

```
terraform apply -var minecraft=true -target=module.minecraft 
```

To tear down the Minecraft server, run:

```
terraform apply -var minecraft=false -target=module.minecraft
```
