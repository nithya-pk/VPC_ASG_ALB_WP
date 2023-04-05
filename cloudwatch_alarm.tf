resource "aws_autoscaling_policy" "asg_grp_policy_up" {
 name = "asg_grp_policy_up"
 # number of instances by which to scale.
 scaling_adjustment = 1
 adjustment_type = "ChangeInCapacity"
 # seconds after a scaling completes and next scaling starts
 cooldown = 300
 autoscaling_group_name = "${aws_autoscaling_group.asg_nk.name}"
}

# Creating CLoudwatch Alarm that will scale up instances based on CPU utilization
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
 alarm_name = "web_cpu_alarm_up"
 alarm_description = "Metric monitor EC2 CPU utilization"
 comparison_operator = "GreaterThanOrEqualToThreshold"
 evaluation_periods = "2"
 metric_name = "CPU_Utilization"
 namespace = "AWS/EC2"
 period = "60"
 statistic = "Average"
 threshold = "60"
 alarm_actions = ["${aws_autoscaling_policy.asg_grp_policy_up.arn}"]
 dimensions = {AutoScalingGroupName = "${aws_autoscaling_group.asg_nk.name}"}
 tags = {Name = "web_cpu_alarm_up"}
}

resource "aws_autoscaling_policy" "asg_grp_policy_down" {
 name = "asg_grp_policy_down"
 # number of instances by which to scale.
 scaling_adjustment = -1
 adjustment_type = "ChangeInCapacity"
 # seconds after a scaling completes and next scaling starts
 cooldown = 300
 autoscaling_group_name = "${aws_autoscaling_group.asg_nk.name}"
}

# Creating CLoudwatch Alarm that will scale up instances based on CPU utilization
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
 alarm_name = "web_cpu_alarm_down"
 alarm_description = "Metric monitor EC2 CPU utilization"
 comparison_operator = "LessThanOrEqualToThreshold"
 evaluation_periods = "2"
 metric_name = "CPU_Utilization"
 namespace = "AWS/EC2"
 period = "60"
 statistic = "Average"
 threshold = "10"
 alarm_actions = ["${aws_autoscaling_policy.asg_grp_policy_down.arn}"]
 dimensions = {AutoScalingGroupName = "${aws_autoscaling_group.asg_nk.name}"}
 tags = {Name = "web_cpu_alarm_up"}
}