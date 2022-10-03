terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_instance" "ec2" {
  count                       = true ? 1 : 0 

  ami                         = "ami-04b9e92b5572fa0d1" # Ubuntu 18.04 LTS (64-bit x86)  Free Tier eligible
  instance_type               = "t2.micro" # Free Tier eligible

  subnet_id                   = "subnet-0276a451f2d29da19"
  vpc_security_group_ids      = [aws_security_group.ec2_security_group.id]
  associate_public_ip_address = true

  key_name                    = aws_key_pair.ec2_key_pair.key_name

  tags = {
    Name = "LHL - EC2 Demo"
  }
}

resource "aws_security_group" "ec2_security_group" {
  name        = "Free Tier EC2 Security Group"
  description = "The Description of the EC2 Security Group"

  vpc_id      = "vpc-06dad341535e8c209"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Free Tier EC2 Security Group"
  }
}


resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "free-tier-ec2-key"  # The SSH Key Name
  public_key = tls_private_key.pk.public_key_openssh
  # public_key = file("~/.ssh/id_rsa.pub") # The local path to the SSH Public Key
    provisioner "local-exec" { 
      # Create a "myKey.pem" to your computer!!
      command = "echo '${tls_private_key.pk.private_key_pem}' > ../${aws_key_pair.ec2_key_pair.key_name}.pem; chmod 400 ../${aws_key_pair.ec2_key_pair.key_name}.pem"
  }
}

output "ec2_id" {
  description = "The ID of the EC2"
  value       = concat(aws_instance.ec2.*.id, [""])[0]
}

output "ec2_arn" {
  description = "The ARN of the EC2"
  value       = concat(aws_instance.ec2.*.arn, [""])[0]
}

resource "aws_budgets_budget" "daily-budget" {
  name              = "daily-budget"
  budget_type       = "COST"
  limit_amount      = "10"
  limit_unit        = "USD"
  time_period_start = "2022-05-14_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 10
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["mohammadraza.pr@gmail.com"]
  }
}

