# oUTPUT THE RDS DB NSTANCE
output "rds_endpoint" {
  value = aws_db_instance.notestack_rds.address
}