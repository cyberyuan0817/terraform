// Create the ALB
resource "aws_lb" "lb" {
    name = "${var.env_prefix}-lb"
    internal = false
    load_balancer_type = "application"
    subnets = var.subnet_ids_list
    security_groups    = [var.load_balancer_security_group_id] 
    
}


// Create the Prod target group
resource "aws_lb_target_group" "prod_tg" {
  name     = "prod-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.prod_vpc_id
  target_type = "ip"
  # health_check {
  #   enabled             = true
  #   healthy_threshold   = 3
  #   interval            = 30
  #   matcher             = "404"
  #   path                = "/status"
  #   port                = "3000"
  #   protocol            = "HTTP"
  #   timeout             = 5
  #   unhealthy_threshold = 3
  # }
  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "404"
    timeout             = "3"
    path                = "/api/health-check"
    unhealthy_threshold = "2"
    }
  

}


// Create the Uat target group
resource "aws_lb_target_group" "uat_tg" {
  name     = "uat-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.prod_vpc_id
  target_type = "ip"
  
  # health_check {
  #   enabled             = true
  #   healthy_threshold   = 3
  #   interval            = 30
  #   matcher             = "404"
  #   path                = "/status"
  #   port                = "3000"
  #   protocol            = "HTTP"
  #   timeout             = 5
  #   unhealthy_threshold = 3
  # }
  health_check {
  healthy_threshold   = "3"
  interval            = "30"
  protocol            = "HTTP"
  matcher             = "404"
  timeout             = "3"
  path                = "/api/health-check"
  unhealthy_threshold = "2"
  }
}



// Create the ALB listener
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06" // Set the SSL policy

  // ARN of your SSL certificate
  certificate_arn   = var.alb_ssl_srn


  # Other listener configuration as needed
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_tg.arn
  }
}



// Forward the traffic to UAT based on the hostname
resource "aws_lb_listener_rule" "rule_2" {
  listener_arn = aws_lb_listener.my_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.uat_tg.arn
  }

  condition {
    host_header {
      values = ["uat.${var.host_web_address}"]
    }
  }
}

resource "aws_lb_listener_certificate" "additional_cert" {
  listener_arn    = aws_lb_listener.my_listener.arn
  certificate_arn = var.alb_uat_ssl_srn
}