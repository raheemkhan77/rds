  ## create a database instance 
resource "aws_db_instance" "aptrac-prod-db" {
  identifier             = "aptrac-prod-db"
  instance_class         = "db.m5.xlarge"
  allocated_storage      = 10
  max_allocated_storage =  100
  engine                 = "postgres"
  engine_version         = "11.16"
  username               = "postgres"
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.db-access.id]
  publicly_accessible    = false
  skip_final_snapshot    = true
  deletion_protection    = false
  multi_az               = false 
  delete_automated_backups = true
  performance_insights_enabled = true
##iops                     = 1000
  storage_encrypted        = true
 storage_type             = "gp3"
 
  port                     = 5432
}

## parameter group
resource "aws_db_parameter_group" "aptrac-prod-db" {
  name   = "aptrac-prod-db"
  family = "postgres11"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

## input variables for password
variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

