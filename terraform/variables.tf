variable "region" {
  description = "AWS region for the S3 bucket (same region you used in aws configure)"
  type        = string
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name (different from the manually created one)"
  type        = string
}
