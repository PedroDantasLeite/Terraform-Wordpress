resource "aws_eks_node_group" "nodeGroup011" {
    node_role_arn = var.node_role_arn
    cluster_name = var.cluster_name
    subnet_ids = var.subnet_ids
    scaling_config {
        min_size = 1
        max_size = 2
        desired_size = 1
    }

    node_group_name = var.node_group_name
    instance_types = [var.instance_type]

    tags = {
        Name = "nodeGroup011"
    }
}
