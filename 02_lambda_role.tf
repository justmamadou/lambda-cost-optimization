#--------------- Lambda Role ------
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

#-------------- Lambda Policy --------
data "aws_iam_policy_document" "lambda" {
  statement {
    sid = "1"
    actions = [ 
        "ec2:DescribeInstances",
        "ec2:StartInstances",
        "ec2:StopInstances"
    ]
    resources = [ "*" ]
  }
}

resource "aws_iam_policy" "lambda" {
  name = "StopStartInstances"
  description = "Policy for the lambda function to stop and start instances"
  path = "/"
  policy = data.aws_iam_policy_document.lambda.json
}

# Attach policy to lamba role
resource "aws_iam_policy_attachment" "custom" {
  name = "StartStopInstances"
  policy_arn = aws_iam_policy.lambda.arn
  roles = [ aws_iam_role.role.name ]
}

resource "aws_iam_policy_attachment" "basic" {
    name = "StartStopInstances"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    
    roles = [ aws_iam_role.role.name ]

}