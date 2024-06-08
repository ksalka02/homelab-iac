resource "aws_security_group" "api_dev_sg" {
  name        = "api-dev-sg"
  description = "SG for dev stage of api"
  # vpc_id      = aws_vpc.main.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # security_groups = [aws_security_group.api_lb_sg.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "https"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.api_lb_sg.id]
    # cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "custom"
    from_port   = var.port_dev
    to_port     = var.port_dev
    protocol    = "tcp"
    # security_groups = [aws_security_group.api_lb_sg.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "api_prod_sg" {
  name        = "api-prod-sg"
  description = "SG for dev stage of api"
  # vpc_id      = aws_vpc.main.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # security_groups = [aws_security_group.api_lb_sg.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "https"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.api_lb_sg.id]
    # cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "custom"
    from_port   = var.port_prod
    to_port     = var.port_prod
    protocol    = "tcp"
    # security_groups = [aws_security_group.api_lb_sg.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# data "http" "myip" {
#   url = ""
# }http://ipv4.icanhazip.com

resource "aws_security_group" "api_lb_sg" {
  name        = "api-lb-sg"
  description = "security group for my access"
  # vpc_id      = aws_vpc.main.id

  ingress {
    description = "custom"
    from_port   = var.port_dev
    to_port     = var.port_dev
    protocol    = "tcp"
    # cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "custom"
    from_port   = var.port_prod
    to_port     = var.port_prod
    protocol    = "tcp"
    # cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
