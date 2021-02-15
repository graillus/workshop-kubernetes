terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.0.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }
  # Comment this if you do not want to use s3 as tfstate backend
  backend "s3" {
    bucket = "elvlabs-terraform-state"
    key    = "eleven-labo/terraform.tfstate"
    profile = "elvlabs"
    region = "eu-west-3"
  }
  required_version = "~> 0.14"
}

provider "aws" {
  #profile = "elvlabs"
  region = "eu-west-3"
}
