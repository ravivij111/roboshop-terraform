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


#ami-0b5a2b5b8f2be4ec2
variable "instance_type" {
  default = "t2.micro"
}

variable "hosted_zone_id" {
  default = "Z09194283TYN817J8N83P"
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
resource "null_resource" "provisioner" {
  depends_on = [aws_instance.instance, aws_route53_record.records]
  for_each = var.components
  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host = aws_instance.instance[each.value["name"]].private_ip
  }
  provisioner "remote-exec" {
    inline = [
      " rm -rf roboshop-shell ",
      "git clone https://github.com/ravivij111/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${each.value["name"]}.sh ${lookup(each.value,"password","dummy")}"
    ]
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