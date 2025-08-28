# IaC Basic: Terraform + Ansible (AWS)

Objectif : déployer une VM Ubuntu avec Terraform, puis la configurer (Nginx) via Ansible.

## Prérequis
- AWS CLI configuré (`aws configure`) avec accès IAM
- Terraform >= 1.6
- Ansible >= 2.16

## Configuration Sécurisée

### 1. Terraform
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars
```

### 2. Ansible
```bash
cd ansible
cp inventory.example.ini inventory.ini
nano inventory.ini
```

## Déploiement
```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
terraform output

# Puis configurer avec Ansible
cd ../ansible
ansible-playbook site.yml
```

## Variables à Configurer

### Terraform (terraform.tfvars)
- `allow_ssh_cidr` : Votre IP pour SSH (ex: "203.0.113.1/32")
- `my_ip` : Votre IP pour HTTP (ex: "203.0.113.1/32")
- `public_key_path` : Chemin vers votre clé SSH publique

### Ansible (inventory.ini)
- IP de votre instance AWS
- Chemin vers votre clé SSH privée

## Sécurité

Voir [SECURITY.md](SECURITY.md) pour plus de détails.
