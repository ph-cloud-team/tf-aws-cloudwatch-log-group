variable "kms_key_id" {
  description = "Customer-managed KMS key ARN for CloudWatch Logs."
  type        = string
  default     = null
}
