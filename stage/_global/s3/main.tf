terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-state-tfactions-stage"
    region = "eu-central-1"
    key = "_global/s3"
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = "terraform-state-tfactions-stage"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags   =  {
    Name = "Terraform Remote State"
    Env  = "Stage"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform-state-storage-s3" {
  bucket = aws_s3_bucket.terraform-state-storage-s3.id

  block_public_acls   = true
  block_public_policy = true
}
