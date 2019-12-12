# Outputs for Nginxweb , demo module

output "public_ips" {
  value = "${aws_instance.squidproxy[*].public_ip}"
}

output "public_dns" {
  value = "${aws_instance.squidproxy[*].public_dns}"
}
