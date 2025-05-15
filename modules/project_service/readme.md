# project_service

## Summary

This module allows the user to enable project services, api's, and/or create service identities

--- 



## Example usage

```

module "project" {
  source = "./terraform-modules/project_service"
  project_name            = "sandbox-0001-544324"
  project_id      = "sandbox-0001-544324"
  folder_id       = "442442032619"
  billing_account = "AABBCC-DDEEFG-GGJKIO"
}

```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| project_id | project id. | `string` | n/a |
| project_name | project name. | `string` | n/a |
| org_id | organisation | `string` | `null` |
| folder_id | folder id | `string` | `""` |
| billing_account | billing account | `string` | `null` |
| service_identity_list | service identity list | `list(string)` | `[]` |
| service_list | service list | `list(string)` | <pre> ["iam.googleapis.com" <br> "compute.googleapis.com"  <br> "cloudresourcemanager.googleapis.com" <br> "container.googleapis.com" <br> "secretmanager.googleapis.com" <br> "servicenetworking.googleapis.com"] </pre> |


## Outputs

| Name | Description |
|------|-------------|
| enabled_services | List of enabled service APIs |
| service_identities | Map of enabled service identities |
| project_id | Project where services were enabled |

