# Create Security Group for Application Load Balancer
resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.vpc.id                                                                      
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0        
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Create Security Group for ECS tasks Frontend
resource "aws_security_group" "ecs_sg_frontend" {
  name        = "${var.project_name}-ecs-sg-frontend"
  description = "Security group for ECS tasks - Frontend"
  vpc_id      = aws_vpc.vpc.id
    ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }
    egress {
        from_port   = 0
        to_port     = 0        
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


# Create Security Group for ECS tasks Backend
resource "aws_security_group" "ecs_sg_backend" {
  name        = "${var.project_name}-ecs-sg-backend"
  description = "Security group for ECS tasks - Backend"  
  vpc_id      = aws_vpc.vpc.id
    ingress {
        from_port   = 8000
        to_port     = 8000
        protocol    = "tcp"
        security_groups = [aws_security_group.ecs_sg_frontend.id]
    }
    egress {
        from_port   = 0
        to_port     = 0        
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


# Create Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.vpc.id
    ingress {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"         
        security_groups = [aws_security_group.ecs_sg_backend.id]
    }
    egress {
        from_port   = 0         
        to_port     = 0       
        protocol    = "-1"        
        cidr_blocks = ["0.0.0.0/0"] 
    }
}
