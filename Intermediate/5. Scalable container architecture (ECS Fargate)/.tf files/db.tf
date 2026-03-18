# DB subnet group (necessary for each RDS instance):
    resource "aws_db_subnet_group" "db" {
      name = "db-subnet-group"
      subnet_ids = [aws_subnet.private_a.id,
                    aws_subnet.private_b.id]
}

# RDS Instance:
  resource "aws_db_instance" "db" {
    identifier = "portfolio-db"
    engine = "postgres"
    instance_class = "db.t3.micro"

    allocated_storage = 20

    /* Bad practice. We'll create credentials through AWS Secrets Manager:
        
        password = "examplepwd" 
    */
    username = "dbadmin"
    manage_master_user_password = true  # Creating dbadmin password directly to AWS Secrets Manager
    
    db_subnet_group_name = aws_db_subnet_group.db.name
    vpc_security_group_ids = [aws_security_group.rds.id]

    publicly_accessible = false   # NO public IP
    skip_final_snapshot = true    # Problem deleting db-instance if "false"
}