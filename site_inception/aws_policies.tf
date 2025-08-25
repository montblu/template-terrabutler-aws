locals {
  development_actions = sort(distinct(
    [
      "iam:*",
  ]))
  lead_development_actions = sort(distinct(concat(
    local.development_actions, [
      "iam:*",
      "identitystore:*",
      "logs:*", ?
      "organizations:*", ?
      "s3:*",
      "ssm:*", ?
      "sso-directory:*",
      "sso:*",
      "states:*", ?
      "support:*",  ?
  ])))
  montblu_actions = sort(distinct(concat(
    local.lead_development_actions, [
      "iam:*",
  ])))


  role_permissions = {
    development = {
      actions     = local.development_actions
      description = "Development team permissions"
    }

    development_leads = {
      actions     = local.lead_development_actions
      description = "Development Leads team permissions"
    }
    montblu = {
      actions     = local.montblu_actions
      description = "MontBlu team permissions"
    }
  }
}

data "aws_iam_policy_document" "all" {
  for_each = local.role_permissions

  statement {
    sid       = title(replace(each.key, "_", ""))
    effect    = "Allow"
    actions   = each.value.actions
    resources = ["*"]
  }
}
