# Public Instance (Bastion Host)
resource "aws_instance" "public_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.public_instance_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name        = "${var.environment}-public-instance"
    Environment = var.environment
  }
}

# Private Instance
resource "aws_instance" "private_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.private_instance_sg.id]
  key_name               = aws_key_pair.ssh_key.key_name

  tags = {
    Name        = "${var.environment}-private-instance"
    Environment = var.environment
  }
}
