output "ec2_public_ip" {
  value = aws_instance.ec2.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.lab_assets.bucket
}

output "ecr_repository_url" {
  value = aws_ecr_repository.lab_ecr.repository_url
}
