
# Create a private DNS namespace for service discovery
resource "aws_service_discovery_private_dns_namespace" "notestack" {
  name        = "${var.project_name}-namespace"
  vpc         = var.vpc_id
}


# Create a service discovery service for the backend
resource "aws_service_discovery_service" "backend" {
  name = "${var.project_name}-backend-service"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.notestack.id
    routing_policy = "MULTIVALUE"
    dns_records {
      type = "A"
      ttl  = 10
        }       
  }

    health_check_custom_config {
        failure_threshold = 1
    }
}