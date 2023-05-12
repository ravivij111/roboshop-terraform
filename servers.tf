variable "variance_type" {
  default = "t3.small"
}
variable "components" {
  default = {

    frontend = {
      hName ="R1_frontend"
      instance_type = "t3.small"
    }
    mongodb = {
      hName ="R1_mongodb"
    instance_type = "t3.micro"
    }
    catalogue = {
      hName ="R1_catalogue"
      instance_type = "t3.micro"
    }
    redis = {
      hName ="R1_redis"
    instance_type = "t3.small"
    }
    user = {
      hName ="R1_user"
      instance_type = "t3.small"
    }
    cart = {
      hName ="R1_cart"
    instance_type = "t3.small"
    }
    mysql = {
      hName ="R1_mysql"
      instance_type = "t3.small"
    }
    shipping = {
      hName ="R1_shipping"
    instance_type = "t3.medium"
    }
    rabbitmq= {
      hName ="R1_rabbitmq"
      instance_type = "t3.small"
    }
   payment = {
     hName ="R1_payment"
    instance_type = "t3.small"
    }
    dispatch = {
      hName ="R1_dispatch"
      instance_type = "t3.small"
    }
  }

}
data "aws_security_group" "Ravi_Secuity_All" {
  name = "Ravi_Secuity_All"
}

data "aws_ami" "centos" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}

resource "aws_instance" "instance" {
  for_each = var.components
  ami = data.aws_ami.centos.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id ]
  tags = {
    Name = each.value["hName"]
  }
}

resource "aws_route53_record" "records" {
  for_each = var.components
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "${each.value["name"]}-dev.r1devopsb.online"
  #name = "R1_mongodb-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30

   records = [aws_instance.instance[each.value["hName"]].private_ip]
  #records = [ aws_instance.instance[each.value["name"]].private_ip ]
}





output "ami" {
  value = data.aws_ami.centos.image_id
}
/*
resource "aws_instance" "instance" {
  count = length(var.components)
  ami   = data.aws_ami.centos.image_id
  instance_type = var.variance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id ]
  tags = {
    Name = var.components[count.index]
  }
}
*/
#
#resource "aws_instance" "R1_frontend" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.variance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id ]
#  tags = {
#    Name = "R1_frontend"
#  }
#}
#
#resource "aws_route53_record" "R1_frontend" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "frontend-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.R1_frontend.private_ip]
#}
#
#resource "aws_instance" "R1_mongodb" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.variance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "R1_mongodb"
#  }
#}
#
#resource "aws_route53_record" "R1_mongodb" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "mongodb-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.R1_mongodb.private_ip]
#}
#
#
#resource "aws_instance" "R1_Redis" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.variance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "R1_Redis"
#  }
#}
#resource "aws_route53_record" "R1_Redis" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "redis-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.R1_Redis.private_ip]
#}
#
##resource "aws_instance" "R1_catalogue" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.variance_type
##  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
##  tags = {
##    Name = "R1_catalogue"
##  }
##}
#resource "aws_route53_record" "R1_catalogue" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "catalogue-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.R1_catalogue.private_ip]
#}
#
#resource "aws_instance" "R1_cart" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.variance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "R1_cart"
#  }
#}
#resource "aws_route53_record" "R1_cart" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "cart-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.R1_cart.private_ip]
#}
#
#resource "aws_instance" "R1_user" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.variance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "R1_user"
#  }
#}
#resource "aws_route53_record" "R1_user" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "user-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.R1_user.private_ip]
#}
#
#resource "aws_instance" "R1_mysql" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.variance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "R1_mysql"
#  }
#}
#resource "aws_route53_record" "R1_mysql" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "mysql-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.R1_mysql.private_ip]
#}
#
#resource "aws_instance" "R1_shipping" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.variance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "R1_shipping"
#  }
#}
#resource "aws_route53_record" "R1_shipping" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "shipping-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.R1_shipping.private_ip]
#}
#
#resource "aws_instance" "R1_rabbitmq" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.variance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "R1_rabbitmq"
#  }
#}
#resource "aws_route53_record" "R1_rabbitmq" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "rabbitmq-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.R1_rabbitmq.private_ip]
#}
#
#resource "aws_instance" "R1_payment" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = var.variance_type
#  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
#  tags = {
#    Name = "R1_payment"
#  }
#}
#resource "aws_route53_record" "R1_payment" {
#  zone_id = "Z09746683LPCR02M9AALO"
#  name    = "payment-dev.r1devopsb.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.R1_payment.private_ip]
#}
#
#output "R1_Payment" {
#  value = aws_instance.R1_payment.public_ip
#}