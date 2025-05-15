# ☁️ Google Cloud Function with Load Balancer (Terraform)

This project demonstrates how to deploy a **Python Cloud Function (2nd Gen)** on Google Cloud using **Terraform**, expose it via an **HTTP Load Balancer**, and manage infrastructure using **Terraform Workspaces**.

---

## 📁 Project Structure

```
HOME_ASSIGNMENT/
├── foundation
    └── main.tf                         # With project creating and folders 
    ├── variables.tf                    # Variables
    ├── terraform.tfvars                # Environment-specific variables for the project creation
├── modules/
│   └── cloud_function/            # Reusable Cloud Function module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│   ....
│   ...
│   ..
├── hello-world.zip                # Zipped Cloud Function source
├── main.py                        # Python helloWorld function
└── README.md                      # This file
```

---

## 🧠 Cloud Function Code

### `main.py`
```python
def helloWorld(request):
    if request.path != "/helloWorld":
        return ("Not Found", 404)
    return ("Hello, World from Cloud Functions!", 200)
```

Responds only to the `/helloWorld` path. Any other route returns 404.

---

## 🔧 Packaging the Function

```bash
zip -r hello-world.zip main.py requirements.txt
```

---

## 🔐 1. Authenticate with Google Cloud

```bash
gcloud auth application-default login
```

---

## 🧱 2. Initialize Terraform Workspace

```bash
terraform workspace new dev
terraform workspace select dev
```

---

## 📂 3. Deploy Foundation Infrastructure

This step creates:
- GCP Project
- Folder (if needed)

```bash
cd HOME_ASSIGNMENT/foundation

terraform init
terraform plan
terraform apply
```

---

## 🌐 4. Deploy VPC, Load Balancer, and Cloud Function

```bash
cd HOME_ASSIGNMENT/resource

terraform init
terraform plan -var-file=../resources/env/dev.tfvars
terraform apply -var-file=../resources/env/dev.tfvars
```

---

## 📦 `terraform.tfvars` Example

```hcl
project_id     = "your-gcp-project-id"
region         = "us-central1"
function_name  = "hello-world"
source_archive = "path/to/hello-world.zip"
```

---

## ✅ Outputs

- Public URL via Load Balancer
- Function Name and Region from module outputs

---

## 📚 References

- [Cloud Functions 2nd Gen](https://cloud.google.com/functions/docs/concepts/exec)
- [Terraform Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Terraform Workspaces](https://developer.hashicorp.com/terraform/docs/language/state/workspaces)
- [gcloud auth login](https://cloud.google.com/sdk/gcloud/reference/auth/application-default/login)
