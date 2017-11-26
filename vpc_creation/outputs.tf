output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_subnet_a_id" {
  value = "${aws_subnet.public_subnet_a.id}"
}

output "public_subnet_b_id" {
  value = "${aws_subnet.public_subnet_b.id}"
}

output "private_subnet_a_id" {
  value = "${aws_subnet.private_subnet_a.id}"
}

output "private_subnet_b_id" {
  value = "${aws_subnet.private_subnet_b.id}"
}

output "security_group_name" {
  value = "${aws_security_group.app.name}"
}

output "instance1_ip" {
  value = "${aws_instance.app1.public_ip}"
}

output "instance2_ip" {
  value = "${aws_instance.app2.public_ip}"
}

output "app_loc" {
  value = "${aws_lb.webserver.dns_name}"
}
