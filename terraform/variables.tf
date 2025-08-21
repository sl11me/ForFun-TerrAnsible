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
  description = "CIDR allowed to SSH (use your IP/32 in prod)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "my_ip" {
  description = "Ip à exposer par l'instance EC2"
  type        = string
  default     = "0.0.0.0/0"
}
