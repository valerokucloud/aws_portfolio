# EC2 inst. definition:
  data "aws_ssm_parameter" "al2023_ami" {
    name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  }

  resource "aws_instance" "operations" {
    count = 2

    ami           = data.aws_ssm_parameter.al2023_ami.value
    instance_type = "t3.micro"

    subnet_id = element([
      aws_subnet.public_a.id,
      aws_subnet.public_b.id
    ], count.index)

    iam_instance_profile = aws_iam_instance_profile.ec2_ssm.name

    user_data = <<-EOF
      #!/bin/bash
      touch /var/log/operations.log
      chmod 644 /var/log/operations.log
      echo "$(date) - AWS Operations Platform started" >> /var/log/operations.log
    EOF

    tags = {
      Name = "${var.project_name}-ec2-${count.index + 1}"
    }
}