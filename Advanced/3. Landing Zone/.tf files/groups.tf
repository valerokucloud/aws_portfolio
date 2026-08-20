# CloudEngineer user creation:
  resource "aws_identitystore_group" "cloud-engineers" {
    identity_store_id = local.identity_store_id

    display_name = "CloudEngineers"
    description  = "AWS Cloud Engineers"
}