output "arn" {
  value       = join("", aws_iam_role.default[*].arn)
  description = "Amazon Resource Name (ARN) specifying the role."
}
output "name" {
  value       = join("", aws_iam_role.default[*].name)
  description = "Name of the role."
}
output "tags" {
  value       = module.lables.tags
  description = "A mapping of tags to assign to the resource."
}

output "policy" {
  value       = join("", aws_iam_role_policy.default[*].policy)
  description = "The policy document attached to the role."
}

output "role" {
  value       = join("", aws_iam_role_policy.default[*].role)
  description = "The name of the role associated with the policy."
}