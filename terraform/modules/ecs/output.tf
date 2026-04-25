# Output Cluster name
output "cluster_name" {
  value = aws_ecs_cluster.notestack.name
}

# Output backend service name
output "backend_service_name" {
  value = aws_ecs_service.backend_service.name
}

# Output frontend service name
output "frontend_service_name" {
  value = aws_ecs_service.frontend_service.name
}