# Output values for the ECR repositories
output "frontend_repository_url" {
  value = aws_ecr_repository.frontend_repository.repository_url
}

output "backend_repository_url" {
  value = aws_ecr_repository.backend_repository.repository_url
}