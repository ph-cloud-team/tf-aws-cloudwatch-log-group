output "log_group_name" {
  description = "CloudWatch log group name."
  value       = module.tf_aws_cloudwatch_log_group.log_group_name
}

output "log_group_arn" {
  description = "CloudWatch log group ARN."
  value       = module.tf_aws_cloudwatch_log_group.log_group_arn
}

output "retention_in_days" {
  description = "Configured retention in days."
  value       = module.tf_aws_cloudwatch_log_group.retention_in_days
}

output "metric_filter_names" {
  description = "Metric filters created by the module."
  value       = module.tf_aws_cloudwatch_log_group.metric_filter_names
}
