# tf-squid-proxy-module
A terraform module to create AWS instance with Squid in normal proxy mode

# Dependency

- Require AWS provider
- Require initialization of provider and corresponding ENV variable
setting

See [installation](#installation) section below  for more details

## Inputs
- **name** *[String]* - name of resource
- **ami** *[String]* - AMI to sue for the instance
- **subnet_id** *[String]* - Subnet ID
- **instance_type** *[String]* - type of the instance
- **security_groups** *[String]* - security group to start instance in
- **max_servers** *[String]* - how many identical servers to start
- **proxy_port** *[String]* - proxy port to listen on
- **key_name** *[String]* - name of the SSH key
- **key_path** *[String]* - path of the SSH key to deploy on host

## Outputs
- **public_dns** *[String]* -  Full FQDN name for the instance(s), possibly list
- **public_ips** *[String]* -  List of the public IPS associated with  instance(s)
- **private_ips** *[String]* -  List of the private IPS associated with  instance(s)

# Installation

## Prepare authentication credentials
- Beforehand, you will need to have SSH RSA key available at the default location :
 - `~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`
 > This key is going to be used later to connect to the instance where TFE will be running.

- Prepare AWS auth credentials (You can create security credentials on [this page](https://console.aws.amazon.com/iam/home?#security_credential).) To export them via env variables, execute in the command line :
 ```
 export AWS_ACCESS_KEY_ID="YOUR ACCESS KEY"
 export AWS_SECRET_ACCESS_KEY="YOUR SECRET KEY"
 ```
- AWS provider init :
```terraform
provider "aws" {
  profile = "default"
}
```

# Examples 

Check [examples folder](examples/README.md)

# TODO
- [ ] update main README 