locals {
  user_data_dev  = templatefile("${path.root}/shell-scripts/${var.user_data_file}", { "port" = var.port_dev })
  user_data_prod = templatefile("${path.root}/shell-scripts/${var.user_data_file}", { "port" = var.port_prod })
}

resource "aws_iam_instance_profile" "api_iam_profile" {
  role = "playersapi"
}

################################################################
###################### DEV PART ###############################
################################################################

resource "aws_launch_template" "api_instance_dev" {

  instance_type          = var.instance_type
  image_id               = var.image_id
  vpc_security_group_ids = [aws_security_group.api_dev_sg.id]
  key_name               = var.key_name
  iam_instance_profile {
    arn = aws_iam_instance_profile.api_iam_profile.arn
  }
  user_data = base64encode(local.user_data_dev)

  # metadata_options {
  #   http_put_response_hop_limit = 3
  #   http_endpoint               = "enabled"
  # }
  tags = {
    Name = "${var.app_name}-dev"
  }
}


resource "aws_autoscaling_group" "api_asg_dev" {

  name                      = "${var.app_name}-asg-dev"
  availability_zones        = var.availability_zones
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.api_instance_dev.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.app_name}-dev"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "lb_asg_attachment_dev" {
  autoscaling_group_name = aws_autoscaling_group.api_asg_dev.id
  lb_target_group_arn    = aws_lb_target_group.api_tg_dev.arn
}

################################################################
###################### PROD PART ###############################
################################################################

resource "aws_launch_template" "api_instance_prod" {

  instance_type          = var.instance_type
  image_id               = var.image_id
  vpc_security_group_ids = [aws_security_group.api_prod_sg.id]
  key_name               = var.key_name
  iam_instance_profile {
    arn = aws_iam_instance_profile.api_iam_profile.arn
  }
  user_data = base64encode(local.user_data_prod)

  # metadata_options {
  #   http_put_response_hop_limit = 3
  #   http_endpoint               = "enabled"
  # }
  tags = {
    Name = "${var.app_name}-prod"
  }
}
resource "aws_autoscaling_group" "api_asg_prod" {

  name                      = "${var.app_name}-asg-prod"
  availability_zones        = var.availability_zones
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.api_instance_prod.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.app_name}-prod"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "lb_asg_attachment_prod" {
  autoscaling_group_name = aws_autoscaling_group.api_asg_prod.id
  lb_target_group_arn    = aws_lb_target_group.api_tg_prod.arn
}
