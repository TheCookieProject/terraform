terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_instance" "example" {
	ami = "ami-0c2d06d50ce30b442"
	instance_type = "t2.micro"
    tags = {
		Name = "Server EC2"
	}
}

# to-do -> security gropups and provision 



