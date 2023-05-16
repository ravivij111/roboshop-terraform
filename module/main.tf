
resource "aws_instance" "instance" {
  for_each               = var.components
  ami                    = data.aws_ami.centos.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.Ravi_Secuity_All.id]
  tags                   = {
    Name = var.component_name
  }
}

resource "aws_route53_record" "records" {

  zone_id = "Z09746683LPCR02M9AALO"
  name    = "{var.component_name}-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30

  records = [aws_instance.instance[each.value["name"]].private_ip]
}
resource "null_resource" "provisioner" {
  depends_on = [aws_route53_record.records]
   provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     =  aws_instance.instance.private_ip
    }

    inline = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/ravivij111/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${var.component_name}.sh ${var.password}"
    ]
  }
}
/*
output "ami" {
  value = data.aws_ami.centos.image_id
}
resource "aws_instance" "instance" {
  count = length(var.components)
  ami   = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id ]
  tags = {
    Name = var.components[count.index]
  }
}

resource "aws_instance" "frontend" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id ]
  tags = {
    Name = "frontend"
  }
}

resource "aws_route53_record" "frontend" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "frontend-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}

resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
  tags = {
    Name = "mongodb"
  }
}

resource "aws_route53_record" "mongodb" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "mongodb-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.mongodb.private_ip]
}

output "Payment" {
  value = aws_instance.payment.public_ip
}*/



