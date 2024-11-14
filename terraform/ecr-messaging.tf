module "ecr_messaging" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "1.6.0"

  repository_name                   = "messaging"
  repository_type                   = "private"
  create_lifecycle_policy           = false
  repository_force_delete           = false
  repository_read_access_arns       = []
  repository_read_write_access_arns = []
}

output "repository_arn_messaging" {
  description = "Full ARN of the repository"
  value       = module.ecr_messaging.repository_arn
}

output "repository_registry_id_messaging" {
  description = "The registry ID where the repository was created"
  value       = module.ecr_messaging.repository_registry_id
}

output "repository_url_messaging" {
  description = "The URL of the repository (in the form `aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName`)"
  value       = module.ecr_messaging.repository_url
}
