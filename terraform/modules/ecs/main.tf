# Create a cluster
resource "aws_ecs_cluster" "notestack" {
  name = "${var.project_name}-cluster"
}



# Register a task definition for the frontend service
resource "aws_ecs_task_definition" "frontend_task" {
  family                   = "${var.project_name}-frontend-task"
  container_definitions    = jsonencode([
    {
    name           = "${var.project_name}-frontend-container",
    image          = "${var.frontend_repository_url}:latest",
    portMappings = [
      {
        containerPort = var.frontend_port
        hostPort      = var.frontend_port
        protocol      = "tcp"
      }
    ]
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
    portMappings = [
      {
        containerPort = var.backend_port
        hostPort      = var.backend_port
        protocol      = "tcp"
      }
    ]
    logConfiguration = {
      logDriver = "awslogs" 
      options = {
        "awslogs-group"         = var.backend_log_group_name
        "awslogs-region"        = var.region
        "awslogs-stream-prefix" = "ecs"
        }
    }
    
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
        }
    ]

    environment = [
      {
        name  = "DB_PORT"
        value = var.db_port
      },
    {
            name  = "DB_NAME"
            value = "${var.project_name}_db"
    }
    ]
    }
])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = var.execution_role_arn
  cpu                      = "256"
  memory                   = "512"  

  depends_on = [aws_ecs_cluster.notestack,]
}      