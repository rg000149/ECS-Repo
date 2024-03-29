# Security group for ECS cluster
resource "aws_security_group" "my_sg" {
  name_prefix = "ecs_security_group"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    name = var.sg-name
  }
}

# Security group ingress rule
resource "aws_security_group_rule" "ecs_ingress_rule" {
  security_group_id = aws_security_group.my_sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
}

# Security group ingress rule for ssh
resource "aws_security_group_rule" "ssh_ingress_rule" {
  security_group_id = aws_security_group.my_sg.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Security group ingress rule for database
resource "aws_security_group_rule" "db_ingress_rule" {
  security_group_id = aws_security_group.my_sg.id
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Security group ingress rule for rails
resource "aws_security_group_rule" "rails_ingress_rule" {
  security_group_id = aws_security_group.my_sg.id
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Security group egress rule
resource "aws_security_group_rule" "ecs_egress_rule" {
  security_group_id = aws_security_group.my_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}


# Load balance security group
resource "aws_security_group" "lb" {
  name   = "alb-security-group"
  vpc_id = aws_vpc.vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}