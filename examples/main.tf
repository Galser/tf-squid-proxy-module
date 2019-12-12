# Example of usage of squidproxy module
resource "aws_key_pair" "sshkey" {
  key_name = "ag-test-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "squidproxy" {
  #source                = "github.com/Galser/tf-squid-proxy-module"
  source          = "../"
  name            = "test"
  ami             = var.amis[var.region]
  instance_type   = var.instance_type
  subnet_id       = var.subnet_ids[var.region]
  security_groups = [var.vpc_security_group_ids[var.region]]

  proxy_port = "3128"
  key_name   = aws_key_pair.sshkey.id
  key_path   = "~/.ssh/id_rsa"
}


