terraform {
    required_version = ">=1.5.0"
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        }
    }
}

provider "aws" {
  region = var.aws_region
}

# VPC 모듈 호출
module "vpc" {
  source = "./vpc"
  vpc_cidr = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  availability_zones = var.availability_zones
 
}


# EKS 모듈 호출
module "eks" {
    source  = "./eks"
    cluster_name = var.cluster_name
    vpc_id = module.vpc.vpc_id
    private_subnets = module.vpc.private_subnets
    role_arn = module.iam.eks_role_arn
    node_role_arn = module.iam.node_role_arn
}
module "iam" {
    source = "./iam"
}
