variable "name" {
  type        = string
  description = "Name for tags and etc"
}
variable "ami" {}
variable "subnet_id" {}
variable "instance_type" {}
variable "security_groups" {}
variable "max_servers" {
  default = "1"
}
# SSL settings
#variable "cert_private_key_pem" {}
#variable "cert_pem" {}
#variable "cert_bundle" {}
# URL where we should send requests
variable "proxy_port" {
  default = "3128"
}
#variable "server_name" {}
variable "key_name" {
  type        = string
  description = "SSH Key ID  , stored in AWS"
}
variable "key_path" {
  description = "Local SSH key path (private part)"
}
