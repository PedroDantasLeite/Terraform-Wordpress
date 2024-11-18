variable "subnets_id" {
  type = list(string)
  default = ["172.31.1.0/24", "172.31.2.0/24"]
}

data "aws_subnet" "eks_subnets" {
    count = length(var.subnets_id)
    vpc_id = var.vpc_id
    cidr_block = element(var.subnets_id, count.index)
}

output "eks_subnet_ids" {
  value = tolist(data.aws_subnet.eks_subnets[*].id)
}
