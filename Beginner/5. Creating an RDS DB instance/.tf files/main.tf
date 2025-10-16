resource "aws_db_instance" "RDS_DB_example" {
  allocated_storage    = 10 # GB
  db_name              = "example_RDS_DB"
  identifier           = "example-rds-db" # Name in AWS env.
  engine               = "mysql"
  engine_version       = "8.0"

  # Free tier instance class:
    instance_class       = "db.t4g.micro"

  # Master username for the DB:
    username             = "foo"
    password             = "foobarbaz"
  # DB parameter group name to associate:
    parameter_group_name = "default.mysql8.0"
    
  skip_final_snapshot  = true

 /* MORE ATTRIBUTES:
    db_subnet_group_name (VPC)
    vpc_security_group_ids
    replica_mode
        replicate_source_db
    enabled_cloudwatch_logs_exports
        monitoring_role_arn
    backup_target
    backup_window
    backup_retention_period
 */
}