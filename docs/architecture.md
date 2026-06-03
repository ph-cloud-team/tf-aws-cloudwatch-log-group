# Architecture

This module wraps `aws_cloudwatch_log_group` with the platform baseline for encryption, retention, and tagging.

## Resource Model

- `aws_cloudwatch_log_group.this` creates one log group.
- `aws_cloudwatch_log_subscription_filter.this` optionally sends logs to a central destination.
- `aws_cloudwatch_log_metric_filter.this` optionally extracts metrics from log events.
- The log group is encrypted using a customer-managed KMS key.
- Retention is explicitly configured and constrained to approved AWS-supported values of 365 days or more.

## Dependency Flow

Use the KMS key module first, then pass the key ARN to this module:

```hcl
kms_key_id = module.logs_kms_key.key_arn
```

Higher-level modules, such as EKS cluster or add-on modules, should accept log group names or ARNs rather than creating unencrypted log groups internally.
