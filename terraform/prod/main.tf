module "vpc"     {
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

    depends_on = [module.rds]
}

module "iam"   {
    source                                    = "../modules/iam"
    project_name                              = var.project_name
    secrets_arn                               = module.secrets.secrets_arn
}

module "alb"   {
    source                                    = "../modules/alb"
    project_name                              = var.project_name
    alb_sg_id                                 = module.sg.alb_sg_id
    public_subnet_1_id                        = module.vpc.public_subnet_1_id
    public_subnet_2_id                        = module.vpc.public_subnet_2_id
    vpc_id                                    = module.vpc.vpc_id
    private_subnet_1_id                       = module.vpc.private_subnet_1_id
    private_subnet_2_id                       = module.vpc.private_subnet_2_id
    ecs_sg_backend_id                         = module.sg.ecs_sg_backend_id
    backend_port                              = var.backend_port
}


module "cloudwatch"   {
    source                                    = "../modules/cloudwatch"
    project_name                              = var.project_name
}


module "ecs"   {
    source                                    = "../modules/ecs"
    project_name                              = var.project_name
    frontend_port                             = var.frontend_port
    backend_port                              = var.backend_port
    db_port                                   = var.db_port
    execution_role_arn                        = module.iam.execution_role_arn
    frontend_log_group_name                   = module.cloudwatch.frontend_log_group_name
    backend_log_group_name                    = module.cloudwatch.backend_log_group_name
    secrets_arn                               = module.secrets.secrets_arn
    public_subnet_1_id                        = module.vpc.public_subnet_1_id
    public_subnet_2_id                        = module.vpc.public_subnet_2_id
    private_subnet_1_id                       = module.vpc.private_subnet_1_id
    private_subnet_2_id                       = module.vpc.private_subnet_2_id
    ecs_sg_frontend_id                        = module.sg.ecs_sg_frontend_id
    target_group_arn                          = module.alb.target_group_arn
    ecs_sg_backend_id                         = module.sg.ecs_sg_backend_id
    backend_target_group_arn                  = module.alb.backend_target_group_arn
    service_discovery_service_arn             = module.service_discovery.service_discovery_service_arn
    frontend_repository_url                   = module.ecr.frontend_repository_url
    backend_repository_url                    = module.ecr.backend_repository_url
    region                                    = var.region
}


module "service_discovery" {
    source                                    = "../modules/service-discovery"
    vpc_id                                    = module.vpc.vpc_id
    project_name                              = var.project_name
}