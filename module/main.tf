
resource "aws_instance" "instance" {

  ami                    = data.aws_ami.centos.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.Ravi_Secuity_All.id]
  #iam_instance_profile =  aws_iam_instance_profile.instance_profile
  tags                   = var.app_type == "app" ? local.app_tags : local.db_tags
   // Name = local.name

}

resource "aws_route53_record" "records" {

  zone_id = "Z09194283TYN817J8N83P"
  name    = "${var.component_name}-dev.r1devopsb.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}
resource "null_resource" "provisioner" {

  count = var.provisioner ? 1 : 0
  depends_on = [aws_route53_record.records]
  triggers = { //If any time the private ip changes
    private_ip = aws_instance.instance.private_ip
  }
   provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     =  aws_instance.instance.private_ip
    }

    inline = var.app_type == "db"?local.db_command : local.app_commands
     /*[
      "rm -rf roboshop-shell",
      "git clone https://github.com/ravivij111/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${var.component_name}.sh ${var.password}"
    ]*/
  }
}

#Creating a role to get aws access to the component servers to retrieve the aws parameters from aws
/*
resource "aws_iam_role" "role" {
  name = "$var.{component}-${var.env}-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}
*/
/* IAM Role Policy

resource "aws_iam_role" "test_policy" {
  name =  name = "$var.{component}-${var.env}-ssm-ps-policy"
  role = aws_iam_role.test_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "instane_profile" {
  name = ""$var.{component}-${var.env}-role""
  role = aws_iam_role.role.name
}


*/

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