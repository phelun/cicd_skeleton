resource "aws_security_group" "tbox_sg" {
  #vpc_id = "${aws_vpc.main.id}"
  vpc_id = "${module.vpc.vpc_id}"
  name = "jmp-ssh"
  description = "Toolbox Env"

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }


  tags {
    Name      = "dev_ssh_sg"
    Terraform = "true"
  }
}

resource "aws_security_group" "tbox_jk_sg" {
  vpc_id = "${module.vpc.vpc_id}"
  name = "jenkins-cicd"
  description = "Toolbox Env"

  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      #allowing access from our example instance
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      self = true
  }

  tags {
    Name      = "dev_jenkins_sg"
    Terraform = "true"
  }
}
