 ## create a database instance 
resource "aws_db_instance" "abkhan-prod-db" {
  identifier             = "abkhan-prod-db"
  instance_class         = "db.m5.xlarge"
  allocated_storage      = 10
  max_allocated_storage =  100
  engine                 = "PostgresSQL"
  engine_version         = "11.16"
  username               = "root"
  password               = var.db_password
  vpc_security_group_ids = var.default_SG
  publicly_accessible    = false
  skip_final_snapshot    = true
  deletion_protection    = true
  multi_az               = false 
  delete_automated_backups = true
  performance_insights_enabled = true
  iops                     = 1000
  storage_encrypted        = true
  storage_type             = "io1"
  kms_key_id               = "aws/RDS"  # I am  not able to see the KMS value in Console
  port                     = 5432  # port to access db instance
  
}

## parameter group
resource "aws_db_parameter_group" "abkhan-prod-db" {
  name   = "abkhan-prod-db"
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

 

## input variables for security group
variable "default_SG" {
  description = "value of SG"
  type =  string
  default = "sg-2a299555"
}

 
 
  
