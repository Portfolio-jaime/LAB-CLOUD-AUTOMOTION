provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "lab-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "dev_vm" {
  ami           = "ami-0c2b8ca1dad447f8a" # Ubuntu 22.04 Free Tier
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ssh_key.key_name

  tags = { Name = "lab-dev-vm" }

  vpc_security_group_ids = [aws_security_group.lab_sg.id]
}

resource "aws_security_group" "lab_sg" {
  name        = "lab-sg"
  description = "Allow SSH and HTTP"
  ingress = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 8080, to_port = 8080, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]
  egress = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
  ]
}

resource "aws_s3_bucket" "assets" {
  bucket = "jaime-lab-assets-${random_id.bucket_id.hex}"
  force_destroy = true
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_ecr_repository" "go_api" {
  name = "go-api"
}

resource "aws_ecr_repository" "py_worker" {
  name = "py-worker"
}

output "instance_public_ip" {
  value = aws_instance.dev_vm.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.assets.bucket
}

output "ecr_go_api_url" {
  value = aws_ecr_repository.go_api.repository_url
}

output "ecr_py_worker_url" {
  value = aws_ecr_repository.py_worker.repository_url
}
