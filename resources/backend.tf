terraform {
  backend "local" {
    path = "terraform-resources.tfstate"
  }
}