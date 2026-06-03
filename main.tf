resource "aws_cloudwatch_log_group" "this" {
  name              = var.name
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id
  skip_destroy      = var.skip_destroy
  log_group_class   = var.log_group_class

  tags = merge(
    local.common_tags,
    {
      Name = local.name_tag
    }
  )
}

resource "aws_cloudwatch_log_data_protection_policy" "this" {
  count = var.data_protection_policy_json == null ? 0 : 1

  log_group_name  = aws_cloudwatch_log_group.this.name
  policy_document = var.data_protection_policy_json
}

resource "aws_cloudwatch_log_subscription_filter" "this" {
  for_each = var.subscription_filters

  name            = each.key
  log_group_name  = aws_cloudwatch_log_group.this.name
  destination_arn = each.value.destination_arn
  filter_pattern  = each.value.filter_pattern
  role_arn        = each.value.role_arn
  distribution    = each.value.distribution
}

resource "aws_cloudwatch_log_metric_filter" "this" {
  for_each = var.metric_filters

  name           = each.key
  log_group_name = aws_cloudwatch_log_group.this.name
  pattern        = each.value.pattern

  metric_transformation {
    name          = each.value.metric_name
    namespace     = each.value.metric_namespace
    value         = each.value.metric_value
    default_value = each.value.default_value
    unit          = each.value.unit
    dimensions    = each.value.dimensions
  }
}
