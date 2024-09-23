terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.64.0"
    }
  }


backend "s3" {
    bucket = "roboshop-remote-state2"
    key = "user"
    region = "us-east-1"
    dynamodb_table = "roboshop-lock"
}

}

provider "aws" {
  # Configuration options



  region = "us-east-1"
}