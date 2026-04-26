# Output Secrets ARN
output "secrets_arn" {
    value = aws_secretsmanager_secret.notestack_secret.arn
}