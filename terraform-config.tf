# I add this file to organize more the terraform code
# it will contains all infos about providers, terrform version 
# some details here are copied from last challenge and others will be added

# The aws region that you choose for your deployment
provider "aws" {
  region = "us-east-1"
}



terraform {
  // Ensures that everyone is using a specific Terraform version
  required_version = ">= 0.14.9"

  // In challange1, we used a local terraform state. In this challage, we have to define a remote terraform backend as we use github actions to run terraform code
  // Github actions uses a runner for each job and different runner each time so the local state in this case will be lost after each workflow execution 
  // So, to have always the state of the resources deployed on aws, the state should be stored remotly. In our case, it is an S3 bucket where Terraform stores its state to keep track of the resources it manages
  // You can also enable state locking by using a DynamoDB table so changes at the same time will not be accepted - I don't add this as we don't have many contributers in the project
  // The dynamoDB table Key Schema Attribute name should be LockID.
  backend "s3" {
    bucket         = "terrform-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}
