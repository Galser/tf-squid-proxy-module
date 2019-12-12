## Example usage 

This how-to demonstrates usage of "tf-squid-proxy-module" module (https:/github.com/Galser/tf-squid-proxy-module)

- Let's define sample main code, in file [main.tf](main.tf) :
    ```terraform
    # Example of usage of squidproxy module
    resource "aws_key_pair" "sshkey" {
      key_name = "ag-test-key"
      public_key = file("~/.ssh/id_rsa.pub")
    }

    module "squidproxy" {
      source          = "github.com/Galser/tf-squid-proxy-module"
      name            = "test"
      ami             = var.ami
      instance_type   = var.instance_type
      subnet_id       = var.subnet_ids
      security_groups = var.security_group_ids

      proxy_port = "3128"
      key_name   = aws_key_pair.sshkey.id
      key_path   = "~/.ssh/id_rsa"
    }

    ```
    > Note - first line is reference this repository, to be included as Terraform module.
    > it assumes some defaults :
    > - that you have SSH key located in files "~/.ssh/id_rsa" and "~/.ssh/id_rsa.pub"
    > - that you want to deploy 1 instance 

- We will need to specify those minimal set of the input parameters, here my values below for test :
    ```terraform
    variable "region" {
      default = "eu-central-1"
    }

    variable "subnet_ids" {
      type = "map"
      default = {
          "eu-central-1" = "subnet-7282ce1a"
      }
    }

    variable "amis" {
      type = "map"
      default = {
          "us-east-2"    = "ami-00f03cfdc90a7a4dd",
          "eu-central-1" = "ami-08a162fe1419adb2a"
      }
    }

    variable "vpc_security_group_ids" {
      type = "map"
      default = {
          "us-east-2"    = "sg-435345ce45e345343" # sg not tested 
          "eu-central-1" = "sg-04c059aea335d8f69" # sg tested
      }
    }

    variable "instance_type" {
      default = "t2.micro"
    }
    ```
- Now, we are going to use AWS provider, let's define, file [provider_aws.tf](provider_aws.tf) :
    ```terraform
    provider "aws" {
      profile    = "default"
      region     = "${var.region}"
    }
    ```
- And the last step - our outputs, if we want to see in a nice way, how to connect to our servers. Define them in [outputs.tf](outputs.tf) :
    ```terraform
    output "public_ips" {
      value = "${module.squidproxy.public_ips}"
    }

    output "public_dns" {
      value = "${module.squidproxy.public_dns}"
    }
    ```
- Before using `apply` for first time with above mentioned code we need to inform terraform about our module. Execute :
    ```
    terraform init
    ```
    Output :
    ```
    ...
    ```
- Now let's apply our code changes : 
    ```
    terraform apply
    ```
    Output :
    ```
    ...
    module.squidproxy.aws_instance.squidproxy[0]: Provisioning with 'remote-exec'...
    module.squidproxy.aws_instance.squidproxy[0] (remote-exec): Connecting to remote host via SSH...
    module.squidproxy.aws_instance.squidproxy[0] (remote-exec):   Host: 52.59.107.205
    module.squidproxy.aws_instance.squidproxy[0] (remote-exec):   User: ubuntu
    module.squidproxy.aws_instance.squidproxy[0] (remote-exec):   Password: false
    module.squidproxy.aws_instance.squidproxy[0] (remote-exec):   Private key: true
    module.squidproxy.aws_instance.squidproxy[0] (remote-exec):   Certificate: false
    module.squidproxy.aws_instance.squidproxy[0] (remote-exec):   SSH Agent: true
    module.squidproxy.aws_instance.squidproxy[0] (remote-exec):   Checking Host Key: false
    module.squidproxy.aws_instance.squidproxy[0] (remote-exec): Connected!
    module.squidproxy.aws_instance.squidproxy[0]: Still creating... [1m11s elapsed]
    module.squidproxy.aws_instance.squidproxy[0]: Still creating... [1m21s elapsed]
    module.squidproxy.aws_instance.squidproxy[0]: Still creating... [1m31s elapsed]
    module.squidproxy.aws_instance.squidproxy[0]: Still creating... [1m41s elapsed]
    module.squidproxy.aws_instance.squidproxy[0]: Creation complete after 1m42s [id=i-0e917f973e1630da8]

    Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

    Outputs:

    public_dns = [
      "ec2-52-59-107-205.eu-central-1.compute.amazonaws.com",
    ]
    public_ips = [
      "52.59.107.205",
    ]    
    ```
    So, the module had created and provisioned 1 running Squid proxy on priovate IP address and port 3128 
- As the last step run `destroy` to clean:
    ```
    terraform destroy
    ```
    Output:
    ```
    ...
    module.squidproxy.aws_instance.squidproxy[0]: Destroying... [id=i-0e917f973e1630da8]
    module.squidproxy.aws_instance.squidproxy[0]: Still destroying... [id=i-0e917f973e1630da8, 10s elapsed]
    module.squidproxy.aws_instance.squidproxy[0]: Still destroying... [id=i-0e917f973e1630da8, 20s elapsed]
    module.squidproxy.aws_instance.squidproxy[0]: Still destroying... [id=i-0e917f973e1630da8, 30s elapsed]
    module.squidproxy.aws_instance.squidproxy[0]: Still destroying... [id=i-0e917f973e1630da8, 40s elapsed]
    module.squidproxy.aws_instance.squidproxy[0]: Still destroying... [id=i-0e917f973e1630da8, 50s elapsed]
    module.squidproxy.aws_instance.squidproxy[0]: Still destroying... [id=i-0e917f973e1630da8, 1m0s elapsed]
    module.squidproxy.aws_instance.squidproxy[0]: Destruction complete after 1m0s
    aws_key_pair.sshkey: Destroying... [id=ag-test-key]
    aws_key_pair.sshkey: Destruction complete after 1s

    Destroy complete! Resources: 2 destroyed.
    ```
This concludes the "Example usage" section. Thank you.


