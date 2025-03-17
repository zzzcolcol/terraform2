output "vpc_id" {
    value = module.vpc.vpc_id
}

output "eks_cluster_name" {
    value = module.eks.eks_cluster_name
}

output "eks_cluster_endpoint" {
    value = module.eks.eks_cluster_endpoint
}