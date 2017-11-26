resource "aws_security_group" "webserver" {
  name        = "${var.environment}-${var.vpc_name}-ws"
  description = "Allow users to connect"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "TCP"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app" {
  name        = "${var.environment}-${var.vpc_name}-app"
  description = "Allow users to connect"
  vpc_id      = "${aws_vpc.vpc.id}"

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

resource "aws_instance" "app1" {
  depends_on              = ["aws_security_group_rule.app_allow_ssh"]
  ami                     = "ami-41c12e23"
  instance_type           = "t2.micro"
  key_name                = "${var.key_name}"
  vpc_security_group_ids  = ["${aws_security_group.app.id}"]
  subnet_id               = "${aws_subnet.public_subnet_a.id}"

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
    script = "./setup.sh"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = "${file(var.key_path)}"
    }
  }
}

resource "aws_instance" "app2" {
  depends_on              = ["aws_security_group_rule.app_allow_ssh"]
  ami                     = "ami-41c12e23"
  instance_type           = "t2.micro"
  key_name                = "${var.key_name}"
  vpc_security_group_ids  = ["${aws_security_group.app.id}"]
  subnet_id               = "${aws_subnet.public_subnet_a.id}"

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
    script = "./setup.sh"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = "${file(var.key_path)}"
    }
  }
}

resource "aws_lb" "webserver" {
  name               = "workshop-webserver-lb"
  subnets            = [
    "${aws_subnet.public_subnet_a.id}",
    "${aws_subnet.public_subnet_b.id}",
  ]
  security_groups = ["${aws_security_group.webserver.id}"]

  tags {
    Name = "${var.environment}-workshop-loadbalancer"
    Environment = "${var.environment}"
  }
}


resource "aws_lb_target_group" "webservers" {
  name     = "workshop-web-target-group"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vpc.id}"

  health_check {
    port      = 8000
    path      = "/hello"
    matcher   = "200"
  }

  tags {
    Name = "${var.environment}-workshop-loadbalancer"
    Environment = "${var.environment}"
  }
}

resource "aws_lb_listener" "webserver" {
  load_balancer_arn = "${aws_lb.webserver.arn}"
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.webservers.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "app1" {
  target_group_arn = "${aws_lb_target_group.webservers.arn}"
  target_id        = "${aws_instance.app1.id}"
  port             = 8000
}

resource "aws_lb_target_group_attachment" "app2" {
  target_group_arn = "${aws_lb_target_group.webservers.arn}"
  target_id        = "${aws_instance.app2.id}"
  port             = 8000
}

