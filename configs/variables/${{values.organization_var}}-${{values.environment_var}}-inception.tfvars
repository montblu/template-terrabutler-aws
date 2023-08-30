inception_projects = [
  "network",
]

# needed for staging (default) only:
include_inception_project = true

# aws kms encrypt --profile "${{values.organization_var}}-${{values.environment_var}}" --region=${{values.region_var}}--key-id alias/secrets --plaintext "PASSWORD" --output text --query CiphertextBlob
# aws kms decrypt --profile "${{values.organization_var}}-${{values.environment_var}}" --region=${{values.region_var}} --ciphertext-blob "PASSWORD"--output text --query Plaintext  | base64 -d