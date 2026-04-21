# ==============================================================================
# INFRASTRUCTURE ENGINE - FOUNDATIONAL RESOURCES
# ==============================================================================

# 1. Identity & Access (IAM)
module "iam" {
  count  = try(local.config.iam.enabled, false) ? 1 : 0
  source = "git::https://github.com/phuocnguyennb19-ui/terraform-project.git//modules/iam?ref=master"
}

# 2. Network Layer (VPC)
module "vpc" {
  count  = try(local.config.vpc.enabled, false) ? 1 : 0
  source = "git::https://github.com/phuocnguyennb19-ui/terraform-project.git//modules/vpc?ref=master"
}

# 3. Security (KMS & Secrets Manager)
module "kms" {
  count  = try(local.config.kms.enabled, false) ? 1 : 0
  source = "git::https://github.com/phuocnguyennb19-ui/terraform-project.git//modules/kms?ref=master"
}

module "secrets_manager" {
  count  = try(local.config.secrets_manager.enabled, false) ? 1 : 0
  source = "git::https://github.com/phuocnguyennb19-ui/terraform-project.git//modules/secrets-manager?ref=master"
}

# 4. Storage (S3)
module "s3" {
  count  = try(local.config.s3.enabled, false) ? 1 : 0
  source = "git::https://github.com/phuocnguyennb19-ui/terraform-project.git//modules/s3?ref=master"
}

# 5. Domain & SSL (Route53 & ACM)
module "route53" {
  count  = try(local.config.route53.enabled, false) ? 1 : 0
  source = "git::https://github.com/phuocnguyennb19-ui/terraform-project.git//modules/route53?ref=master"
}

module "acm" {
  count  = try(local.config.acm.enabled, false) ? 1 : 0
  source = "git::https://github.com/phuocnguyennb19-ui/terraform-project.git//modules/acm?ref=master"
}

# 6. Container Registry (ECR)
module "ecr" {
  count  = try(local.config.ecr.enabled, false) ? 1 : 0
  source = "git::https://github.com/phuocnguyennb19-ui/terraform-project.git//modules/ecr?ref=master"
}

# 7. Web Application Firewall (WAF)
module "waf" {
  count  = try(local.config.waf.enabled, false) ? 1 : 0
  source = "git::https://github.com/phuocnguyennb19-ui/terraform-project.git//modules/waf?ref=master"
}

# Outputs for Platform Engine
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

# Identity & Security
output "iam_role_ids" {
  value = try(module.iam[0].role_ids, null)
}

output "kms_key_arn" {
  value = try(module.kms[0].key_arn, null)
}

output "secrets_manager_arn" {
  value = try(module.secrets_manager[0].secret_arn, null)
}

# Storage & Registry
output "s3_bucket_id" {
  value = try(module.s3[0].bucket_id, null)
}

output "ecr_repository_urls" {
  value = try(module.ecr[0].repository_urls, null)
}

# Domain
output "route53_zone_id" {
  value = try(module.route53[0].zone_id, null)
}

output "acm_certificate_arn" {
  value = try(module.acm[0].certificate_arn, null)
}

output "waf_web_acl_arn" {
  value = try(module.waf[0].web_acl_arn, null)
}
