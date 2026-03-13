# Security Group for Public Instance
resource "aws_security_group" "public_instance_sg" {
  name        = "${var.environment}-public-instance-sg"
  description = "Security group for public instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from allowed IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-public-instance-sg"
    Environment = var.environment
  }
}

# Security Group for Private Instance
resource "aws_security_group" "private_instance_sg" {
  name        = "${var.environment}-private-instance-sg"
  description = "Security group for private instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "SSH from public instance"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_instance_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-private-instance-sg"
    Environment = var.environment
  }
}