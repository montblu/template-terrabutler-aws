locals {

  domain_tld = split(".", var.domain)[1]

  resource_name_prefix = join(
    "-",
    [
      var.organization,
      var.environment
    ],
  )

  aws_default_tags = {
    ManagedByTerraform = "yes"
    Billing            = var.organization
    TerraformWorkspace = terraform.workspace
    Environment        = var.environment
  }

  availability_zones = [
    "${var.provider_region}a",
    "${var.provider_region}b",
    "${var.provider_region}c"
  ]

}
