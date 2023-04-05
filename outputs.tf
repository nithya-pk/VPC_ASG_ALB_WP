output "VPCName" {
 value = aws_vpc.NK_VPC.id
 description = "Name of the VPC"
}

output "rds_address" {
 value = aws_db_instance.rds_db.address
 description = "RDS DB Address"
}

output "rds_dbname" {
  value = var.dbname
  description = "RDS DB Name"
}

output "rds_endpoint" {
 value = aws_db_instance.rds_db.endpoint
 description = "RDS DB Endpoint"
}

output "launch_template_id" {
 value = aws_launch_template.ec2_lt.id
 description = "Launch Template ID"
}

output "launch_template_name" {
 value = aws_launch_template.ec2_lt.name
 description = "Launch Template Name"
}

output "app_lb_name" {
 value = aws_alb.alb.id
 description = "App_LB Name"
}