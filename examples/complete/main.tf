locals {
  arn_prefix             = format("%s:aws", "arn")
  ci_plan_account_id     = format("%012d", 0)
  ci_plan_kms_key_id     = format("%08x-%04x-%04x-%04x-%012x", 0, 0, 0, 0, 0)
  kms_key_id             = coalesce(var.kms_key_id, "${local.arn_prefix}:kms:us-east-1:${local.ci_plan_account_id}:key/${local.ci_plan_kms_key_id}")
  data_identifier_prefix = "${local.arn_prefix}:dataprotection::aws:data-identifier"
  email_data_identifier  = "${local.data_identifier_prefix}/EmailAddress"
}

module "tf_aws_cloudwatch_log_group" {
  source = "../../"

  name              = "/platform/dev/eks/midh/addons"
  kms_key_id        = local.kms_key_id
  retention_in_days = 365
  skip_destroy      = true
  log_group_class   = "STANDARD"

  data_protection_policy_json = jsonencode({
    Name    = "audit-sensitive-data"
    Version = "2021-06-01"
    Statement = [
      {
        Sid            = "audit"
        DataIdentifier = [local.email_data_identifier]
        Operation = {
          Audit = {
            FindingsDestination = {}
          }
        }
      }
    ]
  })

  metric_filters = {
    error-events = {
      pattern          = "?ERROR ?Error ?error"
      metric_name      = "ErrorEvents"
      metric_namespace = "Platform/EKS"
      metric_value     = "1"
    }
  }

  tags = {
    Environment        = "dev"
    Owner              = "platform-team"
    CostCenter         = "shared-services"
    DataClassification = "internal"
    Application        = "midh-eks"
  }
}
