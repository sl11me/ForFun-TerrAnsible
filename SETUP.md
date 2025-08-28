# 🚀 Guide de Configuration - ForFun-1-TerrAnsible

## 📋 Prérequis

- AWS CLI configuré
- Terraform >= 1.6
- Ansible >= 2.16
- Clé SSH configurée

## 🔧 Configuration

### 1. Configuration Terraform

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Éditez terraform.tfvars avec vos valeurs
nano terraform.tfvars
```

**Variables à configurer :**
- `allow_ssh_cidr` : Votre IP pour SSH (ex: "203.0.113.1/32")
- `my_ip` : Votre IP pour HTTP (ex: "203.0.113.1/32")
- `public_key_path` : Chemin vers votre clé SSH publique

### 2. Configuration Ansible

```bash
cd ansible
cp inventory.example.ini inventory.ini
# Éditez inventory.ini avec votre IP d'instance
nano inventory.ini
```

**Variables à configurer :**
- Remplacez `<your-instance-ip>` par l'IP de votre instance AWS
- Vérifiez le chemin de votre clé SSH privée

## 🚀 Déploiement

### 1. Déployer l'Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
terraform output  # Notez l'IP publique
```

### 2. Configurer le Serveur Web

```bash
cd ../ansible
# Mettez à jour inventory.ini avec l'IP de votre instance
ansible-playbook site.yml
```

## 🌐 Accès au Site Web

Une fois déployé, accédez à votre site via :
```
http://<votre-ip-publique>
```

## 🔒 Sécurité

- ⚠️ Ne commitez jamais de fichiers `.tfstate`
- ⚠️ Ne commitez jamais d'IPs réelles
- ⚠️ Utilisez des clés SSH au lieu de mots de passe
- ⚠️ Limitez l'accès SSH à votre IP uniquement

## 🛠️ Commandes Utiles

```bash
# Vérifier le statut Terraform
terraform show

# Tester la connexion SSH
ssh -i ~/.ssh/id_rsa ubuntu@<votre-ip>

# Tester le site web
curl http://<votre-ip>

# Vérifier les processus sur l'instance
ssh -i ~/.ssh/id_rsa ubuntu@<votre-ip> "sudo systemctl status nginx"
```
