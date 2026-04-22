# ==============================================================================
# EDGE SUB-ENGINE - TRAFFIC & SECURITY STACK
# ==============================================================================

module "route53" {
  count         = local.dns_enabled ? 1 : 0
  source        = "../../../terraform-module/modules/dns"
  config_file   = basename(var.config_path)
  global_config = local.config.global
  tags          = local.tags
}

module "acm" {
  count         = lookup(local.config.acm, "enabled", false) ? 1 : 0
  source        = "../../../terraform-module/modules/acm"
  config_file   = basename(var.config_path)
  global_config = local.config.global
  tags          = local.tags
}

module "waf" {
  count         = lookup(local.config.waf, "enabled", false) ? 1 : 0
  source        = "../../../terraform-module/modules/waf"
  config_file   = basename(var.config_path)
  global_config = local.config.global
  tags          = local.tags
}

output "route53_zone_id" {
  value = try(module.route53[0].zone_id, null)
}

output "acm_certificate_arn" {
  value = try(module.acm[0].certificate_arn, null)
}

output "waf_web_acl_arn" {
  value = try(module.waf[0].web_acl_arn, null)
}
