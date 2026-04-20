# Create a log group for the frontend application logs
resource "aws_cloudwatch_log_group" "notestack_frontend_log_group" {
    name = "/ecs/${var.project_name}/frontend"
}


# Create a log group for the backend application logs
resource "aws_cloudwatch_log_group" "notestack_backend_log_group" {
    name = "/ecs/${var.project_name}/backend"
}