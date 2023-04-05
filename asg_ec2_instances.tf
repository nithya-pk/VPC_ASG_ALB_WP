
resource "aws_autoscaling_group" "asg_nk" {
 name = "asg_nk"
 min_size = 1
 max_size = 4
 desired_capacity = 2
 vpc_zone_identifier = ["${aws_subnet.public_subnets[0].id}", "${aws_subnet.public_subnets[1].id}"]
 launch_template {id = aws_launch_template.ec2_lt.id}
 target_group_arns = ["${aws_lb_target_group.alb_target_gp.arn}"]
 depends_on = [aws_alb.alb]
 }

resource "aws_launch_template" "ec2_lt" {
 name_prefix   = "webserver"
 image_id      = "${var.ami_ver}"
 instance_type = "${var.ec2_type}"
 depends_on = [aws_db_instance.rds_db, aws_subnet.public_subnets[1], aws_subnet.public_subnets[0], aws_alb.alb,aws_security_group.allow_ssh_tcp_ec2]
 key_name = var.ssh_key_pair
 network_interfaces {
  associate_public_ip_address = var.associate_public_ip_address
  security_groups = [aws_security_group.allow_ssh_tcp_ec2.id]
  }
 user_data = filebase64("install_wp.sh")
 tags = {Name = "webserver"}
}




