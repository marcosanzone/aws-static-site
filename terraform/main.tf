terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"   # metti la stessa regione che hai usato in aws configure
}

resource "aws_s3_bucket" "test" {
  bucket = "marcosanzone-tf-test-2026"   # nome globalmente unico, diverso dal bucket del sito
}

resource "aws_s3_bucket_public_access_block" "test" {
  bucket                  = aws_s3_bucket.test.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
