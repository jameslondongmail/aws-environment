# AWS Environment with Terraform (Ireland Region)

This Terraform configuration deploys a basic environment into an AWS environment in the Ireland region (eu-west-1) with:
- A VPC with public and private subnets
- Two EC2 instances (public bastion host and private instance)
- Restricted network access according to security requirements

## File Structure

| File                 | Purpose                                                                 |
|----------------------|-------------------------------------------------------------------------|
| `vpc.tf`             | Contains VPC module configuration and networking setup                  |
| `sg.tf`              | Defines security groups for public and private instances                |
| `ec2.tf`             | Contains EC2 instance configurations                                    |
| `keypair.tf`         | Manages SSH key pair for instance access                                |
| `variables.tf`       | Declares all input variables with defaults                              |
| `outputs.tf`         | Defines output values for easy reference                                |
| `terraform.tfvars.example` | Example variable values file                                      |

## Detailed Execution Guide

### Prerequisites
1. Install Terraform (v1.0+)
2. Configure AWS CLI with proper credentials
3. Have an existing SSH key pair or create a new one

### Initial Setup
1. Clone this repository
2. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars