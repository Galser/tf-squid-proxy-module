# Module that deploys AWS instance and provision Squid proxy server 
# ? With SSL 
# Require AMazon provider defined + some RS SSH key


resource "aws_instance" "squidproxy" {
  count                  = "${var.max_servers}"
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups
  key_name               = var.key_name

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file("${var.key_path}")}"
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    script = "${path.module}/scripts/provision.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sed -i '/ALLOW ACCESS FROM YOUR CLIENTS/a http_access allow all' /etc/squid/squid.conf",
      "sudo sed -i 's/http_port 3128/http_port ${self.private_ip}:3128/' /etc/squid/squid.conf",
      "sudo systemctl restart squid"
    ]
  }

  tags = {
    "Name"      = "${var.name} ${count.index} / ${var.max_servers}",
    "andriitag" = "true",
  }
}

