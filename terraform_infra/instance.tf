resource "aws_key_pair" "tbox_kp" {
    key_name = "jk_kp01"
    public_key = "${file("${var.public_keys}")}"
}


## Jenkins+Jumbox instance check
resource "aws_instance" "toolbox_01" {
  ami = "${data.aws_ami.tbox_ami.image_id}"
  instance_type = "t2.medium"
  subnet_id = "${element(module.vpc.public_subnets,0)}"
  vpc_security_group_ids = ["${aws_security_group.tbox_sg.id}", "${aws_security_group.tbox_jk_sg.id}"]
  key_name = "${aws_key_pair.tbox_kp.id}"

  # provisioner "file" {
  #   source = "./docker.service"
  #   destination = "/tmp/"
  # }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo systemctl restart docker",
      "docker pull jenkins/jenkins",
      # "sudo cp -rf /tmp/docker.service /usr/lib/systemd/system/docker.service",
      "sudo chown root:root /usr/lib/systemd/system/docker.service ; sudo chmod 0644 /usr/lib/systemd/system/docker.service",
      "sudo systemctl restart docker",
      "docker run -d -p 8080:8080 -v $HOME/jenkins_home:/tmp/jenkins_home --name jenkins_master jenkins/jenkins"
    ]
  }

  connection {
    type = "ssh"
    user = "centos"
    private_key = "${file("${var.private_key}")}"
    timeout = "3m"
  }

  tags {
    Name = "Jenkins+Jmp"
  }
}

output "jmp_ip" {
  value = "${aws_instance.toolbox_01.public_ip}"
}
