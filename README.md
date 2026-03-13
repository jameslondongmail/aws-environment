# AWS Environment with Terraform (Ireland Region)

This Terraform configuration deploys a basic environment in AWS (eu-west-1) with:

- **VPC Architecture**:
  - Public and private subnets
  - Internet Gateway for public subnet access
  - NAT Gateway for private subnet outbound access
- **EC2 Instances**:
  - Public bastion host (in public subnet)
  - Private application instance (in private subnet)
- **Security**:
  - Restricted network access via security groups
  - SSH key pair authentication

## File Structure

| File                     | Purpose                                                                 |
|--------------------------|-------------------------------------------------------------------------|
| `vpc.tf`                 | VPC, subnets, route tables, and NAT Gateway configuration               |
| `sg.tf`                  | Security groups for public and private instances                        |
| `ec2.tf`                 | EC2 instance configurations (bastion + private instance)                |
| `keypair.tf`             | SSH key pair management for instance access                             |
| `variables.tf`           | Input variables with defaults                                           |
| `outputs.tf`             | Output values (IPs, DNS names, etc.)                                    |
| `terraform.tfvars.example` | Example configuration file (copy to `terraform.tfvars`)             |

## Deployment Guide

### 1. Prerequisites

```bash
# Install Terraform (v1.0+ recommended)
[Terraform Install Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

# Configure AWS CLI
aws configure
```

**Required**:
- AWS account with programmatic access
- IAM permissions for VPC/EC2 operations
- Existing SSH key pair

### 2. Initial Setup

```bash
# Clone repository
git clone <repository-url>
cd <repository-url>

# Prepare configuration
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your values:
```hcl
aws_region     = "eu-west-1"
instance_type  = "t3.micro"
public_key     = "ssh-rsa AAAAB3Nz..."
```

### 3. Terraform Execution

```bash
# Initialize providers/modules
terraform init

# Review execution plan
terraform plan

# Deploy infrastructure (type 'yes' to confirm)
terraform apply
```

### 4. Post-Deployment

**Access Instructions**:
- Bastion Host:
  ```bash
  ssh -i ~/.ssh/your_key.pem ec2-user@$(terraform output bastion_public_ip)
  ```
- Private Instance (via Bastion):
  ```bash
  ssh -i ~/.ssh/your_key.pem -J ec2-user@bastion_ip ec2-user@private_ip
  ```

**Outputs Available**:
```bash
terraform output
```

### 5. Network Architecture

| Component          | Public Subnet              | Private Subnet              |
|--------------------|----------------------------|-----------------------------|
| **Internet Access** | Internet Gateway           | NAT Gateway                 |
| **Route Table**    | 0.0.0.0/0 → igw-id         | 0.0.0.0/0 → nat-gw-id       |
| **Security**       | Allow SSH from trusted IPs | Allow SSH only from bastion |

### 6. Cleanup

```bash
# Destroy all resources
terraform destroy

# Remove local state
rm -rf .terraform*
```

## Best Practices

1. **State Management**:
   ```bash
   # Configure remote backend (S3 recommended)
   terraform {
     backend "s3" {
       bucket = "your-tf-state-bucket"
       key    = "env/terraform.tfstate"
       region = "eu-west-1"
     }
   }
   ```

2. **Variable Management**:
   - Use environment variables for secrets:
     ```bash
     export TF_VAR_aws_access_key="AKIA..."
     ```

3. **Tagging**:
   ```hcl
   tags = {
     Environment = "dev"
     Terraform   = "true"
   }
   ```
