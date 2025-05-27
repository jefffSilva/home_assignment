# Terraform GCP Infrastructure

This repository contains Terraform code for deploying a serverless infrastructure on Google Cloud Platform (GCP), primarily focused on Cloud Functions with supporting networking, security, and IAM components.

## Repository Structure

```
├── environments/          # Environment-specific configurations
│   ├── dev/               # Development environment
│   ├── qa/                # QA environment
│   └── prod/              # Production environment
├── modules/               # Reusable Terraform modules
│   ├── cloud_armor/       # Web Application Firewall
│   ├── cloud_function/    # Serverless functions
│   ├── core_network/      # VPC, subnets, firewall rules
│   ├── project_service/   # GCP API services enablement
│   ├── secret_manager/    # Secret management
│   └── service_accounts/  # IAM service accounts
├── root_module/           # Main Terraform configuration
│   ├── backend.tf         # State management configuration
│   ├── main.tf            # Root module configuration
│   ├── outputs.tf         # Root outputs
│   ├── providers.tf       # Provider configuration
│   ├── terraform.tfvars.example # Example variables file
│   └── variables.tf       # Root variables
└── README.md              # This file
```

## Getting Started

1. Clone this repository
2. Navigate to the `root_module` directory
3. Copy `terraform.tfvars.example` to `terraform.tfvars` and update with your values
4. Initialize Terraform: `terraform init`
5. Plan the deployment: `terraform plan`
6. Apply the configuration: `terraform apply`

## Modules

### Cloud Function

Deploys Google Cloud Functions with appropriate IAM permissions and triggers.

### Core Network

Sets up VPC networks, subnets, firewall rules, and private service connections.

### Cloud Armor

Configures Google Cloud Armor security policies for web application protection.

### Project Service

Enables required Google Cloud APIs for the project.

### Secret Manager

Manages secrets securely in Google Secret Manager.

### Service Accounts

Creates and manages service accounts with appropriate IAM roles.

## Environment Configuration

The repository supports multiple environments (dev, qa, prod) through separate `.tfvars` files. Each environment can have different configurations for resources, scaling, and security settings.

## Multi-Region Support

The infrastructure is designed to support deployment in multiple regions, with `us-central1` as the primary region.

## Serverless Focus

This infrastructure is optimized for serverless deployments (99% Cloud Functions), minimizing the need for managing servers or containers.

## Basic Observability

Basic logging and metrics are configured for all resources to enable monitoring and troubleshooting.

## Security Considerations

- Cloud Armor provides WAF protection
- Secret Manager securely stores sensitive information
- IAM roles follow the principle of least privilege
- Network security is enforced through firewall rules

## Maintenance

Regular updates to the Terraform modules and provider versions are recommended to ensure security and feature compatibility.
