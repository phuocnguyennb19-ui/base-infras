# VARIABLES_MAPPING_GUIDE – aws-base-infras

## Purpose
The *engine* in this repository calls foundational modules (VPC, DNS, KMS, etc.) and passes a single `config_file` argument. Each module’s `locals.tf` loads the YAML, merges legacy keys, and exposes a `local.<module>_cfg` map.

## Adding a New Variable to a Base Service (example: DNS)

1. **Edit the YAML** (`deployments/<env>/infrastructure/dns.yml`):
   ```yaml
   dns:
     enabled: true
     domain_name: dev.platform.internal
     new_key: "my‑value"   # ← add here, keep 2‑space indentation
   ```

2. **Expose the key in the module** (`modules/route53/locals.tf`):
   ```hcl
   locals {
     # existing locals …
     new_key = try(local.raw_config.dns.new_key, null)
   }
   ```

3. **Reference the variable** in the module’s resources if needed (e.g., Route53 zone comment):
   ```hcl
   resource "aws_route53_zone" "this" {
     name    = local.domain_name
     comment = local.new_key   # example usage of the new key
   }
   ```

4. **Engine side** – no change required; the engine already passes `config_file = basename(var.config_path)` to the module.

## Legacy Key Support
If older configurations still use `route53` instead of `dns`, keep the merge block in `modules/route53/locals.tf`:

```hcl
dns_cfg = merge(
  try(local.raw_config.dns, {}),
  try(local.raw_config.route53, {})   # legacy
)
```

## Quick Validation
```bash
cd aws-base-infras/engine
terraform init -backend=false
terraform validate   # should succeed if the new key exists in the YAML
```

---

**Result:** You can now add any custom key to the base‑infrastructure YAML files and expose it to the corresponding Terraform module with only two small edits.
