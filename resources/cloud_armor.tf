module "cloud_armor_security_policy" {
  source = "../modules/cloud_armor"

  project_id  = var.project_id
  name        = "external-sp-${var.common_resource_id}"
  description = "Cloud Armor backend security policy with preconfigured rules, security rules and custom rules"
  type        = "CLOUD_ARMOR"

  # Enable Layer 7 DDoS defense
  layer_7_ddos_defense_enable          = true
  layer_7_ddos_defense_rule_visibility = "STANDARD"

  # Set JSON parsing to STANDARD
  json_parsing = "STANDARD"

  # Set log level to VERBOSE
  log_level = "VERBOSE"

  # Pre-configured WAF Rules
  pre_configured_rules = {
    "sqli_rule" = {
      action            = "deny(403)"
      priority          = 1000
      target_rule_set   = "sqli-stable"
      sensitivity_level = 1
      preview           = true
      description       = "Block SQL Injection attempts"
    }
    "xss_rule" = {
      action            = "deny(403)"
      priority          = 1001
      target_rule_set   = "xss-v33-stable"
      sensitivity_level = 1
      description       = "Block Cross-Site Scripting attempts"
    }
    "rce_rule" = {
      action            = "deny(403)"
      priority          = 1002
      target_rule_set   = "rce-v33-stable"
      sensitivity_level = 1
      description       = "Block Remote Code Execution attempts"
    }
  }

  # Custom Rules

  # Default rule to allow all other traffic
  default_rule_action = "allow"

}
module "cloud_armor_security_policy_asset" {
  source = "../modules/cloud_armor"

  project_id  = var.project_id
  name        = "asset-sp-${var.common_resource_id}"
  description = "Cloud Armor backend security policy with preconfigured rules, security rules and custom rules"
  type        = "CLOUD_ARMOR"

  # Enable Layer 7 DDoS defense
  layer_7_ddos_defense_enable = false
  #layer_7_ddos_defense_rule_visibility = "STANDARD"

  # Set JSON parsing to STANDARD
  #json_parsing = "STANDARD"

  # Set log level to VERBOSE
  #log_level = "VERBOSE"
  security_rules = {
    deny_all = {
      action      = "deny(403)"
      priority    = 2147483640
      description = "Deny all other paths"
      preview     = false

      src_ip_ranges = ["*"]

      # Not using these features, so we set them to empty or null
      redirect_type      = null
      redirect_target    = null
      rate_limit_options = {}
      header_action      = []
    }
  }

  # Custom Rules
  custom_rules = {
    allow_uploads = {
      action      = "allow"
      priority    = 1000
      description = "Allow only /wp-content/uploads/*"
      preview     = false
      expression  = "request.path.startsWith('/wp-content/uploads/')"

      # Optional fields (can be left out if not used)
      redirect_type                       = null
      redirect_target                     = null
      rate_limit_options                  = {}
      header_action                       = []
      preconfigured_waf_config_exclusions = null
    }
  }

  # Default rule to allow all other traffic
  default_rule_action = "allow"

}