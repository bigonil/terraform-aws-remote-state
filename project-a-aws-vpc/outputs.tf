output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the shared VPC"
}
output "public_subnet_id" {
  value       = aws_subnet.public_a.id
  description = "The ID of the public subnet in availability zone A"
}