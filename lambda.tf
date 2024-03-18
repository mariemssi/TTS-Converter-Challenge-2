provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "texttospeech" {
  function_name = "texttospeech"

  # The bucket name 
  s3_bucket = "lambdacode17032024"
  s3_key    = "lambdacode.zip"

  # "main" is the filename within the zip file (main.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  handler = "lambda.lambda_handler"
  runtime = "python3.8"

  # each lambda function must have an IAM role
  role = aws_iam_role.lambda_exec.arn

  # if you want to specify the retention period of the logs you need this
  #depends_on = [aws_cloudwatch_log_group.LambdaLogGroup]

}

resource "aws_cloudwatch_log_group" "LambdaLogGroup" {
  name = "/aws/lambda/${aws_lambda_function.texttospeech.function_name}"

  retention_in_days = 30
}

