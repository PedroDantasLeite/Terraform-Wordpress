provider "aws" {
  region = "ca-central-1"
}

resource "aws_ecr_repository" "wordpress_repo" {
  name = "wordpress-repository"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "wordpress-repository"
  }
}

data "aws_eks_cluster" "eks-cluster" {
  name = "EKSDeepDive"
}

data "aws_eks_cluster_auth" "eks-cluster-auth" {
  name = "EKSDeepDive"
}

provider "kubernetes" {
  host                   = "https://C809D7DD97ECBF001D0CF8C74B6A01AE.sk1.ca-central-1.eks.amazonaws.com"
  cluster_ca_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJWEpiaUtPRjB6cDB3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRFd01qZ3hOREEzTXpWYUZ3MHpOREV3TWpZeE5ERXlNelZhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURBamgyUjhqQ0IvSm8way9hMXFmZk9mYnQyQStIN1J6ZE5WekhSZTYwMGVwNEI1dWdPeFdGNnhvZXoKYitEY3hWUFRGMWlIOHRhWjk4MG5idmRJVGM3SUlNSENOaVFrZ2RvMmVHWEdPY1lGL3VhU1BwaXd6TzlpRFBwQwpnRzlIMFgrNTc5azRwd1MvTWtCN01GaTF2c1B5Y2pIdWZtSm96R0VEcGRyRnFud0tHdWxkVVNuQ1hOUmFNbzBzCnhLZ01INzBFc1UrYnJVMEtBNkFvTHVTU1BWQTF1NkEwN1ovMDYyMjFGeXNqOXFUeDdSMzdudXp0Q1RKUkMvOUYKYzYrQklDOXhUbVR4TUc3eWdxTytwMW5sb1o0aUVhSlZnR29IakNZRThHcGFRVkRKckF4S3M0czlnZHFhT1owMAppeE1WQ3JJdGtHYnl5dWdFdkRSNEtIYXVHci9iQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJUR1gvR0tqaFJoSXI0K2xxaXVtZjl5NEY5VlJUQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQk1nblFtZ0REYQppNjBicG1VTDlsaVplTDVCTmd0N1lSZmwzbFVrQkdGZ0VmQ3B3dkwvUjR0V1ByV3Zid1luY0pKNzBxZTRQSVhXCmp1bllFaExuZ3JJZDlpd1ZHWFhWNExtUWJvQ25wdkJXQTEvZkRwNzNmbDZyQnZTTUJGRHZXT29tMEtDaENXOFkKRjhqWnJoVzY0WEw1MVVGYlBJZC9WLzdoYlZqRy81ZnBpN2x3aG5TT2hpQ1lad0lOV2h6TTh5cFNXWGhRa2pQWgppSGo5ZlhiMTRuOFZvTEYwb0dYMkk5aHBMV0lhak9tUEQyR2Vkc3VpKytnR2ZKdy80Qzh2Y2ZQK1crOS9BcGdpCnFNanIrTFFYdWdTNERHNitNRFRoQ0svQjg5UGROU200SXF2cXJVem1ncmhRc1pyZnJJQ01wMDh0SFRLVUpTcXAKMkdXNjlRUkl5NkwvCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K")
  token                  = data.aws_eks_cluster_auth.eks-cluster-auth.token
}

module "vpc" {
  source = "./vpc"
}

module "subnets" {
  source = "./vpc/subnets"
  vpc_id = module.vpc.vpc_id
}

module "sg" {
  source = "./sg"
  vpc_id = module.vpc.vpc_id
}

module "node-group" {
  source       = "./node-group"
  subnet_ids   = module.subnets.eks_subnet_ids
  cluster_name = data.aws_eks_cluster.eks-cluster.name
}

module "deployment" {
  source = "./deployment"
}

module "service" {
  source = "./service"
}
