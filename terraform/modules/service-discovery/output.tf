# Output backend service discovery namespace ID
output "service_discovery_namespace_id" {
  value = aws_service_discovery_private_dns_namespace.notestack.id
}

# Output backend service discovery service ID
output "service_discovery_service_id" {
  value = aws_service_discovery_service.backend.id
}