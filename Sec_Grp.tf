# Security group to allow SSH & HTTP access to VPC, and allow all traffic from VPC
resource "aws_security_group" "allow_ssh_tcp_ec2" {
 name = "allow_ssh_tcp_ec2"
 description = "Allow SSH & HTTP traffic for EC2"
 vpc_id = aws_vpc.NK_VPC.id
  ingress {
   description      = "allow SSH"
   from_port        = 22
   to_port          = 22
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
   description      = "allow web http"
   from_port        = 80
   to_port          = 80
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
   description      = "allow mySQL"
   from_port        = 3306
   to_port          = 3306
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
   description      = "allow all traffic"
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {Name = "allow_ssh_http_ec2"}
}

resource "aws_security_group" "allow_ssh_tcp_alb" {
 name = "allow_ssh_tcp_alb"
 description = "Allow SSH & HTTP traffic for ALB"
 vpc_id = aws_vpc.NK_VPC.id
  ingress {
   description      = "allow SSH"
   from_port        = 22
   to_port          = 22
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
   description      = "allow web http"
   from_port        = 80
   to_port          = 80
   protocol         = "tcp"
   cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
   description      = "allow all traffic"
   from_port        = 0
   to_port          = 0
   protocol         = "-1"
   cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {Name = "allow_ssh_http_alb"}
}


resource "aws_security_group" "rds_sg" {
 name = "rds_sg"
 description = "Allow 3306 for DB"
 vpc_id = aws_vpc.NK_VPC.id
 ingress {
  from_port       = 3306
  to_port         = 3306
  protocol        = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {Name = "allow_3306_db"}
}
