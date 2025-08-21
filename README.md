# IaC Basic: Terraform + Ansible (AWS)

Objectif : déployer une VM Ubuntu avec Terraform, puis la configurer (Nginx) via Ansible.

## Prérequis
- AWS CLI configuré (`aws configure`) avec accès IAM
- Terraform >= 1.6
- Ansible >= 2.16

## Déploiement
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply -auto-approve
terraform output
