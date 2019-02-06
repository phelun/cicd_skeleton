provider "aws" {
  region = "eu-west-1"
  profile = "london"
}

module "vpc" {
  source = "tools_mod/terraform-aws-vpc/"
  name = "dev-dc"
  cidr = "192.168.0.0/16"
  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  public_subnets  = ["192.168.101.0/24", "192.168.102.0/24", "192.168.103.0/24"]
  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# module "efs" {
#   source     = "git::https://github.com/cloudposse/terraform-aws-efs.git?ref=master"
#   namespace  = "global"
#   name       = "app"
#   stage      = "prod"
#   attributes = ["efs"]
#
#   aws_region         = "${var.aws_region}"
#   vpc_id             = "${module.vpc.vpc_id}"
#   subnets            = "${module.vpc.private_subnets}"
#   availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
#   security_groups    = ["${aws_security_group.tbox_jk_sg.id}"]
#
#   zone_id = "${var.aws_route53_dns_zone_id}"
# }

variable "aws_route53_dns_zone_id" {
  default = "Z2QUZ4EI4RFWBO"
}

variable "aws_region" {
  default = "eu-west-1"
}
