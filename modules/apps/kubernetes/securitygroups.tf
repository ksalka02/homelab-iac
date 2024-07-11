# # data "http" "myip" {
# #   url = ""
# # }http://ipv4.icanhazip.com

# resource "aws_security_group" "api_lb_sg" {
#   name        = "${var.app_name}-lb-sg"
#   description = "security group for my access through ${var.app_name} load balancer"
#   # vpc_id      = aws_vpc.main.id

#   ingress {
#     description = "custom"
#     from_port   = var.port_dev
#     to_port     = var.port_dev
#     protocol    = "tcp"
#     # cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "custom"
#     from_port   = var.port_prod
#     to_port     = var.port_prod
#     protocol    = "tcp"
#     # cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# # data "aws_lb" "api_gateway_lb" {
# #   name            = module.eks_shared_infra.load_balancer_name
# #   security_groups = [aws_security_group.api_lb_sg.id]
# # }
