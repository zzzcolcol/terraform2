resource "aws_eks_cluster" "this" {
    name = var.cluster_name
    role_arn = var.role_arn
    vpc_config {
        subnet_ids = var.private_subnets
    }


}

resource "aws_eks_node_group" "default" {
  cluster_name = aws_eks_cluster.this.name
  node_group_name = "eks-node-group"
  node_role_arn = var.node_role_arn
  subnet_ids = var.private_subnets

  scaling_config {
    desired_size = 2
    max_size = 3
    min_size = 1
  }
}



