# Security

CloudWatch Logs often contain operational metadata, workload errors, request context, and sometimes sensitive troubleshooting data. This module enforces the baseline needed for regulated platform use.

## Controls

- Customer-managed KMS encryption is required.
- Indefinite retention is not allowed.
- Retention must be at least 365 days.
- Required tags identify owner, environment, cost center, and data classification.
- Optional data protection policies can audit sensitive data patterns in logs.
- Subscription filters can route logs into a centralized security or observability destination.

## Recommendations

- Use a KMS key policy that allows CloudWatch Logs in the target region to use the key.
- Use longer retention for audit or control plane logs when regulatory retention requires it.
- Use `skip_destroy = true` for production or audit-sensitive log groups.
- Do not store secrets in application logs; encryption is a control, not a substitute for log hygiene.
- Review subscription destinations carefully because they receive copies of log events.
