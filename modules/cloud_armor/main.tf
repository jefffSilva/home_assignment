# Simplified Cloud Armor Module

# Define the security policy resource
resource "google_compute_security_policy" "policy" {
  provider    = google-beta
  project     = var.project_id
  name        = var.name
  description = var.description
  type        = "CLOUD_ARMOR" # Default type

  # Default rule (lowest priority) - set by variable
  rule {
    action   = var.default_rule_action
    priority = 2147483647 # Lowest priority
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default rule."
  }

  # Optional: Add a basic pre-configured WAF rule (e.g., OWASP ModSecurity Core Rule Set)
  dynamic "rule" {
    for_each = var.enable_owasp_ruleset ? { "owasp-crs-stable" : var.owasp_rule_config } : {}
    content {
      action   = rule.value.action
      priority = rule.value.priority
      preview  = rule.value.preview
      match {
        expr {
          # Corrected expression with proper quoting
          expression = "evaluatePreconfiguredWaf(\"${rule.value.target_rule_set}\", {\"sensitivity\": ${rule.value.sensitivity_level}})"
        }
      }
      # Corrected placement of description
      description = rule.value.description
    }
  }

  # Add basic logging configuration
  advanced_options_config {
    log_level = "NORMAL"
  }
}
