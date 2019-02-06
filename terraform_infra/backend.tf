
terraform {
  backend "s3" {
    bucket = "all-stack-buck-template"
    key    = "toolbox_dev/tbox_dev.tfstate"
    region = "eu-west-1"
  }
}
