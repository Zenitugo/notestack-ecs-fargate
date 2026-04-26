# Output Cluster name
output "cluster_name" {
  value = module.ecs.cluster_name
}

# Output backend service name
output "backend_service_name" {
  value = module.ecs.backend_service_name
}

# Output frontend service name
output "frontend_service_name" {
  value = module.ecs.frontend_service_name
}

# Output values for the ECR repositories
output "frontend_repository_url" {
  value = module.ecr.frontend_repository_url
}

output "backend_repository_url" {
  value = module.ecr.backend_repository_url
}