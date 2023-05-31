locals {
  name = var.env !=""? "${var.component_name}-${var.env}" :  var.component_name
  db_command = [
    "rm -rf roboshop-shell",
    "git clone https://github.com/ravivij111/roboshop-shell.git",
    "cd roboshop-shell",
    "sudo bash ${var.component_name}.sh ${var.password}"
  ]

  app_commands = [
    "sudo labauto ansible",
    "ansible-pull -i localhost, -U https://github.com/ravivij111/3_roboshop-ansible roboshop.yml -e env-${env} -e role_name=${var.component_name}"
  ]
}

