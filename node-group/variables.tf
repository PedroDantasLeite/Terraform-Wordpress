variable subnet_ids {
    type = list(string)
}

variable cluster_name {
    type = string
}

variable node_role_arn {
    type = string
    default = "arn:aws:iam::325583868777:role/EKSDeepDive_NodeGroup_Role_cdcp"
}

variable node_group_name {
    type = string
    default =  "nodeGroup011"
}

variable instance_type {
    type = string
    default = "t3.small"
}
