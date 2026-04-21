# ==============================================================================
# STORAGE SUB-ENGINE - ASSET & IMAGE STACK
# ==============================================================================

module "s3" {
  count         = lookup(local.config.s3, "enabled", false) ? 1 : 0
  source        = "../../../terraform-module/modules/s3"
  config_file   = basename(var.config_path)
  global_config = local.config.global
  tags          = local.tags
}

module "ecr" {
  count         = lookup(local.config.ecr, "enabled", false) ? 1 : 0
  source        = "../../../terraform-module/modules/ecr"
  config_file   = basename(var.config_path)
  global_config = local.config.global
  tags          = local.tags
}

output "s3_bucket_id" {
  value = try(module.s3[0].bucket_id, null)
}

output "ecr_repository_urls" {
  value = try(module.ecr[0].repository_urls, null)
}
