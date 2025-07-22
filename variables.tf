variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1c"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "cluster_name" {
  default = "kkj-eks-cluster"
}

variable "cluster_version" {
  default = "1.30"
}

variable "tags" {
  type = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}
