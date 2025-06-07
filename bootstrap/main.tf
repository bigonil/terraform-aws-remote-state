provider "aws" {
  region = "us-west-2"
}

# Create S3 bucket
resource "aws_s3_bucket" "tf_state" {
  bucket = "tf-remote-state-8g2xj9g3"

  tags = {
    Name = "Terraform Remote State Bucket"
  }
}

# Enable versioning on the bucket
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Configure public access block
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.tf_state.id

  block_public_acls       = true
  block_public_policy     = false  # 👈 required to allow a bucket policy
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Attach a basic policy to allow access
resource "aws_s3_bucket_policy" "tf_state_policy" {
  bucket = aws_s3_bucket.tf_state.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::631737274131:user/lb-aws-admin"
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${aws_s3_bucket.tf_state.arn}/*",
          aws_s3_bucket.tf_state.arn
        ]
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.block]
}