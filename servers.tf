resource "aws_instance" "R1_frontend" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"

  tags = {
    Name = "R1_frontend"
  }
}


resource "aws_instance" "R1_mongod" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"

  tags = {
    Name = "R1_mongodb"
  }
}

resource "aws_instance" "R1_Redis" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"

  tags = {
    Name = "R1_Redis"
  }
}

resource "aws_instance" "R1_catalogue" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"

  tags = {
    Name = "R1_catalogue"
  }
}

resource "aws_instance" "R1_cart" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"

  tags = {
    Name = "R1_cart"
  }
}

resource "aws_instance" "R1_user" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"

  tags = {
    Name = "R1_user"
  }
}

resource "aws_instance" "R1_mysql" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"

  tags = {
    Name = "R1_mysql"
  }
}

resource "aws_instance" "R1_shipping" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"

  tags = {
    Name = "R1_shipping"
  }
}

resource "aws_instance" "R1_rabbitmq" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"

  tags = {
    Name = "R1_rabbitmq"
  }
}

resource "aws_instance" "R1_payment" {
  ami           = "ami-0b5a2b5b8f2be4ec2"
  instance_type = "t3.micro"

  tags = {
    Name = "R1_payment"
  }
}

output "R1_Payment" {
  value = aws_instance.R1_payment.public_ip
}