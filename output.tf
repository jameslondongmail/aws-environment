output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_instance_public_ip" {
  description = "Public IP address of the public instance"
  value       = aws_instance.public_instance.public_ip
}

output "private_instance_private_ip" {
  description = "Private IP address of the private instance"
  value       = aws_instance.private_instance.private_ip
}
