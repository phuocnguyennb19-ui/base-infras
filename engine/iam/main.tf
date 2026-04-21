# ==============================================================================
# IAM SUB-ENGINE - IDENTITY STACK
# ==============================================================================

module "iam" {
  count         = lookup(local.config.iam, "enabled", false) ? 1 : 0
  source        = "../../../terraform-module/modules/iam"
  config_file   = basename(var.config_path)
  global_config = local.config.global
  tags          = local.tags
}

output "role_ids" {
  value = try(module.iam[0].role_ids, null)
}

output "role_arns" {
  value = try(module.iam[0].role_arns, null)
}
