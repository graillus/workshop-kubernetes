terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28"
    }
  }
}

provider "aws" {
  profile = "elvlabs"
  region = "eu-west-3"
}
