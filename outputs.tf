# Outputs for SquidProxy module

output "public_ips" {
  value = "${aws_instance.squidproxy[*].public_ip}"
}

output "private_ip" {
  value = "${aws_instance.squidproxy[*].private_ip}"
}

output "public_dns" {
  value = "${aws_instance.squidproxy[*].public_dns}"
}
