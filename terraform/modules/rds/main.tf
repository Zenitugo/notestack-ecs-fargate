# Create a subnet group for the RDS instance
resource "aws_db_subnet_group" "notestack_rds" {
  name       = "${var.project_name}_rds"
  subnet_ids = [var.private_subnet_3_id, var.private_subnet_4_id]
}

resource "aws_db_instance" "notestack_rds" {
  allocated_storage        = 20
  storage_type             = "gp2"
  engine                   = "postgres"
  engine_version           = "15.4"
  instance_class           = "db.t3.micro"
  db_name                  = "${var.project_name}_db"
  username                 = var.db_username
  password                 = var.db_password
  db_subnet_group_name     = aws_db_subnet_group.notestack_rds.name
  vpc_security_group_ids   = [var.rds_sg_id]
  publicly_accessible      = false
  multi_az                 = true
  skip_final_snapshot      = true
}