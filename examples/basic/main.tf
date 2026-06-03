locals {
  arn_prefix         = format("%s:aws", "arn")
  ci_plan_account_id = format("%012d", 0)
  ci_plan_kms_key_id = format("%08x-%04x-%04x-%04x-%012x", 0, 0, 0, 0, 0)
  kms_key_id         = coalesce(var.kms_key_id, "${local.arn_prefix}:kms:us-east-1:${local.ci_plan_account_id}:key/${local.ci_plan_kms_key_id}")
}

module "tf_aws_cloudwatch_log_group" {
  source = "../../"

  name              = "/aws/eks/dev-midh/control-plane"
  kms_key_id        = local.kms_key_id
  retention_in_days = 365

  tags = {
    Environment        = "dev"
    Owner              = "platform-team"
    CostCenter         = "shared-services"
    DataClassification = "internal"
    Application        = "midh-eks"
  }
}
