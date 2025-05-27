project_id         = "z-test-mr-yxz-test-0001"
common_resource_id = "smt-the-dev-test-a1b2"
region             = "us-east1"

subnets_list = [
  {
    name      = "public-1"
    cidr      = "10.8.1.0/24"
    region    = "us-east1"
    allow_nat = true
    secondary_ip_range = []

  },
  {
    name      = "private-1"
    cidr      = "10.8.2.0/24"
    region    = "us-east1"
    allow_nat = true
    secondary_ip_range = []

  },
]

nat_external_ips = [
  {
    name        = "data-ext-nat-ip-1"
    description = "permanent nat external ip"
    region      = "us-east1"
  },
]

ip_cidr_range = "10.8.3.0/28"
private_service_connection_address = "10.8.4.0"
connector_name = "serverless-vpc-connector"


# Firewall rules 

vpc_name                      = "smt-the-dev-test-a1b2-vpc"

ssh_ingress_ranges            = ["35.235.240.0/20"]
ssh_ingress_protocol          = "tcp"
ssh_ingress_ports             = ["22"]

openvpn_egress_ranges         = ["10.8.0.0/16"]
openvpn_egress_protocol       = "all"
openvpn_egress_ports          = []


function_name   = "hello-world"
source_archive  = "../hello-world.zip"
