# Create a cluster
resource "aws_ecs_cluster" "notestack" {
  name = "${var.project_name}-cluster"
}