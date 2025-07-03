module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.0"

  repository_name                  = "my-app"
  repository_type                  = "private"
  repository_image_tag_mutability = "MUTABLE"
  repository_force_delete          = true

  create_lifecycle_policy = false



  tags = {
    Name        = "my-app-ecr"
    Environment = "dev"
  }
}
