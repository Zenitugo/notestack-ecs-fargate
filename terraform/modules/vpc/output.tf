# Output values for the VPC module
output "vpc_id" {
  value = aws_vpc.vpc.id
}

# Output the ID of the public subnet 1
output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

# Output the ID of the public subnet 2
output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

# Output the ID of the private subnet 1
output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id    
}

# Output the ID of the private subnet 2
output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id    
}