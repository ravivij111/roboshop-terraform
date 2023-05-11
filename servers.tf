variable "variance_type" {
  default = "t3.small"
}
data "aws_ami" "centos" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}

data "aws_security_group" "Ravi_Secuity_All" {
  name = "Ravi_Secuity_All"
}

output "ami" {
  value = data.aws_ami.centos.image_id
}

resource "aws_instance" "R1_frontend" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.variance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id ]
  tags = {
    Name = "R1_frontend"
  }
}

resource "aws_route53_record" "R1_frontend" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "frontend-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.R1_frontend.private_ip]
}

resource "aws_instance" "R1_mongodb" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.variance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id]
  tags = {
    Name = "R1_mongodb"
  }
}

resource "aws_route53_record" "R1_mongodb" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "mongodb-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.R1_mongodb.private_ip]
}


resource "aws_instance" "R1_Redis" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.variance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All]
  tags = {
    Name = "R1_Redis"
  }
}
resource "aws_route53_record" "R1_Redis" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "redis-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.R1_Redis.private_ip]
}

resource "aws_instance" "R1_catalogue" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.variance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All]
  tags = {
    Name = "R1_catalogue"
  }
}
resource "aws_route53_record" "R1_catalogue" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "catalogue-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.R1_catalogue.private_ip]
}

resource "aws_instance" "R1_cart" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.variance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All]
  tags = {
    Name = "R1_cart"
  }
}
resource "aws_route53_record" "R1_cart" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "cart-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.R1_cart.private_ip]
}

resource "aws_instance" "R1_user" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.variance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All]
  tags = {
    Name = "R1_user"
  }
}
resource "aws_route53_record" "R1_user" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "user-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.R1_user.private_ip]
}

resource "aws_instance" "R1_mysql" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.variance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All]
  tags = {
    Name = "R1_mysql"
  }
}
resource "aws_route53_record" "R1_mysql" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "mysql-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.R1_mysql.private_ip]
}

resource "aws_instance" "R1_shipping" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.variance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All]
  tags = {
    Name = "R1_shipping"
  }
}
resource "aws_route53_record" "R1_shipping" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "shipping-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.R1_shipping.private_ip]
}

resource "aws_instance" "R1_rabbitmq" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.variance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All]
  tags = {
    Name = "R1_rabbitmq"
  }
}
resource "aws_route53_record" "R1_rabbitmq" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "rabbitmq-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.R1_rabbitmq.private_ip]
}

resource "aws_instance" "R1_payment" {
  ami           = data.aws_ami.centos.image_id
  instance_type = var.variance_type
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All]
  tags = {
    Name = "R1_payment"
  }
}
resource "aws_route53_record" "R1_payment" {
  zone_id = "Z09746683LPCR02M9AALO"
  name    = "payment-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.R1_payment.private_ip]
}

output "R1_Payment" {
  value = aws_instance.R1_payment.public_ip
}