locals {
  name_prefix = var.project_name
}

module "governance" {
  source            = "./modules/governance"
  name_prefix       = local.name_prefix
  environment       = var.environment
  allowed_locations = var.allowed_locations
}
