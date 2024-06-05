resource "aws_s3_bucket" "terraform_state" {
  bucket = "be-terraform-state-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name = "be-terraform-state"
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "be-terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "be-terraform-lock-table"
  }
}
