terraform {
  backend "s3" {
    bucket = "pravesh-mario-bucket"
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}