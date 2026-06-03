# tf-aws-cloudwatch-log-group

Enterprise Terraform module for CloudWatch Log Groups with customer-managed KMS encryption, explicit retention, and required platform tags.

This module is used by EKS control plane logging, add-on logs, platform automation logs, VPC flow logs, and application components that need a standardized log group contract.

## What This Module Creates

- CloudWatch Log Group.
- Customer-managed KMS encryption.
- Retention period of at least 365 days.
- Optional destroy protection through `skip_destroy`.
- Optional log group class selection.
- Optional data protection policy.
- Optional subscription filters for centralized log routing.
- Optional metric filters for operational signal extraction.
- Enterprise tags.

## Basic Usage

```hcl
module "eks_control_plane_logs" {
  source = "git::http://gitlab.midhtech.local/cloud_team/tf-modules/aws/observability/tf-aws-cloudwatch-log-group.git?ref=v1.0.0"

  name              = "/aws/eks/dev-midh/control-plane"
  kms_key_id        = module.logs_kms_key.key_arn
  retention_in_days = 365

  tags = local.tags
}
```

## Inputs

| Name | Description | Type | Required |
| --- | --- | --- | --- |
| `name` | CloudWatch log group name. | `string` | yes |
| `kms_key_id` | Customer-managed KMS key ARN or ID. | `string` | yes |
| `retention_in_days` | Retention period, minimum 365 days. | `number` | no |
| `skip_destroy` | Keep log group during Terraform destroy. | `bool` | no |
| `log_group_class` | CloudWatch log group class. | `string` | no |
| `data_protection_policy_json` | CloudWatch Logs data protection policy JSON. | `string` | no |
| `subscription_filters` | Subscription filters for central log routing. | `map(object)` | no |
| `metric_filters` | Metric filters to extract metrics from logs. | `map(object)` | no |
| `tags` | Enterprise tags. | `map(string)` | yes |

## Outputs

| Name | Description |
| --- | --- |
| `log_group_name` | CloudWatch log group name. |
| `log_group_arn` | CloudWatch log group ARN. |
| `kms_key_id` | Encryption key ID. |
| `retention_in_days` | Configured retention period. |
| `subscription_filter_names` | Subscription filters created by the module. |
| `metric_filter_names` | Metric filters created by the module. |

## Policy Alignment

The module is designed to pass central CloudWatch policies:

- log groups must define `kms_key_id`;
- log groups must define retention;
- retention must be at least 365 days.

## Documentation

- [Architecture](docs/architecture.md)
- [Security](docs/security.md)
- [Usage](docs/usage.md)
