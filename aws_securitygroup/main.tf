# Future Terraform Module :)
#
# Do it yourself!
#----------------------------------------------
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "main" {
  name = "${var.env} Security Group"
  vpc_id = ""

  dynamic "ingress" {
    for_each = lookup(var.allow_port_list, var.env)
    content {

      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-SecurityGroup"
  }
}