# data "http" "myip" {
#   url = ""
# }http://ipv4.icanhazip.com

resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-sg"
  description = "eks security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "custom"
    from_port   = 8080
    to_port     = 8080
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


# resource "aws_security_group" "node_grp_sg" {
#   name        = "node-sg"
#   description = "for node group"
#   vpc_id      = var.vpc_id

#   # ingress {
#   #   description = "all trafic"
#   #   from_port   = 0
#   #   to_port     = 0
#   #   protocol    = "-1"
#   #   # cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
#   #   security_groups = [aws_security_group.cluster_sg.id]
#   # }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
