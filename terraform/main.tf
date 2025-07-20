provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "lab_key" {
  key_name   = "lab-key"
  public_key = file("~/.ssh/lab-key.pub")   # Asegúrate de tener este par de llaves
}

resource "aws_instance" "ec2" {
  ami           = "ami-0c7217cdde317cfec"  # Ubuntu 22.04 LTS us-east-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.lab_key.key_name

  tags = {
    Name = "CloudLabEC2"
  }
}

resource "aws_s3_bucket" "lab_assets" {
  bucket = "arheanja-cloud-lab-assets-${random_id.suffix.hex}"
  force_destroy = true
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_ecr_repository" "lab_ecr" {
  name = "cloudlab-ecr"
}
