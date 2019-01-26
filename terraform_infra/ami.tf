# Get our latest ami based on status and tag name
data "aws_ami" "tbox_ami" {
  most_recent = true

  filter {
    name = "state"
    values = ["available"]
  }

  filter {
    name = "tag:environment"
    values = ["tbox_dev"]
  }
}
