# output alb security group ID
output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}