variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix for resource naming"
  type        = string
  default     = "ForFun-iac"
}

variable "public_key_path" {
  description = "Path to your local SSH public key"
  type        = string
  default     = "~/.ssh/ForFun/Forfun.pub"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "allow_ssh_cidr" {
  description = "CIDR allowed to SSH (use your IP/32 in production)"
  type        = string
  default     = "0.0.0.0/0"  
  validation {
    condition     = can(cidrhost(var.allow_ssh_cidr, 0))
    error_message = "Le CIDR SSH doit être valide."
  }
}

variable "my_ip" {
  description = "IP à exposer par l'instance EC2 (HTTP)"
  type        = string
  default     = "0.0.0.0/0"
  validation {
    condition     = can(cidrhost(var.my_ip, 0))
    error_message = "L'IP doit être un CIDR valide."
  }
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "L'environnement doit être dev, staging ou prod."
  }
}
