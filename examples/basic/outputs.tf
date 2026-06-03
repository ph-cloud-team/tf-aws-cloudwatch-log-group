output "log_group_name" {
  description = "CloudWatch log group name."
  value       = module.tf_aws_cloudwatch_log_group.log_group_name
}

output "log_group_arn" {
  description = "CloudWatch log group ARN."
  value       = module.tf_aws_cloudwatch_log_group.log_group_arn
}
