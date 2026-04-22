# ==============================================================================
# COMPUTE SUB-ENGINE - CLUSTER STACK
# ==============================================================================

module "ecs_cluster" {
  count         = lookup(local.config.ecs_cluster, "enabled", lookup(local.config, "ecs", {}).enabled == true ? 1 : 0) ? 1 : 0
  source        = "../../../terraform-module/modules/ecs_cluster"
  config_file   = basename(var.config_path)
  global_config = local.config.global
  tags          = local.tags
}

output "cluster_arn" {
  value = try(module.ecs_cluster[0].cluster_arn, null)
}

output "cluster_name" {
  value = try(module.ecs_cluster[0].cluster_name, null)
}
