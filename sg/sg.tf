data "aws_security_group" "sg_1" {
    id = "sg-0a12fd16ac99680c1"
}

data "aws_security_group" "sg_2" {
    id = "sg-03caf72cde56e0878"
}

output "sg_1_id" {
    value = data.aws_security_group.sg_1.id
}

output "sg_2_id" {
    value = data.aws_security_group.sg_2.id
}