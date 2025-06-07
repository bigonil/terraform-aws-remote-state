resource "aws_ssm_parameter" "vpc_id" {
  name  = "/network/vpc_id"
  type  = "String"
  value = aws_vpc.main.id
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/network/private_subnet_ids"
  type  = "String"
  value = join(",", [aws_subnet.private_a.id, aws_subnet.private_b.id])
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/network/public_subnet_ids"
  type  = "String"
  value = join(",", [aws_subnet.public_a.id, aws_subnet.public_b.id])
}

resource "aws_ssm_parameter" "nat_gateway_id" {
  name  = "/network/nat_gateway_id"
  type  = "String"
  value = aws_nat_gateway.main.id
}
resource "aws_ssm_parameter" "internet_gateway_id" {
  name  = "/network/internet_gateway_id"
  type  = "String"
  value = aws_internet_gateway.main.id
}