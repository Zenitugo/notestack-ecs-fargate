resource "aws_ecr_repository" "frontend_repository" {
  name = "${var.project_name}-repository"

  image_scanning_configuration {
    scan_on_push = true
  }
}