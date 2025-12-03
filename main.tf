##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##-----------------------------------------------------------------------------
module "lables" {
  source      = "git::https://github.com/yrahul05/terraform-multicloud-labels.git?ref=v1.0.0"
  enabled     = var.enabled
  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order

}

##-----------------------------------------------------------------------------
## Below resource will deploy IAM role in AWS environment.
##----------------------------------------------------------------------------
resource "aws_iam_role" "default" {
  count                 = var.enabled ? 1 : 0
  name                  = module.lables.id
  assume_role_policy    = var.assume_role_policy
  managed_policy_arns   = var.managed_policy_arns
  force_detach_policies = var.force_detach_policies
  path                  = var.path
  description           = var.description
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary
  tags                  = module.lables.tags
}

#-----------------------------------------------------------------------------
# Below resource will deploy IAM policy and attach it to above created IAM role.
#-----------------------------------------------------------------------------
resource "aws_iam_role_policy" "default" {
  count  = var.enabled && var.policy_enabled && var.policy_arn == "" ? 1 : 0
  name   = format("%s-policy", module.lables.id)
  role   = join("", aws_iam_role.default[*].id)
  policy = var.policy
}

##-----------------------------------------------------------------------------
## Below resource will attach IAM policy to above created IAM role.
##-----------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "default" {
  count      = var.enabled && var.policy_enabled && var.policy_arn != "" ? 1 : 0
  role       = join("", aws_iam_role.default[*].id)
  policy_arn = var.policy_arn
}
