# The data for the assume policy for the IAM role used by all authorized users on env
data "aws_iam_policy_document" "ops_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        # StageA account
        # "arn:aws:iam::000000000000:root" Replace with MontBlu account ID
      ]
    }
  }
}

# The permissions for ops
## Policy Document
data "aws_iam_policy_document" "ops" {
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "acm:*",
      "apigateway:*",
      "appsync:*",
      "artifact:*",
      "autoscaling:*",
      "logs:*",
      "ce:*",
      "cloudfront:*",
      "cloudformation:*",
      "cloudtrail:*",
      "cloudwatch:*",
      "cognito-idp:*",
      "dynamodb:*",
      "iam:*",
      "identitystore:*",
      "kms:*",
      "lambda:*",
      "ecr:*",
      "ec2:*",
      "elasticache:*",
      "elasticfilesystem:*",
      "elasticloadbalancing:*",
      "es:*",
      "eks:*",
      "organizations:*",
      "pi:*",
      "rds:*",
      "route53:*",
      "route53domains:*",
      "s3:*",
      "secretsmanager:*",
      "serverlessrepo:*",
      "SNS:*",
      "sqs:*",
      "sso-directory:*",
      "sso:*",
      "sts:DecodeAuthorizationMessage",
      "support:*",
      "tag:*",
      "tiros:*",
      "transfer:*",
      "wafv2:*",
      # The following are required to grab all the account external IP addresses to be used in the network scanner
      "apigateway:GET",
      "lightsail:GetInstances",
      "lightsail:GetLoadBalancers",
      "redshift:DescribeClusters",
      "events:*",
      "ssm:GetParameter",
      "ses:*"
    ]
    resources = [
      "*",
    ]
  }
}
## Policy
resource "aws_iam_policy" "ops" {
  description = "Managed by Terraform"
  name        = "${local.resource_name_prefix}-devops-mntb"
  policy      = data.aws_iam_policy_document.ops.json
}

## Devs

data "aws_iam_policy_document" "devs" {
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "cloudfront:*",
      "cloudtrail:*",
      "cloudwatch:*",
      "dynamodb:*",
      "ec2:*",
      "ecr:*",
      "eks:*",
      "kms:*",
      "logs:*",
      "pi:*",
      "rds:*",
      "route53:*",
      "s3:*",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid    = "2"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*"
    ]
    resources = [
      data.aws_kms_alias.secrets.target_key_arn
    ]
  }
}

resource "aws_iam_policy" "devs" {
  name        = "${local.resource_name_prefix}-devs"
  description = "Managed by Terraform"
  policy      = data.aws_iam_policy_document.devs.json
}

## Billing

data "aws_iam_policy_document" "billing" {
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "billing:*",
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "billing" {
  name        = "${local.resource_name_prefix}-billing"
  description = "Managed by Terraform"
  policy      = data.aws_iam_policy_document.billing.json
}