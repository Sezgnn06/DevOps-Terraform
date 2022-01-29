
resource "aws_lb_target_group" "video" {
  name     = "videos"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prdx-vpc.id
  health_check {
    path = "/videos/"
    port = 80
  }
}

resource "aws_lb_target_group" "image" {
  name     = "itmeme"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prdx-vpc.id
  health_check {
    path = "/itmeme/"
    port = 80
  }
}

resource "aws_lb_target_group" "default" {
  name     = "default"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.prdx-vpc.id
  health_check {
    path = "/"
    port = 80
  }
}

resource "aws_lb_target_group_attachment" "default_attach" {
  target_group_arn = aws_lb_target_group.default.arn
  target_id        = aws_instance.default_page.id
  port             = 80
}

resource "aws_lb" "prdx-lb14" {
  name               = "prdx-lb14"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.prdx-proje-sg1.id]
  subnets            = [aws_subnet.prdx-public-subnet.id, aws_subnet.prdx-public1-subnet.id]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.prdx-lb14.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}
resource "aws_lb_listener_rule" "video" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.video.arn
  }

  condition {
    path_pattern {
      values = ["*/videos*"]
    }
  }
}
resource "aws_lb_listener_rule" "image" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 300

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.image.arn
  }

  condition {
    path_pattern {
      values = ["*/itmeme*"]
    }
  }
}
