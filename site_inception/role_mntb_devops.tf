# Policy to MontBlu users
resource "aws_iam_policy" "mntb" {
  description = "Managed by Terraform"
  name        = "${local.resource_name_prefix}_devops_mntb"
  policy      = data.aws_iam_policy_document.ops.json
}

# Role to MontBlu users
resource "aws_iam_role" "mntb" {
  name               = "${local.resource_name_prefix}-devops-mntb"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::101998516976:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
EOF
}

# Required Permissions
resource "aws_iam_role_policy_attachment" "mntb_policy" {
  role       = aws_iam_role.mntb.name
  policy_arn = aws_iam_policy.mntb.arn
}

# DynamoDB Full Access
resource "aws_iam_role_policy_attachment" "mntb_dynamodb" {
  role       = aws_iam_role.mntb.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

