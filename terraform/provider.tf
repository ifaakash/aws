terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}

# TODO: Test this with a different profile( ~/.aws/config & /.aws/crendentials )
provider "aws" {
  region  = "us-east-2"
  profile = "default"
}
