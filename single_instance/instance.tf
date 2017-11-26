provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_security_group" "app" {
  name        = "workshop-app-sg"
  description = "Allow users to connect"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "app_allow_ssh" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "TCP"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.app.id}"
}

resource "aws_security_group_rule" "app_allow_http" {
  type            = "ingress"
  from_port       = 8000
  to_port         = 8000
  protocol        = "TCP"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.app.id}"
}

resource "aws_instance" "app" {
  depends_on      = ["aws_security_group_rule.app_allow_ssh"]
  ami             = "ami-41c12e23"
  instance_type   = "t2.micro"
  key_name        = "${var.key_name}"
  security_groups = ["${aws_security_group.app.name}"]

  provisioner "remote-exec" {
    inline = "mkdir -p /tmp/app"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = "${file(var.key_path)}"
    }
  }

  provisioner "file" {
		source			= "./app/"
		destination	= "/tmp/app/"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = "${file(var.key_path)}"
    }
	}

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/app /",
      "sudo chmod a+rwx /app/*",
    ]

    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = "${file(var.key_path)}"
    }
  }
}

