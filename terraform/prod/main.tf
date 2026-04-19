modules "vpc"     {
    source                                    = "../modules/vpc"
    project_name                              = var.project_name
    vpc_cidr                                  = var.vpc_cidr
    subnet_cidr_public_1                      = var.subnet_cidr_public_1
    subnet_cidr_public_2                      = var.subnet_cidr_public_2
    subnet_cidr_private_1                     = var.subnet_cidr_private_1
    subnet_cidr_private_2                     = var.subnet_cidr_private_2
}