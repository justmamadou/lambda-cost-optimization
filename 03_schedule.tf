resource "aws_cloudwatch_event_rule" "stop" {
  name = "schedule-stop-instances"
  description = "Schedule stop instances"
  schedule_expression = "cron(0 20 * * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "stop" {
  target_id = "stop-instances"
  rule = aws_cloudwatch_event_rule.stop.name
  arn = aws_lambda_function.stop.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop.arn
}