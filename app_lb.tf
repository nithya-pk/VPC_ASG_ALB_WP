resource "aws_alb" "alb" {
 name = "application-lb"
 #vpc_id =  aws_vpc.NK_VPC.id
 security_groups = [aws_security_group.allow_ssh_tcp_alb.id]
 subnets = ["${aws_subnet.public_subnets[0].id}", "${aws_subnet.public_subnets[1].id}"]
 idle_timeout = 400
 enable_deletion_protection = false
 tags = {Name = "application_lb"}
}

resource "aws_alb_listener" "alb" {
 load_balancer_arn = "${aws_alb.alb.arn}"
 port = 80
 protocol = "HTTP"
 default_action {
  type = "redirect"
  redirect {
   port = "443"
   protocol = "HTTPS"
   status_code = "HTTP_301"
  }
 }
}

resource "aws_lb_target_group" "alb_target_gp" {
 name = "alb-target-gp"
 depends_on = [aws_vpc.NK_VPC]
 port = 80
 protocol = "HTTP"
 vpc_id = "${aws_vpc.NK_VPC.id}"
 target_type = "instance"
 health_check {
  interval = 30
  #path = "/index.html"
  port = 80
  healthy_threshold = 5
  unhealthy_threshold = 2
  timeout = 5
  protocol = "HTTP"
  matcher = "200,202"
  }
}