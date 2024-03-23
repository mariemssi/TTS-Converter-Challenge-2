//S3 for the terraform remote backend
//S3 bucket name must be unique globally so you should change the name if you get an error when executing the code
//

/* resource "aws_s3_bucket" "terraform_state" {
  bucket = "terrform-state-bucket-23032024"

  lifecycle {
    prevent_destroy = true
  }
}

//enable versioning to prevent accidental data loss
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
 */