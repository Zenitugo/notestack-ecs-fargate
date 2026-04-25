# This resource creates an ECR repository for the frontend application.
resource "aws_ecr_repository" "frontend_repository" {
  name = "${var.project_name}-frontend-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


# This resource creates an ECR repository for the backend application.
resource "aws_ecr_repository" "backend_repository" {
  name = "${var.project_name}-backend-repository"       
  image_tag_mutability = "MUTABLE"
  
  image_scanning_configuration {
        scan_on_push = true
    }
}