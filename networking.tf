# 1. Create a VPC
resource "aws_vpc" "mlops-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-vpc"
  }
}


# 2. Create Subnets:
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.mlops-vpc.id
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true 

  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public-subnet"
  }
}



# 3. Create an Internet Gateway:
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mlops-vpc.id

  tags = {
    Name = "mlops-vpc-igw"
  }
}



# 5. Route Tables
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.mlops-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id 
  }

  tags = {
    Name = "public-route-table"
  }
}


resource "aws_route_table_association" "public-route-table-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet.id
}



# 6. Security group to allow ssh access to the public subnet instances
resource "aws_security_group" "public-subnet-sg" {
  # name        = "mlops-public-subnet-sg"
  description = "Allow ssh access to instances in the public subnet"
  vpc_id      = aws_vpc.mlops-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip] 
  }

  # Allow ICMP (ping) traffic from my home router public IP
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [var.my_public_ip] 
  }

  # Allow http (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip] # "0.0.0.0/0"
  }

  # Allow https (port 443)


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-subnet-sg"
  }
}
