output "eks_role_arn" {
  description = "IAM Role ARN for EKS cluster"
  value       = var.role_arn
}

output "node_role_arn" {
  description = "IAM Role ARN for EKS node group"
  value       = var.node_role_arn
}
output "eks_cluster_name" {
  description = "EKS 클러스터 이름"
  value       = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  description = "EKS 클러스터 엔드포인트"
  value       = aws_eks_cluster.this.endpoint
}

output "eks_cluster_ca_certificate" {
  description = "EKS 클러스터 인증서"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}
