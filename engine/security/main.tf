# ==============================================================================
# SECURITY SUB-ENGINE - DATA PROTECTION STACK
# ==============================================================================

module "kms" {
  count         = lookup(local.config.kms, "enabled", false) ? 1 : 0
  source        = "../../../terraform-module/modules/kms"
  config_file   = basename(var.config_path)
  global_config = local.config.global
  tags          = local.tags
}

module "secrets_manager" {
  count         = lookup(local.config.secrets_manager, "enabled", false) ? 1 : 0
  source        = "../../../terraform-module/modules/secrets_manager"
  config_file   = basename(var.config_path)
  global_config = local.config.global
  tags          = local.tags
}

output "kms_key_arn" {
  value = try(module.kms[0].key_arn, null)
}

output "secrets_manager_arn" {
  value = try(module.secrets_manager[0].secret_arn, null)
}
