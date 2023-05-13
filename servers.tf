
resource "aws_instance" "instance" {
  for_each = var.components
  ami = data.aws_ami.centos.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id ]
  tags = {
    Name = each.value["name"]
  }

  provisioner "remote-exec" {
      connection {
        type     = "ssh"
        user     = "centos"
        password = "DevOps321"
        host     = self.private_ip
      }

        inline = [
          "rm -rf roboshop-shell",
          "git clone https://github.com/ravivij111/roboshop-shell.git",
          "cd roboshop-shell",
          "sudo bash ${each.value["name"]}.sh}"
        ]
      }
}

resource "aws_route53_record" "records" {
  for_each = var.components
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "${each.value["name"]}-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30

   records = [aws_instance.instance[each.value["name"]].private_ip]
  #records = [ aws_instance.instance[each.value["name"]].private_ip ]
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
*/
#
#resource "aws_instance" "frontend" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id ]
#  tags = {
#    Name = "frontend"
#  }
#}
#
#resource "aws_route53_record" "frontend" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "frontend-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.frontend.private_ip]
#}
#
#resource "aws_instance" "mongodb" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "mongodb"
#  }
#}
#
#resource "aws_route53_record" "mongodb" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "mongodb-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.mongodb.private_ip]
#}
#
#
#resource "aws_instance" "Redis" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "Redis"
#  }
#}
#resource "aws_route53_record" "Redis" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "redis-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.Redis.private_ip]
#}
#
##resource "aws_instance" "catalogue" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
##  tags = {
##    Name = "catalogue"
##  }
##}
#resource "aws_route53_record" "catalogue" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "catalogue-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.catalogue.private_ip]
#}
#
#resource "aws_instance" "cart" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "cart"
#  }
#}
#resource "aws_route53_record" "cart" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "cart-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.cart.private_ip]
#}
#
#resource "aws_instance" "user" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "user"
#  }
#}
#resource "aws_route53_record" "user" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "user-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.user.private_ip]
#}
#
#resource "aws_instance" "mysql" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "mysql"
#  }
#}
#resource "aws_route53_record" "mysql" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "mysql-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.mysql.private_ip]
#}
#
#resource "aws_instance" "shipping" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "shipping"
#  }
#}
#resource "aws_route53_record" "shipping" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "shipping-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.shipping.private_ip]
#}
#
#resource "aws_instance" "rabbitmq" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "rabbitmq"
#  }
#}
#resource "aws_route53_record" "rabbitmq" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "rabbitmq-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.rabbitmq.private_ip]
#}
#
#resource "aws_instance" "payment" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.instance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "payment"
#  }
#}
#resource "aws_route53_record" "payment" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "payment-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.payment.private_ip]
#}
#
#output "Payment" {
#  value = aws_instance.payment.public_ip
#}