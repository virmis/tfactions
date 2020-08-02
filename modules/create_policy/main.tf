resource "aws_iam_role" "lambda_role" {
  name = "test_lambda_role"

  assume_role_policy = <<-EOF
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

  tags          = {
    Name        = "Test Staging Lambda1"
    Environment = "stage"
  }
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

resource "aws_iam_role_policy" "lambda_basic_execution_role" {
  count = var.attach_policy_lambda_basic_execution_role ? 1 : 0
  name  = "lambda_basic_execution_role"
  role  = aws_iam_role.lambda_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:eu-central-1:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:eu-central-1:*:*:/aws/lambda/quota_limit:*"
            ]
        }
    ]
  }
  EOF
}

