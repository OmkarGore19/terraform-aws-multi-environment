# Multi-Environment AWS Infrastructure Provisioning using Terraform

## Overview

This project demonstrates Infrastructure as Code (IaC) using **Terraform** to provision and manage AWS infrastructure across three independent environments: **Development (DEV), Staging (STAGING), and Production (PROD)**.

The infrastructure is designed using reusable Terraform modules to maintain consistency, improve maintainability, and simplify resource management across environments.

The project also implements an Amazon S3 remote backend for centralized Terraform state management, with native S3 state locking.

## Architecture

The project provisions the following AWS infrastructure in each environment:

- Custom AWS VPC
- Public and Private Subnets
- Internet Gateway
- Public and Private Route Tables
- Route Table Associations
- Security Groups
- Ubuntu EC2 Instance (`t3.micro`)
- Nginx Web Server
- IAM Role and Instance Profile
- S3 Application Bucket
- S3 Bucket Versioning and Server-Side Encryption

### Architecture Diagram

```text
                    AWS Cloud
                        |
        +---------------+---------------+
        |               |               |
       DEV           STAGING           PROD
        |               |               |
       VPC             VPC             VPC
        |               |               |
   +----+----+     +----+----+     +----+----+
   |         |     |         |     |         |
Public   Private  Public  Private Public  Private
Subnet   Subnet   Subnet  Subnet   Subnet  Subnet
   |
Security Group
   |
EC2 Instance
   |
Nginx Web Server

Each Environment:
- IAM Role and Instance Profile
- S3 Application Bucket

Terraform Remote Backend:
Amazon S3
- DEV State
- STAGING State
- PROD State
- Native S3 State Locking
```

## Tech Stack

| Technology | Purpose |
|---|---|
| Terraform | Infrastructure as Code |
| AWS VPC | Network isolation |
| AWS EC2 | Virtual server provisioning |
| AWS S3 | Application storage and remote state |
| AWS IAM | Identity and access management |
| AWS Security Groups | Network traffic control |
| AWS Systems Manager | Instance management |
| Nginx | Web server |
| Ubuntu 24.04 | EC2 operating system |
| Git & GitHub | Version control |

## Project Structure

```text
terraform-project/
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── s3/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── iam/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── security-groups/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── environments/
│   ├── dev/
│   ├── staging/
│   └── prod/
│
├── backend-bootstrap/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── .gitignore
└── README.md
```

## AWS Network Configuration

Each environment uses a separate VPC and CIDR block.

| Environment | VPC CIDR | Public Subnet | Private Subnet |
|---|---|---|---|
| DEV | 10.0.0.0/16 | 10.0.1.0/24 | 10.0.11.0/24 |
| STAGING | 10.1.0.0/16 | 10.1.1.0/24 | 10.1.11.0/24 |
| PROD | 10.2.0.0/16 | 10.2.1.0/24 | 10.2.11.0/24 |

All environments were configured in the AWS Mumbai Region (`ap-south-1`).

## Terraform Modules

The project uses reusable modules to avoid duplicating infrastructure code.

**1. VPC Module**
- Creates VPC and subnets.
- Creates Internet Gateway.
- Configures public and private route tables.
- Creates route table associations.

**2. EC2 Module**
- Retrieves the official Ubuntu 24.04 AMI.
- Provisions EC2 instances.
- Installs and configures Nginx using user data.

**3. Security Groups Module**
- Configures inbound HTTP traffic on port 80.
- Configures outbound traffic rules.

**4. IAM Module**
- Creates IAM roles and instance profiles.
- Configures EC2 trust relationships.
- Grants required S3 access permissions.
- Attaches AmazonSSMManagedInstanceCore.

**5. S3 Module**
- Creates environment-specific application buckets.
- Enables bucket versioning.
- Configures server-side encryption.
- Blocks public access.

## Remote State Management

Terraform remote state was configured using Amazon S3.

Each environment used an independent state key:

| Environment | S3 State Key |
|---|---|
| DEV | dev/terraform.tfstate |
| STAGING | staging/terraform.tfstate |
| PROD | prod/terraform.tfstate |

The backend configuration used:

- Amazon S3 for remote state storage.
- Server-side encryption.
- S3 bucket versioning.
- Native S3 state locking using `use_lockfile = true`.

The backend bucket was initially provisioned using a separate Terraform configuration inside `backend-bootstrap`.

## Prerequisites

Before deploying the infrastructure, install:

- Terraform CLI (version 1.10 or later)
- AWS CLI
- Git
- An AWS account
- AWS IAM credentials with the required permissions

Configure AWS credentials:

```bash
aws configure
```

Verify the AWS identity:

```bash
aws sts get-caller-identity
```

## Deployment Workflow

### Step 1: Initialize Terraform

Navigate to the desired environment:

```bash
cd environments/dev
```

Initialize Terraform:

```bash
terraform init
```

### Step 2: Validate Configuration

```bash
terraform validate
```

### Step 3: Review Execution Plan

```bash
terraform plan
```

### Step 4: Deploy Infrastructure

```bash
terraform apply
```

Review the plan and confirm the deployment.

Repeat the process for STAGING and PROD using their respective directories.

### Step 5: Verify Infrastructure

Check the deployed AWS resources through the AWS Management Console or AWS CLI.

Access the EC2 public IP in a browser to verify the Nginx web server.

## Infrastructure Cleanup

Terraform was used to manage infrastructure lifecycle operations.

```bash
terraform destroy
```

Each environment was cleaned up separately.

The remote backend was also removed after infrastructure cleanup, including its stored state versions and lock objects.

**Note:** The AWS infrastructure was deployed and tested as part of this project. The resources and remote backend were subsequently deleted to avoid ongoing AWS charges.

## Key Learnings

- Implementing Infrastructure as Code using Terraform.
- Designing reusable and modular Terraform configurations.
- Managing multiple AWS environments independently.
- Configuring VPC networking and subnet architecture.
- Provisioning EC2 instances with automated Nginx installation.
- Implementing IAM roles and least-privilege access concepts.
- Managing Terraform remote state using Amazon S3.
- Understanding Terraform state migration, versioning and locking.
- Managing infrastructure deployment and destruction.

## Future Improvements

- Implement Terraform workspaces or additional environment configurations where appropriate.
- Introduce Terraform plan checks through a CI/CD pipeline.
- Add monitoring and alerting using Amazon CloudWatch.
- Implement automated infrastructure testing.
- Integrate infrastructure provisioning with GitHub Actions.

## Author

**Omkar Gore**

Cloud & DevOps Enthusiast

Skills: AWS | Terraform | Linux | Shell Scripting | Git | GitHub

---

If you found this project useful, feel free to explore the repository and share your feedback.