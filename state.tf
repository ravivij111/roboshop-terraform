/*
teraform {
  backend "s3" {
    bucket = "terraform-a72"
    key = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }

}*/
/*
terraform {
  backend "s3" {
    bucket = "terraform-a72"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }

}*/

terraform {
  backend "s3" {

  }
}

