# Retrieves information about the Lambda function zip file stored in an S3 bucket
data "aws_s3_object" "lambda_zip" {
  bucket = "lambdacode17032024"
  key    = "artifacts/lambda/lambdacode.zip"
}

# Creates a Lambda function using the code stored in the specified S3 bucket object
# The S3 bucket should have versioning enabled as the version ID changes for each code change upload is used to trigger infrastructure redeployment 
resource "aws_lambda_function" "texttospeech" {
  function_name = "texttospeech"

  s3_bucket         = data.aws_s3_object.lambda_zip.bucket
  s3_key            = data.aws_s3_object.lambda_zip.key
  s3_object_version = data.aws_s3_object.lambda_zip.version_id

  handler = "lambda.lambda_handler"
  runtime = "python3.8"

  # Specifies the IAM role for the Lambda function
  role = aws_iam_role.lambda_exec.arn

}

# Creates a CloudWatch log group to store logs generated by the Lambda function
resource "aws_cloudwatch_log_group" "LambdaLogGroup" {
  name = "/aws/lambda/${aws_lambda_function.texttospeech.function_name}"

  retention_in_days = 30
}


