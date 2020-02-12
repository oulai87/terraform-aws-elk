resource "aws_elb" "elk" {
  name    = "elk-elb"
  subnets = data.aws_subnet_ids.public.ids

  listener {
    instance_port     = 5601
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:5601/status"
    interval            = 30
  }

  #instances                   = ["${aws_instance.foo.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  security_groups             = [aws_security_group.lb.id]
  tags                        = var.common_tags
}