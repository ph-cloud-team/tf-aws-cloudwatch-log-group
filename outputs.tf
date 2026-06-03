output "module_name" {
  description = "Name of the Terraform module."
  value       = local.module_name
}

output "log_group_name" {
  description = "CloudWatch log group name."
  value       = aws_cloudwatch_log_group.this.name
}

output "log_group_arn" {
  description = "CloudWatch log group ARN."
  value       = aws_cloudwatch_log_group.this.arn
}

output "kms_key_id" {
  description = "KMS key used for log group encryption."
  value       = aws_cloudwatch_log_group.this.kms_key_id
}

output "retention_in_days" {
  description = "Configured retention in days."
  value       = aws_cloudwatch_log_group.this.retention_in_days
}

output "log_group_class" {
  description = "CloudWatch log group class."
  value       = aws_cloudwatch_log_group.this.log_group_class
}

output "subscription_filter_names" {
  description = "CloudWatch Logs subscription filter names created by this module."
  value       = keys(aws_cloudwatch_log_subscription_filter.this)
}

output "metric_filter_names" {
  description = "CloudWatch Logs metric filter names created by this module."
  value       = keys(aws_cloudwatch_log_metric_filter.this)
}
