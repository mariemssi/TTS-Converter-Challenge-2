# IAM role which dictates what other AWS services the Lambda function may access. 
# In our case, lambda access CloudWatch_log_group to write logs and Polly to tranlate text

resource "aws_iam_role" "lambda_exec" {
  name = "texttospeech_lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# with terraform we can't attach directly more than one managed permission to a role
# so we need to create an IAM policy with the needed permissions and attach it to the created IAM role
# In real cases, the permissions should be more restrictive!
resource "aws_iam_policy" "iam_policy_for_lambda" {

  name        = "aws_iam_policy_for_terraform_aws_lambda_role"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"
  policy      = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   },
   {
      "Effect": "Allow",
      "Action": "polly:*",
      "Resource": "*"
    }
]
}
EOF
}

#Attach the role to the policy
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

