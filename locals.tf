locals {
  module_name = "tf-aws-cloudwatch-log-group"
  name_tag    = trim(substr(trim(replace(lower(var.name), "/[^a-z0-9-]+/", "-"), "-"), 0, 63), "-")

  common_tags = merge(
    {
      ManagedBy = "terraform"
      Module    = local.module_name
    },
    var.tags
  )
}
