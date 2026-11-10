terraform {
  backend "s3" {
    bucket       = "backend-terraform-state-2026-unique"
    key          = "prod/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
