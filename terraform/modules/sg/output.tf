# output alb security group ID
output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}


# output ecs frontend security group ID
output "ecs_sg_frontend_id" {
  value = aws_security_group.ecs_sg_frontend.id
}


# output ecs backend security group ID
output "ecs_sg_backend_id" {
  value = aws_security_group.ecs_sg_backend.id
}