resource "aws_lb" "api_lb" {
  name               = "${var.app_name}-lb"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.api_lb_sg.id]
  subnets            = var.private_subnets

  enable_deletion_protection = false

}



##############################################
########### DEV PART OF LB ###################
##############################################

resource "aws_lb_target_group" "api_tg_dev" {
  name        = "${var.app_name}-tg-dev"
  target_type = "instance"
  port        = var.port_dev
  protocol    = "TCP"
  slow_start  = 0
  vpc_id      = var.vpc
}

resource "aws_lb_listener" "lb_listener_dev" {
  load_balancer_arn = aws_lb.api_lb.arn
  port              = var.port_dev
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_tg_dev.arn
  }
}


##############################################
########### PROD PART OF LB ##################
##############################################


resource "aws_lb_target_group" "api_tg_prod" {
  name        = "${var.app_name}-tg-prod"
  target_type = "instance"
  port        = var.port_prod
  protocol    = "TCP"
  slow_start  = 0
  vpc_id      = var.vpc
}

resource "aws_lb_listener" "lb_listener_prod" {
  load_balancer_arn = aws_lb.api_lb.arn
  port              = var.port_prod
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_tg_prod.arn
  }
}
