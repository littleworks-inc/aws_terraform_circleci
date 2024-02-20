# variable "AWS_ACCESS_KEY_ID" {}
# variable "AWS_SECRET_ACCESS_KEY" {}
# variable "AWS_DEFAULT_REGION" {}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
  }
  backend "s3" {

  }
}

provider "aws" {
  # Configuration options
  region     = var.region
}