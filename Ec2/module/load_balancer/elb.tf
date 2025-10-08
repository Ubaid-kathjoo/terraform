resource "aws_lb" "this" {
  name               = "my-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.SG]
 subnets            = var.subnets
}

resource "aws_lb_target_group" "this" {
  name     = "my-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "ec2_1" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.ec2_1_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec2_2" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.ec2_2_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec2_3" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.ec2_3_id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
