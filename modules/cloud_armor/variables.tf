# Variables for the simplified Cloud Armor module

variable "project_id" {
  description = "The project ID where the Cloud Armor policy will be created."
  type        = string
}

variable "name" {
  description = "The name for the Cloud Armor security policy."
  type        = string
}

variable "description" {
  description = "A description for the Cloud Armor security policy."
  type        = string
  default     = "Default Cloud Armor security policy"
}

variable "default_rule_action" {
  description = "Action for the default rule (lowest priority). Allowed values: \"allow\", \"deny\"."
  type        = string
  default     = "allow"
  validation {
    condition     = contains(["allow", "deny"], var.default_rule_action)
    error_message = "Allowed values for default_rule_action are: allow, deny."
  }
}

variable "enable_owasp_ruleset" {
  description = "Whether to enable the pre-configured OWASP ModSecurity Core Rule Set."
  type        = bool
  default     = true
}

variable "owasp_rule_config" {
  description = "Configuration for the OWASP ModSecurity Core Rule Set if enabled."
  type = object({
    action            = string
    priority          = number
    preview           = bool
    target_rule_set   = string
    sensitivity_level = number
    description       = string
  })
  default = {
    action            = "deny(403)" # Example action, could be allow, deny(status), etc.
    priority          = 1000        # Example priority
    preview           = false
    target_rule_set   = "owasp-crs-stable" # Example ruleset
    sensitivity_level = 4           # Default sensitivity
    description       = "OWASP ModSecurity Core Rule Set"
  }
}
