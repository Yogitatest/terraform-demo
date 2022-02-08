terraform {
  required_version = ">= 0.14.7"
  required_providers {
      aws = { 
        source = "hashicorp/aws" 
        version = "3.30.0"
      }
  }
  
  backend "s3" {
    bucket               = "terraform-remote-states"
    key                  = "tf-workspaces/terraform.tfstate"
    region               = "eu-west-1"
  }
}
