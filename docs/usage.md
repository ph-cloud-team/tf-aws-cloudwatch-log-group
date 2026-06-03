# Usage

## EKS Control Plane Logs

```hcl
module "eks_control_plane_logs" {
  source = "git::http://gitlab.midhtech.local/cloud_team/tf-modules/aws/observability/tf-aws-cloudwatch-log-group.git?ref=v1.0.0"

  name              = "/aws/eks/dev-midh/control-plane"
  kms_key_id        = module.logs_kms_key.key_arn
  retention_in_days = 365

  tags = local.tags
}
```

## Retained Platform Logs

```hcl
module "platform_addon_logs" {
  source = "git::http://gitlab.midhtech.local/cloud_team/tf-modules/aws/observability/tf-aws-cloudwatch-log-group.git?ref=v1.0.0"

  name              = "/platform/dev/eks/midh/addons"
  kms_key_id        = module.logs_kms_key.key_arn
  retention_in_days = 365
  skip_destroy      = true

  tags = local.tags
}
```

Use this module before EKS or workload modules that need a pre-created log destination.
