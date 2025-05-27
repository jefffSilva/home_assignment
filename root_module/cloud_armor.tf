# Root module usage of Cloud Armor

# Main external-facing policy
module "cloud_armor_security_policy" {
  source = "../modules/cloud_armor"

  project_id  = var.project_id
  name        = "external-sp-${local.resource_prefix}" # Using local prefix
  description = "Cloud Armor backend security policy with default OWASP rules"

  # Using defaults from the simplified module:
  # default_rule_action = "allow"
  # enable_owasp_ruleset = true
  # owasp_rule_config = default OWASP config
}

# Example policy for specific assets (if needed, adjust configuration)
# This example is simplified as the original rules are not directly supported by the refactored module.
# You might need to enhance the module or use different approaches for complex rules.
module "cloud_armor_security_policy_asset" {
  source = "../modules/cloud_armor"

  project_id  = var.project_id
  name        = "asset-sp-${local.resource_prefix}" # Using local prefix
  description = "Cloud Armor policy for specific assets (example)"

  # Example: Deny by default, disable OWASP rules for this specific policy
  default_rule_action  = "deny"
  enable_owasp_ruleset = false
}
