# 🎮 Deploy Super Mario Game on AWS EKS using Terraform

![Super Mario Banner](https://www.nintendo.com/eu/media/images/10_share_images/portals_3/2x1_SuperMarioHub_image1600w.jpg)

Welcome to a fun and hands-on DevOps project where we deploy the nostalgic **Super Mario Game** on a production-grade **Amazon EKS** (Elastic Kubernetes Service) cluster using **Terraform** and **Kubernetes**.

---

## 🚀 What You’ll Learn

- Running Docker containers locally
- Writing Kubernetes manifests (Deployment + Service)
- Using Terraform to provision AWS EKS clusters
- Accessing Kubernetes apps via AWS LoadBalancer
- Cleaning up resources to avoid unnecessary billing

---

## 📦 Tech Stack

- Docker
- Kubernetes
- Amazon EKS
- Terraform
- AWS CLI & IAM
- LoadBalancer Service

---

## 🛠️ Prerequisites

Before you begin, ensure you have:

- Basic knowledge of Docker & Kubernetes
- Docker installed
- AWS CLI configured (`aws configure`)
- Terraform installed
- An AWS account with IAM access

---

## 🧪 Step 1: Test the Game Locally

```bash
docker run -d -p 8080:80 sevenajay/mario:latest
````

Visit [http://localhost:8080](http://localhost:8080) and use `W`, `S`, `A`, `D` keys to control Mario.

---

## 🗂️ Step 2: Project Structure

```
mario-game/
├── deployment.yml
├── service.yml
└── terr-config/
    ├── backend.tf
    ├── main.tf
    └── provider.tf
```

---

## ⚙️ Step 3: Create Kubernetes Manifests

### `deployment.yml`

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mario-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: mario
  template:
    metadata:
      labels:
        app: mario
    spec:
      containers:
      - name: mario-container
        image: sevenajay/mario:latest 
        ports:
        - containerPort: 80
```

### `service.yml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mario-service
spec:
  type: LoadBalancer
  selector:
    app: mario
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```

---

## ☁️ Step 4: Configure Terraform for EKS

### `provider.tf`

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

### `backend.tf`

```hcl
terraform {
  backend "s3" {
    bucket = "pravesh-mario-bucket"
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}
```

### `main.tf`

> See full [main.tf content here](https://dev.to/aws-builders/easy-steps-to-deploy-super-mario-game-on-aws-eks-using-terraform-4oi) as it's large to include here in full.

---

## 🚀 Step 5: Deploy EKS Infrastructure

```bash
cd mario-game/terr-config/
terraform init
terraform plan
terraform apply --auto-approve
```

---

## 🔗 Step 6: Connect to EKS Cluster

```bash
aws eks update-kubeconfig --name EKS_CLOUD --region us-east-1
```

---

## 📤 Step 7: Deploy to Kubernetes

```bash
cd mario-game/
kubectl apply -f deployment.yml
kubectl apply -f service.yml
```

---

## 🌍 Step 8: Access the Game

```bash
kubectl describe service mario-service
```

Look for the **LoadBalancer Ingress URL** and open it in your browser.

---

## 🧹 Step 9: Clean Up Resources

To avoid unnecessary AWS charges:

```bash
cd terr-config/
terraform destroy --auto-approve
```

---

## 📖 Blog Post

Read the full blog post with detailed explanation here:
👉 [Easy Steps to Deploy Super Mario Game on AWS EKS using Terraform](https://dev.to/aws-builders/easy-steps-to-deploy-super-mario-game-on-aws-eks-using-terraform-4oi)

---

## 🙌 Follow Me

Stay connected and explore more DevOps tutorials:

* 🔗 [LinkedIn](https://linkedin.com/in/praveshsudha)
* 🐦 [Twitter/X](https://twitter.com/praveshsudha)
* 📺 [YouTube](https://youtube.com/@praveshsudha)
* 🌐 [My Blog](https://blog.praveshsudha.com)

---

## 💡 License

This project is for educational and non-commercial use only.

---

**Happy Learning! 🎮☁️**
*\~ Pravesh Sudha*


