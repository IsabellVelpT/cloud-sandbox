terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region                      = "eu-central-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    s3 = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "sandbox" {
  bucket = "cloud-computing-sandbox"
}

resource "aws_s3_object" "testdatei" {
  bucket = aws_s3_bucket.sandbox.id
  key    = "testdatei.txt"
  source = "${path.module}/testdatei.txt"
  etag   = filemd5("${path.module}/testdatei.txt")
}