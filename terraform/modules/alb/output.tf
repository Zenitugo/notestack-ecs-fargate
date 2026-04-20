# Output target group arn for frontend
output "target_group_arn" {
  value = aws_lb_target_group.notestack_tg.arn
}


# Output backend ALB DNS name
output "backend_URL" {
  value = aws_lb.notestack_backend_lb.dns_name
}


# Output backend target group arn
output "backend_target_group_arn" {
  value = aws_lb_target_group.notestack_backend_tg.arn
}