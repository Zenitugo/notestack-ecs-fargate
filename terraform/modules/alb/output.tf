# Output target group arn for frontend
output "target_group_arn" {
  value = aws_lb_target_group.notestack_tg.arn
}


# Output backend target group arn
output "backend_target_group_arn" {
  value = aws_lb_target_group.notestack_backend_tg.arn
}