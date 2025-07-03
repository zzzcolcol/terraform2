
data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}



module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access_cidrs = ["${chomp(data.http.my_ip.response_body)}/32"]
  create_kms_key = false
  cluster_encryption_config = {}
  enable_cluster_creator_admin_permissions = true
  




  enable_irsa = true


  eks_managed_node_groups = {
    default = {
      name            = "eks-nodes"
      desired_size    = 3
      max_size        = 3
      min_size        = 0
      instance_types  = ["t3.medium"]

      force_update_version = true
      

      launch_template = {
        id      = aws_launch_template.eks_lt.id
        version = "$Latest"
      }
            iam_role_additional_policies = {
        SSM = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
        LOG = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      }

      tags = {
        Name = "eks-nodes"
      }
    }
  }

cluster_addons = {
  vpc-cni = {
    addon_version     = "v1.19.2-eksbuild.5"
    resolve_conflicts = "OVERWRITE"
  }
  coredns = {
    addon_version     = "v1.11.4-eksbuild.2"
    resolve_conflicts = "OVERWRITE"
  }
  kube-proxy = {
    addon_version     = "v1.30.9-eksbuild.3"
    resolve_conflicts = "OVERWRITE"
  }
  eks-pod-identity-agent = {
    addon_version     = "v1.0.0-eksbuild.1"
    resolve_conflicts = "OVERWRITE"
  }
  aws-ebs-csi-driver = {
    addon_version             = "v1.31.0-eksbuild.1"
    resolve_conflicts         = "OVERWRITE"
    service_account_role_arn = aws_iam_role.ebs_csi.arn
  }
  aws-efs-csi-driver = {
    addon_version             = "v1.5.8-eksbuild.1"
    resolve_conflicts         = "OVERWRITE"
    service_account_role_arn = aws_iam_role.efs_csi.arn
  }
  
}


  tags = var.tags
}



output "cluster_name" {
  value = module.eks.cluster_name
}
