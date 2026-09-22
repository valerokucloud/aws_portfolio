output "vpc_id" {
  value = aws_vpc.main.id
}

output "ec2_ids" {
  value = aws_instance.operations[*].id
}

output "ec2_public_ips" {
  value = aws_instance.operations[*].public_ip
}

output "ssm_association_id" {
  value = aws_ssm_association.hostname.association_id
}

output "ssm_patching_association_id" {
  value = aws_ssm_association.patching.association_id
}