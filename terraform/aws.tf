# specify the cloud provider and region
provider "aws" {
  region     = "us-west-2"
}

# specify the key pair
variable "ami_key_pair" {
  type = string
  default = "sepehr_key"
}

# ask user to enter IP in the format of 0.0.0.0/0
variable "user_ip"  {}

# create the vpc
resource "aws_vpc" "sepehr_vpc" {
  cidr_block = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
      Name = "sepehr_vpc"
    }
}

# create a security group that allows ssh on the users IP
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH"
  vpc_id      = aws_vpc.sepehr_vpc.id

  ingress {
    description = "SSH to VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.user_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create the subnet in the vpc and specify the availability zone
resource "aws_subnet" "sepehr_subnet1" {
  vpc_id = aws_vpc.sepehr_vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
      Name = "sepehr_subnet1"
    }
}

# create the first nic with the security group that allows ssh applied to it
resource "aws_network_interface" "sepehr_interface1" {
  subnet_id = aws_subnet.sepehr_subnet1.id
  security_groups = [aws_security_group.allow_ssh.id]

  tags = {
      Name = "sepehr_interface1"
    }
}

# create the second nic with the security group that allows ssh applied to it
resource "aws_network_interface" "sepehr_interface2" {
  subnet_id = aws_subnet.sepehr_subnet1.id
  security_groups = [aws_security_group.allow_ssh.id]

  tags = {
      Name = "sepehr_interface2"
    }
}

# create the first ec2, specifying the ami, key name, and the instance type. also attaching the nic to it
resource "aws_instance" "ubuntu1" {
  ami = "ami-0ca5c3bd5a268e7db"
  key_name = var.ami_key_pair
  instance_type = "t2.micro"
  

  network_interface {
    network_interface_id = aws_network_interface.sepehr_interface1.id
    device_index = 0
  }

  tags = {
      Name = "ubuntu1"
    }
}

# create the second ec2, specifying the ami, key name, and the instance type. also attaching the nic to it
resource "aws_instance" "ubuntu2" {
  ami = "ami-0ca5c3bd5a268e7db"
  key_name = var.ami_key_pair
  instance_type = "t2.micro"
  

  network_interface {
    network_interface_id = aws_network_interface.sepehr_interface2.id
    device_index = 0
  }

  tags = {
      Name = "ubuntu2"
    }
}

# create the internet gateway
resource "aws_internet_gateway" "sepehr_gateway" {
  vpc_id = aws_vpc.sepehr_vpc.id

  tags = {
    Name = "main"
  }
}

# create the first elastic IP
resource "aws_eip" "sepehr_eip1" {
  instance = aws_instance.ubuntu1.id
  vpc      = true

  tags = {
      Name = "sepehr_eip1"
    }
}

# create the second elastic IP
resource "aws_eip" "sepehr_eip2" {
  instance = aws_instance.ubuntu2.id
  vpc      = true

  tags = {
      Name = "sepehr_eip2"
    }
}

# create the route table
resource "aws_route_table" "sepehr_route_table" {
  vpc_id = aws_vpc.sepehr_vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.sepehr_gateway.id
    }

  tags = {
      Name = "sepehr"
    }
}

# create the route table association and link it to the subnet and route table
resource "aws_route_table_association" "sepehr_rta" {
  subnet_id      = aws_subnet.sepehr_subnet1.id
  route_table_id = aws_route_table.sepehr_route_table.id
}

# below I list all the outputs asked in the assignment after everything has been created
output "Public_IP_of_ubuntu1" {
  value = aws_instance.ubuntu1.*.sepehr_eip1 

}

output "Private_IP_of_ubuntu1" {
  value = aws_instance.ubuntu1.*.private_ip 

}

output "Public_IP_of_ubuntu2" {
  value = aws_instance.ubuntu2.*.sepehr_eip2
}

output "Private_IP_of_ubuntu2" {
  value = aws_instance.ubuntu2.*.private_ip 

}