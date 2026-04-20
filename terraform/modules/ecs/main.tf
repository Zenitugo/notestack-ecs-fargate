# Create a cluster
resource "aws_ecs_cluster" "notestack" {
  name = "${var.project_name}-cluster"
}



# Register a task definition for the frontend service
resource "aws_ecs_task_definition" "frontend_task" {
  family                   = "${var.project_name}-task"
  container_definitions    = jsonencode([
    {
    name           = "${var.project_name}-frontend-container",
    image          = "${var.frontend_repository_url}:latest",
    container_port = var.frontend_port
    host_port      = var.frontend_port
    protocol        = "tcp"
    aws_region     = var.region
  },
  {
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = var.frontend_log_group_name
        "awslogs-region"        = var.region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }
  ])

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role_arn
  cpu                      = "256"
  memory                   = "512"

  depends_on = [aws_ecs_cluster.notestack,]
}  


# Register a task definition for the backend service
resource "aws_ecs_task_definition" "backend_task" {
  family                   = "${var.project_name}-backend-task"
  container_definitions    = jsonencode([
    {
    name           = "${var.project_name}-backend-container",
    image          = "${var.backend_repository_url}:latest",
    container_port = var.backend_port
    host_port      = var.backend_port 
    protocol        = "tcp"
    aws_region     = var.region
  },
  {
    logConfiguration = {
      logDriver = "awslogs" 
      options = {
        "awslogs-group"         = var.backend_log_group_name
        "awslogs-region"        = var.region
        "awslogs-stream-prefix" = "ecs"
        }
    }
  }
  ])
  secrets = [
    {
      name      = "DB_PASSWORD"
      valueFrom = "${var.secrets_arn}:DB_PASSWORD::"
    },
    {
      name      = "DB_USERNAME"
      valueFrom = "${var.secrets_arn}:DB_USERNAME::"
    },
    {
      name      = "DB_HOST"
      valueFrom = "${var.secrets_arn}:DB_HOST::"
    },
    {
      name      = "DB_PORT"
      valueFrom = "${var.db_port}"
    }
  ]
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role_arn
  cpu                      = "256"
  memory                   = "512"  

  depends_on = [aws_ecs_cluster.notestack,]
}      