/*
module "database-servers" {
  for_each = var.database_servers
  source = "./module"
  component_name = each.value["name"]
  env = var.env
  instance_type = "t3.micro"
  password = lookup(each.value,"password",null)
  provisioner = true
  app_type ="db"
}

module "app-servers" {
  for_each = var.app_servers
  source = "./module"
  component_name = each.value["name"]
  env = var.env
  instance_type = "t3.micro"
  password = lookup(each.value,"password",null)
  provisioner = true
  app_type ="app"
}*/

/*
module "servers" {
  source = "./module"
  for_each = var.components
  component_name = each.value["name"]
  env = var.env
  instance_type = "t3.micro"
  password = lookup(each.value,"password",null)
}*/


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

#ami-0b5a2b5b8f2be4ec2
variable "instance_type" {
  default = "t2.micro"
}

variable "hosted_zone_id" {
  default = "Z09194283TYN817J8N83P"
}

variable "components" {
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.micro"
    }
    mongodb = {
      name = "mongodb"
      instance_type = "t3.micro"
    }

    catalogue = {
      name = "catalogue"
      instance_type = "t3.micro"
    }
    redis = {
      name = "redis"
      instance_type = "t3.micro"
    }
    user = {
      name = "user"
      instance_type = "t3.micro"
    }
    cart = {
      name = "cart"
      instance_type = "t3.micro"
    }
    mysql = {
      name = "mysql"
      instance_type = "t3.micro"
    }
    shipping = {
      name = "shipping"
      instance_type = "t3.micro"
    }
    rabbitmq = {
      name = "rabbitmq"
      instance_type = "t3.micro"
    }
    payment = {
      name = "payment"
      instance_type = "t3.micro"
    }
  }

}

resource "aws_instance" "instance" {
   for_each = var.components
  ami           = data.aws_ami.centos.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids  = [ data.aws_security_group.Ravi_Secuity_All.id ]
  tags = {
    Name = each.value["name"]
  }
}

resource "aws_route53_record" "records" {
  for_each = var.components
  zone_id = var.hosted_zone_id
  name    =    "${each.value["name"]}-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.value["name"]].private_ip]
}


data "aws_ami" "centos" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]

}

data "aws_security_group" "Ravi_Secuity_All" {
  name = "Ravi_Secuity_All"
}

output "ami" {
  value = data.aws_ami.centos.image_id
}
/*

resource "aws_route53_record" "dispatch" {
  zone_id = var.hosted_zone_id
  name    = "dispatch-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.dispatch.private_ip]
}*/
