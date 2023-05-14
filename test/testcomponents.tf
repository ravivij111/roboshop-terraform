resource "null_resource" "instance" {
  for_each               = var.components

  provisioner "local-exec" {

    command = "echo **** Key Name - ${each.key} *"

    #command = "echo **** Key Name - ${each.value["instance_type"]} *"

  }
}