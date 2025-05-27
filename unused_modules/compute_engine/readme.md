# compute_engine

## Summary

This module allows the user to create compute engine machine

--- 



## Example usage

```

module "vm" {
    source = "./terraform-modules/compute_engine"
    project_id = "zazmic-observability-lower-002"
    instance_name = "test-vm"
    machine_type = "e2-micro"
    zone = "us-central1-b"
    compute_image_id = "debian-cloud/debian-11"
    disk_size = 10
    subnet = "shared-subnet-zazmic-sub-us-central1-lower-private"
    subnetwork_project = "zazmic-cloudops-transit-002"
    sa = "test-vm-sa"
    roles_list = ["roles/container.clusterAdmin","roles/container.admin"]
}


```


## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| project_id | project id. | `string` | n/a |
| instance_name | instance name | `string` | n/a | 
| machine_type | machine type | `string` | n/a | 
| zone | zone | `string` | n/a |
| compute_image_id | compute image  | `string` | n/a | 
| disk_size | disk size | `string` | n/a | 
| subnet | network subnet | `string` | n/a |
| subnetwork_project | project where the subnet is located | `string` | n/a | 
| sa | service account name | `string` | n/a | 
| network_tags | network tags | `list(string)` | `[]` |
| total_local_ssd_disks | total local ssd nvme disks number | `number` | `0` | 
| machine_type | machine type | `string` | n/a | 
| create_boot_disk | create boot disk option | `bool` | `false` |
| create_data_disk | create data disk option | `bool` | `false` | 
| data_disk_require | data disk require option | `bool` | `false` |
| enable_secure_boot | enable secure boot option | `bool` | `false` | 
| enable_integrity_monitoring | enable integrity monitoring option | `bool` | `false` |
| deletion_protection | deletion protection option | `bool` | `false` | 
| enable_vtpm | enable vtpm option | `bool` | `false` |
| metadata | metadata options | `map` | `{ enable-oslogin = "TRUE" }` | 
| roles_list | roles list | `list(string)` | `[]` | 




## Outputs

| Name | Description |
|------|-------------|
| compute_instance | Compute instance resources |
| ip | IP address of the compute instance |
