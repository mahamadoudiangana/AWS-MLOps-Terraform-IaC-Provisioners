# 1. File provisionner: It helps us to copy a file or directory from our local development machine (sources) to a 
# destination Ec2 instance (Destination) 

resource "aws_key_pair" "key" {
  public_key = file("./keys/key.pub")
  key_name   = "instances-key"
  tags = {
    Name = "instances-key"
  }
}

resource "aws_instance" "dev-node" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = aws_key_pair.key.key_name
  subnet_id       = aws_subnet.public-subnet.id
  security_groups = [aws_security_group.public-subnet-sg.id]



  provisioner "file" {
    source = "./test.txt" 
    destination = "/home/ubuntu/test.txt"
  }

  connection {
    type = "ssh"
    host = self.public_ip 
    user        = "ubuntu"
    private_key = file("./keys/key")
    timeout     = "10m"
  }
  tags = {
    Name = "dev-node"
  }

}



# 2. Local-exec provisionner: It helps us to run commands in our local development machine 
resource "aws_key_pair" "key" {
  public_key = file("./keys/key.pub")
  key_name   = "instances-key"
  tags = {
    Name = "instances-key"
  }
}

resource "aws_instance" "dev-node" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = aws_key_pair.key.key_name
  subnet_id       = aws_subnet.public-subnet.id
  security_groups = [aws_security_group.public-subnet-sg.id]



  provisioner "local-exec" {
    command = "touch greetings.py && echo \"print('Hello World')\" > greetings.py" 

    interpreter = ["C:/Program Files/Git/bin/bash.exe", "-c"] 
  }
}




# 3. remote-exec provisionner: It helps us to run commands on our remote machine that is being created

resource "aws_key_pair" "key" {
  public_key = file("./keys/key.pub")
  key_name   = "instances-key"
  tags = {
    Name = "instances-key"
  }
}

resource "aws_instance" "dev-node" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = aws_key_pair.key.key_name
  subnet_id       = aws_subnet.public-subnet.id
  security_groups = [aws_security_group.public-subnet-sg.id]



  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p ~/volumes/mongodb/",
      "sudo touch greetings.py",
      "echo \"print('Hello World')\" | sudo tee greetings.py",
      "sudo cp /home/ubuntu/greetings.py ~/volumes/mongodb/"
    ]
  }

  connection {
    type = "ssh"
    host = self.public_ip 
    user        = "ubuntu"
    private_key = file("./keys/key")
    timeout     = "10m"
  }
  tags = {
    Name = "dev-node"
  }

}