resource "aws_secretsmanager_secret" "notestack_secret" {
  name = "${var.project_name}-new-secret"
}

resource "aws_secretsmanager_secret_version" "notestack_secret_version" {
  secret_id     = aws_secretsmanager_secret.notestack_secret.id
  secret_string = jsonencode({
  DB_HOST     = var.rds_endpoint
  DB_USERNAME = var.db_username
  DB_PASSWORD = var.db_password
  })
}