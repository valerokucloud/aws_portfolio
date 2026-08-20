locals {
  identity_store_id = tolist(
    data.aws_ssoadmin_instances.main.identity_store_ids
  )[0]

  instance_arn = tolist(
    data.aws_ssoadmin_instances.main.arns
  )[0]
}