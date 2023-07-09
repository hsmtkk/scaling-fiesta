terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      project = var.project
    }
  }
  region = "ap-northeast-1"
}