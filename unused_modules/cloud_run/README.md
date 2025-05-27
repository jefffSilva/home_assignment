# Cloud Run Module

Cloud Run management, with support for Loadbalancer,VPC-Connector,IAM roles, and revision annotations 

### Cloud Run service with Load Balancer and serverless NEG

A load balancer is created if the external_ip variable is given a value 

```tf
module "cloud_run_service" {
  source                = "git::https://github.com/example-org/templates.git//cloud_run?ref=cloud_run_v1.0.2"
  name                  = "cloud_run"
  service_name          = "my-cloud-run-service"
  location              = "us-central1"
  region                = "us-central1"
  ports = [
    {
      name = "http1"
      port = 8080
    }
  ]
  ssl_certs_list        = ["ssl-cert-name"]
  ssl_policy            = "strict-ssl-policy"
  external_ip           = "34.120.82.111"
  cloudrun_lb_policy    = module.cloudrun_security_policy.security_policy_name
  service_account_email = "cloudrun@example-project.iam.gserviceaccount.com"
  image                 = "us-central1-docker.pkg.dev/example-project/repo/cloud-run-app"
  service_labels = {
    team = "engineering"
  }
}
```

### Cloud Run service with Serverless VPC Connector
```tf
module "cloud_run_service_vpc" {
  source                = "./modules/cloud_run"
  name                  = "cloud_run_vpc"
  service_name          = "my-cloud-run-service"
  location              = "us-central1"
  region                = "us-central1"
  ports = [
    {
      name = "http1"
      port = 8080
    }
  ]
  ssl_certs_list        = ["ssl-cert-name"]
  external_ip           = "34.120.82.121"
  connector_name        = "serverless-vpc-connector"
  ip_cidr_range         = "10.100.1.0/28"
  network_name          = module.network.vpc_network.name
  service_account_email = "cloudrun@example-project.iam.gserviceaccount.com"
  image                 = "us-central1-docker.pkg.dev/example-project/repo/cloud-run-app"
}



```

### Startup Probe

```tf
module "cloud_run_service_startup_probe" {
  source                = "git::https://github.com/example-org/terraform-modules.git//cloud_run?ref=cloud_run_v1.0.2"
  name                  = "cloud_run_startup"
  service_name          = "my-cloud-run-service"
  location              = "us-central1"
  region                = "us-central1"
  ports = [
    {
      name = "http1"
      port = 8080
    }
  ]
  ssl_certs_list        = ["ssl-cert-name"]
  external_ip           = "34.120.82.131"
  connector_name        = "serverless-vpc-connector"
  ip_cidr_range         = "10.100.1.0/28"
  network_name          = module.network.vpc_network.name
  service_account_email = "cloudrun@example-project.iam.gserviceaccount.com"
  image                 = "us-central1-docker.pkg.dev/example-project/repo/cloud-run-app"
  service_labels = {
    team = "engineering"
  }

  # Startup Probe Configuration
  startup_probe_enabled    = true
  failure_threshold        = 1
  initial_delay_seconds    = 0
  period_seconds           = 240
  probe_timeout_seconds    = 240
  startup_probe_port       = 8080
}
```



### Environment Variables

```tf
module "cloud_run_service_env_vars" {
  source                = "git::https://github.com/example-org/terraform-modules.git//cloud_run?ref=cloud_run_v1.0.2"
  name                  = "cloud_run_env"
  service_name          = "my-cloud-run-service"
  location              = "us-central1"
  region                = "us-central1"
  ports = [
    {
      name = "http1"
      port = 8080
    }
  ]
  ssl_certs_list        = ["ssl-cert-name"]
  external_ip           = "34.120.82.141"
  connector_name        = "serverless-vpc-connector"
  ip_cidr_range         = "10.100.1.0/28"
  network_name          = module.network.vpc_network.name
  service_account_email = "cloudrun@example-project.iam.gserviceaccount.com"
  image                 = "us-central1-docker.pkg.dev/example-project/repo/cloud-run-app"
  service_labels = {
    team = "engineering"
  }

  env_vars = [
    { name = "DATABASE_HOST", value = "192.168.1.10" },
    { name = "DATABASE_PORT", value = "5432" },
    { name = "DATABASE_USER", value = "appuser" },
    { name = "DATABASE_NAME", value = "appdb" },
    { name = "ENABLE_LOGGING", value = "true" },
    { name = "GCP_BUCKET_NAME", value = "example-bucket" },
    { name = "GCP_PROJECT", value = "example-project" },
    { name = "GCP_DATASET", value = "example-dataset" }
  ]
}
```

## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [service_name](variables.tf#L15) | Name used for cloud run service. | <code>string</code> | ✓ |  |
| [project_id](variables.tf#L11) | Project id used for all resources. | <code>string</code> | ✓ |  |
| [ports](variables.tf#L196) | Port which the container listens to (http1 or h2c). | <code title="object&#40;&#123;&#10;  audit_log &#61; optional&#40;map&#40;object&#40;&#123;&#10;    method  &#61; string&#10;    service &#61; string&#10;  &#125;&#41;&#41;, &#123;&#125;&#41;&#10;  pubsub &#61; optional&#40;map&#40;string&#41;, &#123;&#125;&#41;&#10;&#125;&#41;">object&#40;&#123;&#8230;&#125;&#41;</code> |  | <code>&#123;&#125;</code> |
| [service_labels](variables.tf#L115) | Resource labels. | <code>map&#40;string&#41;</code> |  | <code>&#123;&#125;</code> |
| [region](variables.tf#L57) | Region used for all resources. | <code>string</code> |  | <code>&#34;europe-west1&#34;</code> |
| [ssl_policy](variables.tf#L47) | Region used for all resources. | <code>string</code> |  | <code>&#34;tls &#34;</code> |
| [timeout_seconds](variables.tf#L180) | Maximum duration the instance is allowed for responding to a request. | <code>number</code> |  | <code>null</code> |
| [volumes](variables.tf#L142) | Named volumes in containers in name => attributes format. | <code title="map&#40;object&#40;&#123;&#10;  secret_name  &#61; string&#10;  default_mode &#61; optional&#40;string&#41;&#10;  items &#61; optional&#40;map&#40;object&#40;&#123;&#10;    path &#61; string&#10;    mode &#61; optional&#40;string&#41;&#10;  &#125;&#41;&#41;&#41;&#10;&#125;&#41;&#41;">map&#40;object&#40;&#123;&#8230;&#125;&#41;&#41;</code> |  | <code>&#123;&#125;</code> |



## Outputs

| name | description | sensitive |
|---|---|:---:|
| [service](outputs.tf#L1) | Cloud Run service. |  |
| [revision](outputs.tf#L6) | Deployed revision for the service. |  |
| [service_url](outputs.tf#L11) | The URL on which the deployed service is available. |  |
| [project_id](outputs.tf#L16) | Google Cloud project in which the service was created. |  |
| [location](outputs.tf#L21) | Location in which the Cloud Run service was created. |  |
| [service_id](outputs.tf#L26) | Unique Identifier for the created service. |  |
| [service_status](outputs.tf#L31) | Status of the created service. |  |
| [backend_services](outputs.tf#L37) | The backend service resources. |  |

<!-- END TFDOC -->