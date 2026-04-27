# Output target group arn for frontend
output "target_group_arn" {
  value = aws_lb_target_group.notestack_tg.arn
}
