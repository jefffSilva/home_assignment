module "firewall_rules" {
  source       = "../modules/firewall_rules"
  project_id   = var.project_id
  network_name = var.vpc_name

  rules = [
    {
      name                    = "allow-ssh-ingress"
      description             = null
      direction               = "INGRESS"
      priority                = null
      ranges                  = var.ssh_ingress_ranges
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [{
        protocol = var.ssh_ingress_protocol
        ports    = var.ssh_ingress_ports
      }]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    },
    {
      name                    = "allow-all-egress"
      description             = null
      direction               = "EGRESS"
      priority                = null
      ranges                  = var.openvpn_egress_ranges
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [{
        protocol = var.openvpn_egress_protocol
        ports    = var.openvpn_egress_ports
      }]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    }
  ]
}