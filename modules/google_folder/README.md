## Usage

Basic usage of this module is as follows:

```hcl
module "folders" {
  source  = "terraform-modules/google_folder"
  
  parent  = "folders/65552901371" or "organizations/65552901371"

  names = [
    "dev",
    "staging",
    "production",
  ]

  prefix = "client1"
}

```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| names | Folder names. | `list(string)` | `[]` | no |
| parent | The resource name of the parent Folder or Organization. Must be of the form folders/folder\_id or organizations/org\_id | `string` | n/a | yes |
| prefix | Optional prefix to enforce uniqueness of folder names. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| folder | Folder resource (for single use). |
| folders | Folder resources as list. |
| folders\_map | Folder resources by name. |
| id | Folder id (for single use). |
| ids | Folder ids. |
| ids\_list | List of folder ids. |
| name | Folder name (for single use). |
| names | Folder names. |
| names\_list | List of folder names. |
