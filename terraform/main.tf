############################
# VPC + Subnet + Internet
############################
resource "aws_vpc" "forfun" {
  cidr_block           = "10.50.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = "${var.project_name}-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.forfun.id
  tags   = { Name = "${var.project_name}-igw" }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.forfun.id
  cidr_block              = "10.50.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"
  tags                    = { Name = "${var.project_name}-subnet-public-a" }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.forfun.id
  tags   = { Name = "${var.project_name}-public-rt" }
}

resource "aws_route" "default_internet" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

############################
# Security Group
############################
resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.forfun.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-sg" }
}

############################
# Key Pair (SSH)
############################
resource "aws_key_pair" "forfun" {
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)
  tags       = { Name = "${var.project_name}-key" }
}

############################
# AMI Ubuntu (22.04 LTS)
############################
data "aws_ami" "ubuntu" {
  owners      = ["099720109477"] # Canonical
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*22.04-amd64*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

############################
# EC2 Instance
############################
resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_a.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = aws_key_pair.forfun.key_name
  associate_public_ip_address = true

  tags = {
    Name    = "${var.project_name}-web"
    Project = var.project_name
  }
}
