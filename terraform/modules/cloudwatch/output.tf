# Output log group for frontend
output "frontend_log_group_name" {
  value = aws_cloudwatch_log_group.notestack_frontend_log_group.name
}

# Output log group for backend
output "backend_log_group_name" {
  value = aws_cloudwatch_log_group.notestack_backend_log_group.name
}