# Create the IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "my-app-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })
}

# Attach the standard AWS Managed Policy
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}



# Create IAM Role to write logs to CloudWatch

# Create a cloud watch log group for the application logs
resource "aws_cloudwatch_log_group" "notestack_log_group" {
    name = "/aws/ecs/${var.project_name}"
}

# Create a log stream for the application logs
resource "aws_cloudwatch_log_stream" "notestack_log_stream" {
    name           = "${var.project_name}-log-stream"
    log_group_name = aws_cloudwatch_log_group.notestack_log_group.name
}

# Configure the IAM Permissions to writelogs to CloudWatch
resource "aws_iam_policy" "notestack_logging_policy" {
    name        = "${var.project_name}-logging-policy"
    description = "IAM policy to allow writing logs to CloudWatch Logs"
    policy      = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow",
                Action = [
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ],
                Resource = "${aws_cloudwatch_log_group.notestack_log_group.arn}:*"
            }
        ]
    })
}



# Custom policy to read specific secrets
resource "aws_iam_role_policy" "ecs_execution_secrets" {
  name = "${var.project_name}-secrets-policy"
  role = aws_iam_role.ecs_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["secretsmanager:GetSecretValue"]
        Resource = ["${var.secrets_arn}"]
      }
    ]
  })
}