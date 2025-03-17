variable "cluster_name" {
  description = "EKS 클러스터 이름"
  type        = string
}

variable "vpc_id" {
  description = "EKS 클러스터가 사용할 VPC ID"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnets for the EKS cluster"
  type        = list(string)
}

variable "role_arn" {
  description = "IAM Role ARN for EKS cluster"
  type        = string
}
variable "node_role_arn" {
  description = "IAM Role ARN for EKS node group"
  type        = string
}

