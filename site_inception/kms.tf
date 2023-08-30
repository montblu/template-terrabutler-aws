# Defines the KMS master key

resource "aws_kms_key" "secrets" {
  description             = "Master encryption key for secrets"
  deletion_window_in_days = 7
  enable_key_rotation     = "true"

  tags = {
    ManagedByTerraform = "yes"
  }

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "key-allow-users",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        ]
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOF
}

# Defines the easy access name of the KMS master key

resource "aws_kms_alias" "secrets" {
  name          = "alias/secrets"
  target_key_id = aws_kms_key.secrets.key_id
}