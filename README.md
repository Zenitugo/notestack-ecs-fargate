# Notestack 3-Tier App on AWS ECS Fargate

[![AWS ECS](https://img.shields.io/badge/AWS-ECS_Fargate-orange.svg)](https://aws.amazon.com/ecs/)
[![AWS RDS](https://img.shields.io/badge/AWS-RDS_PostgreSQL-blue.svg)](https://aws.amazon.com/rds/)
[![AWS Secrets Manager](https://img.shields.io/badge/AWS-Secrets_Manager-red.svg)](https://aws.amazon.com/secrets-manager/)
[![AWS Cloud Map](https://img.shields.io/badge/AWS-Cloud_Map-yellow.svg)](https://aws.amazon.com/cloud-map/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-blue.svg)](https://www.docker.com/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-purple.svg)](https://www.terraform.io/)
[![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-black.svg)](https://github.com/features/actions)
[![FastAPI](https://img.shields.io/badge/Backend-FastAPI-green.svg)](https://fastapi.tiangolo.com/)
[![Nginx](https://img.shields.io/badge/Frontend-Nginx-brightgreen.svg)](https://www.nginx.com/)


## 📖 Overview
Notestack is a full-stack notes application with a FastAPI backend, 
Nginx frontend, and PostgreSQL database. This project demonstrates 
how to deploy a real-world 3-tier application on AWS ECS Fargate 
using Terraform for infrastructure as code and GitHub Actions for 
CI/CD automation.

This is Part 3 of my ECS deployment series. 

Part 1 [EC2 launch type](https://dhebbydavid.hashnode.dev/deploying-your-first-containerized-application-on-aws-ecs-part-1)

Part 2 [Fargate + AWS CLI](https://dhebbydavid.hashnode.dev/deploying-your-containerized-application-on-aws-ecs-part-2-fargate-launch-type)

## 🚀 Features
- 3-tier architecture: Nginx frontend, FastAPI backend, RDS PostgreSQL.
- Deployed on AWS ECS Fargate.
- Infrastructure provisioned with Terraform modules.
- GitHub Actions pipeline — automated build, push, and deployment.
- AWS Secrets Manager — database credentials never hardcoded.
- AWS Cloud Map Service Discovery — stable DNS for backend routing.
- ECR image scanning enabled on push.
- Container logs streamed to CloudWatch.
- Multi-AZ RDS for database resilience.

## 🛠 Tech Stack
- Python 3.12 + FastAPI + Uvicorn
- Nginx
- Docker
- Amazon ECS (Fargate launch type)
- Amazon RDS (PostgreSQL 16)
- Amazon ECR
- AWS Secrets Manager
- AWS Cloud Map (Service Discovery)
- Application Load Balancer
- Amazon CloudWatch Logs
- Terraform
- GitHub Actions

## 📂 Repo Structure
```
notestack-ecs-fargate/
├── README.md
├── note-stack-app
│   ├── backend
│   │   ├── Dockerfile
│   │   ├── main.py
│   │   └── requirements.txt
│   ├── compose.yml
│   └── frontend
│       ├── Dockerfile
│       ├── index.html
│       └── nginx.conf
└── terraform
    ├── modules/ 
    └── prod
        ├── backend.tf
        ├── main.tf
        ├── output.tf
        ├── provider.tf
        ├── values.tfvars
        └── variable.tf
```

## ⚙️ Setup Instructions

1. Clone the repo
```bash
   git clone https://github.com/Zenitugo/notestack-ecs-fargate.git
   cd notestack-ecs-fargate
```

2. Set up local environment
```bash
   cp .env.example .env
   # Fill in your local values in .env
```

3. Run locally with Docker Compose
```bash
   docker compose up --build
   # Visit http://localhost:3000
```

4. Add GitHub Secrets before deploying

```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_ACCOUNT_ID
DB_USERNAME
DB_PASSWORD
```

5. Push to master branch to trigger deployment
```bash
   git push origin master
```

## 📚 Blog Post
[Deployment of a three tier app on ECS Fargate](https://dhebbydavid.hashnode.dev/building-a-real-world-3-tier-app-on-aws-ecs-fargate)

## 👤 Author
Ugochi Ukaegbu

AWS Builders Community Programme — Containers Track

[LinkedIn](https://www.linkedin.com/in/ugochiukaegbu/) | [Hashnode](https://dhebbydavid.hashnode.dev)