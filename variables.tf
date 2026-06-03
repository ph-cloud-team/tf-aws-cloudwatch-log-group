variable "name" {
  description = "CloudWatch log group name."
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 512
    error_message = "name must be between 1 and 512 characters."
  }
}

variable "kms_key_id" {
  description = "Customer-managed KMS key ARN or ID for log group encryption."
  type        = string

  validation {
    condition     = length(var.kms_key_id) > 0
    error_message = "kms_key_id is required by platform CloudWatch policy."
  }
}

variable "retention_in_days" {
  description = "CloudWatch log retention in days. Minimum platform standard is 365 days."
  type        = number
  default     = 365

  validation {
    condition = contains([
      365,
      400,
      545,
      731,
      1096,
      1827,
      2192,
      2557,
      3653
    ], var.retention_in_days)
    error_message = "retention_in_days must be an AWS-supported value of at least 365 days."
  }
}

variable "skip_destroy" {
  description = "Set true to retain the log group during Terraform destroy."
  type        = bool
  default     = false
}

variable "log_group_class" {
  description = "CloudWatch log group class."
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "INFREQUENT_ACCESS"], var.log_group_class)
    error_message = "log_group_class must be STANDARD or INFREQUENT_ACCESS."
  }
}

variable "data_protection_policy_json" {
  description = "Optional CloudWatch Logs data protection policy JSON."
  type        = string
  default     = null
}

variable "subscription_filters" {
  description = "Optional subscription filters for central log routing."
  type = map(object({
    destination_arn = string
    filter_pattern  = optional(string, "")
    role_arn        = optional(string)
    distribution    = optional(string)
  }))
  default = {}
}

variable "metric_filters" {
  description = "Optional metric filters to extract operational metrics from log events."
  type = map(object({
    pattern          = string
    metric_name      = string
    metric_namespace = string
    metric_value     = optional(string, "1")
    default_value    = optional(number)
    unit             = optional(string)
    dimensions       = optional(map(string), {})
  }))
  default = {}
}

variable "tags" {
  description = "Common tags to apply to supported AWS resources."
  type        = map(string)

  validation {
    condition = alltrue([
      contains(keys(var.tags), "Environment"),
      contains(keys(var.tags), "Owner"),
      contains(keys(var.tags), "CostCenter"),
      contains(keys(var.tags), "DataClassification")
    ])
    error_message = "tags must include Environment, Owner, CostCenter, and DataClassification."
  }
}
