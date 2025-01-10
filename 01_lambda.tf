data "archive_file" "lambda" {
  type = "zip"
  source_dir = "${path.module}/code"
  output_path = "${path.module}/lambda.zip"
}

#------------------- Stop Instances -----------------------
resource "aws_lambda_function" "stop" {
  function_name = "stop-instances"
  role = aws_iam_role.role.arn
  runtime = "python3.11"
  handler = "main.lambda_handler"
  memory_size = 128
  timeout = 60
  filename = data.archive_file.lambda.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda.output_path)

  environment {
    variables = {
      "ACTION": "stop"
    }
  }
  
}

#----------------- Start Instances -----------------
resource "aws_lambda_function" "start" {
  function_name = "start-instances"
  role = aws_iam_role.role.arn
  runtime = "python3.11"
  handler = "main.lambda_handler"
  memory_size = 128
  timeout = 60
  filename = data.archive_file.lambda.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda.output_path)

  environment {
    variables = {
      "ACTION": "start"
    }
  }
  
}