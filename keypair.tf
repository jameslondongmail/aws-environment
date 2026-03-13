resource "aws_key_pair" "ssh_key" {
  key_name   = "${var.environment}-ssh-key"
  public_key = file(var.ssh_public_key_path)
}