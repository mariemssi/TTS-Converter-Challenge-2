
# S3 bucket names must be unique, we can use a random pet generator to append it to the bucket name.
/* resource "random_pet" "lambda_bucket_name" {
  prefix = "lambdacode"
  length = 2
}
 */
#create the S3 bucket itself with the generated name
/* resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = random_pet.lambda_bucket_name.id
  force_destroy = true
} */
# "archive file" Generates an archive from content, a file, or directory of files.
/* data "archive_file" "lambda_code" {
  type = "zip"
  # Lambda code is in the 'lambdacode' subdirectory
  source_dir  = "./lambdacode"
  output_path = "${path.module}/lambdacode.zip"
}
*/
/* resource "aws_s3_object" "lambda_zipped_code" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "lambdacode.zip" //Destination file name
  source = "lambdacode.zip" //Source file name

} */

data "aws_s3_bucket_object" "lambda_zip" {
  bucket = "lambdacode17032024"
  key    = "artifacts/lambda/lambdacode.zip"
}

resource "aws_lambda_function" "texttospeech" {
  function_name = "texttospeech"

  # The lambda  function needs the code in zipped file in an S3 bucket 
  # The S3 bucket is created here manually and the zip file is uploaded manually. You should change this with your own details
  # This will automated in the next hands-on

  /* s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = "lambdacode.zip" */

  #s3_bucket        = "lambdacode17032024"
  #s3_key           = "lambda/lambdacode.zip"
  #source_code_hash = filebase64("lambda/lambdacode.zip")
  #Change source_code_hash by versions in S3 and use version to detect lambda changes
  # "lambda" is the filename within the zip file and "lambda_handler"
  # is the name of the function handler

  s3_bucket         = data.aws_s3_bucket_object.lambda_zip.bucket
  s3_key            = data.aws_s3_bucket_object.lambda_zip.key
  s3_object_version = data.aws_s3_bucket_object.lambda_zip.version_id


  handler = "lambda.lambda_handler"
  runtime = "python3.8"

  # Each lambda function must have an IAM role
  # The lambda function must have permissions to communicate with polly in order to translate the received text on MP3 File
  # and permissions to send logs to cloudwatch logs
  role = aws_iam_role.lambda_exec.arn

}

# Cloudwatch_log_group will contain all lambda invocation logs
# It let you understand the behavior of your function and resolve issues
resource "aws_cloudwatch_log_group" "LambdaLogGroup" {
  name = "/aws/lambda/${aws_lambda_function.texttospeech.function_name}"

  retention_in_days = 30
}

# test the trigger of lambda pipeline
