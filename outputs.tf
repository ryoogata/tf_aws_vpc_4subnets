output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "subnet1a_DMZ_id" {
  value = "${aws_subnet.subnet1a_DMZ.id}"
}

output "subnet1c_DMZ_id" {
  value = "${aws_subnet.subnet1c_DMZ.id}"
}

output "subnet1a_TRUST_id" {
  value = "${aws_subnet.subnet1a_TRUST.id}"
}

output "subnet1c_TRUST_id" {
  value = "${aws_subnet.subnet1c_TRUST.id}"
}
