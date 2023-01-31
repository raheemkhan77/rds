 ## create a vpc name testvpc 
 ## create EC2 in default vpc 
 resource "aws_vpc" "testvpc" {
    cidr_block = "10.10.0.0/16"
    instance_tenancy = "default"
    tags = {
      "Name" = "testvpc"
    }
 }


 ## creating subnet1
 resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.testvpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "subnet1"
  }
}

## creating subnet2 
 resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.testvpc.id # create in default VPC
  cidr_block        = "10.10.2.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "subnet2"
  }
}

## creating Ec2 instance
resource "aws_instance" "devec2" {
  ami           = "ami-005e54dee72cc1d00" # ap-south-1
  instance_type = "m5.xlarge"
  enable_dns_hostnames = true
  associate_public_ip_address = true
  availability_zone = "aws_subnet.subnet1"
  key_name = "APPTRack"
  count         = "2"
  
}

## security Group Allow
resource "aws_security_group" "webaccess"{
  name        = "webaccess"
  description = "Allow inbound all https"
  vpc_id      = aws_vpc.main.id
}
  ingress {
    description      = "webacess"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.testvpc.cidr_block]
     
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    

  tags = {
    Name = "webaccess"
  }
}