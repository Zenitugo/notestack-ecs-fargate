modules "vpc"     {
    source                                    = "../modules/vpc"
    project_name                              = var.project_name
    vpc_cidr                                  = var.vpc_cidr
    subnet_cidr_public_1                      = var.subnet_cidr_public_1
    subnet_cidr_public_2                      = var.subnet_cidr_public_2
    subnet_cidr_private_1                     = var.subnet_cidr_private_1
    subnet_cidr_private_2                     = var.subnet_cidr_private_2
    subnet_cidr_private_3                     = var.subnet_cidr_private_3
    subnet_cidr_private_4                     = var.subnet_cidr_private_4
}


module "sg"       {
    source                                    = "../modules/sg"
    project_name                              = var.project_name
    vpc_id                                    = module.vpc.vpc_id
    alb_port                                  = var.alb_port
    frontend_port                             = var.frontend_port
    backend_port                              = var.backend_port
    db_port                                  = var.db_port
}


module "ecr"      {
    source                                    = "../modules/ecr"
    project_name                              = var.project_name
}

module "rds"     {
    source                                    = "../modules/rds"
    private_subnet_3_id                       = module.vpc.private_subnet_3_id
    private_subnet_4_id                       = module.vpc.private_subnet_4_id
    rds_sg_id                                 = module.sg.rds_sg_id
    db_username                               = var.db_username
    db_password                               = var.db_password
    project_name                              = var.project_name
}

module "secrets" {
    source                                    = "../modules/secrets"
    project_name                              = var.project_name
    db_port                                   = var.db_port
    db_username                               = var.db_username
    db_password                               = var.db_password
    rds_endpoint                              = module.rds.rds_endpoint
}

module "iam"   {
    source                                    = "../modules/iam"
    project_name                              = var.project_name
    secrets_arn                               = module.secrets.secrets_arn
}