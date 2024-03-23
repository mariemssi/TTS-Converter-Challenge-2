
resource "aws_lambda_function" "texttospeech" {
  function_name = "texttospeech"

  # The lambda  function needs the code in zipped file in an S3 bucket 
  # The S3 bucket is created here manually and the zip file is uploaded manually. You should change this with your own details
  # This will automated in the next hands-on
  s3_bucket = "lambdacode17032024"
  s3_key    = "lambdacode.zip"

  # "lambda" is the filename within the zip file and "lambda_handler"
  # is the name of the function handler
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

