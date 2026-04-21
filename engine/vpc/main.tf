# ==============================================================================
# VPC SUB-ENGINE - NETWORKING STACK
# ==============================================================================

module "vpc" {
  count         = lookup(local.config.vpc, "enabled", false) ? 1 : 0
  source        = "../../../terraform-module/modules/vpc"
  config_file   = basename(var.config_path)
  global_config = local.config.global
  tags          = local.tags
}

output "vpc_id" {
  value = try(module.vpc[0].vpc_id, null)
}

output "public_subnets" {
  value = try(module.vpc[0].public_subnets, null)
}

output "private_subnets" {
  value = try(module.vpc[0].private_subnets, null)
}

output "vpc_cidr_block" {
  value = try(module.vpc[0].vpc_cidr_block, null)
}
