data "aws_security_group" "Ravi_Secuity_All" {
  name = "Ravi_Secuity_All"
}

data "aws_ami" "centos" {
  owners           = ["973714476881"]
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}

/*
data "aws_ami" "centos" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
  owners           = ["973714476881"]

}

data "aws_security_group" "Ravi_Secuity_All" {
  name = "Ravi_Secuity_All"
}*/
