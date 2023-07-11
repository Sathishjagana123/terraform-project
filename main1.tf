# This file consists of code for instances and security groups
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAXQUTZL5JZKBHCQ7W"
  secret_key = "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"
}

resource "aws_instance" "one" {
  ami                    = "ami-04823729c75214919"
  instance_type          = "t2.micro"
  key_name               = "n-virgenia"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone      = "us-east-1a"
  
  user_data = <<-EOF
    #!/bin/bash
    sudo -i
    yum install -y httpd tree

    systemctl start httpd
    chkconfig httpd on

    # Include your 4000 lines of code here
    $(cat /home/ec2-user/Desktop/terraform\ htmls/index.html)
  EOF

  tags = {
    Name = "web-serverr-1"
  }
}

resource "aws_instance" "two" {
  ami                    = "ami-04823729c75214919"
  instance_type          = "t2.micro"
  key_name               = "n-virgenia"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone      = "us-east-1b"
  
  user_data = <<-EOF
    #!/bin/bash
    sudo -i
    yum install -y httpd tree

    systemctl start httpd
    chkconfig httpd on

    # Include your 4000 lines of code here
    $(cat /home/ec2-user/Desktop/terraform\ htmls/CYIENT)
  EOF

  tags = {
    Name = "web-serverr-2"
  }
}

resource "aws_instance" "three" {
  ami                    = "ami-04823729c75214919"
  instance_type          = "t2.micro"
  key_name               = "n-virgenia"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone      = "us-east-1a"
  
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami                    = "ami-04823729c75214919"
  instance_type          = "t2.micro"
  key_name               = "n-virgenia"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone      = "us-east-1b"
  
  tags = {
    Name = "app-server-2"
  }
}

resource "aws_security_group" "five" {
  name = "elb-sg"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "six" {
  bucket = "satishterrabucketjagana"
}

resource "aws_iam_user" "seven" {
  for_each = var.user_names
  name     = each.value
}

variable "user_names" {
  description = "*"
  type        = set(string)
  default     = ["bhavitha", "shirisha", "pavani", "chinni"]
}

resource "aws_ebs_volume" "eight" {
  availability_zone = "us-east-1a"
  size              = 40
  
  tags = {
    Name = "ebs-001"
  }
}
