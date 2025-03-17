output "eks_role_arn" {
  description = "IAM role ARN for EKS cluster"
  value       = aws_iam_role.eks-role.arn
}


output "node_role_arn" {
  value = aws_iam_role.node.arn
}
