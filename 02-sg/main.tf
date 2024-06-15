module "db_sg" {
    source = "../sg-module"
    project_name = var.project_name
    common_tags = var.common_tags
    sg_name =  "db"
    sg_description = "db_sg for instance"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
  
}


module "backend_sg" {
    source = "../sg-module"
    project_name = var.project_name
    common_tags = var.common_tags
    sg_name =  "backend"
    sg_description = "backend_sg for instance"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
  
}

module "frontend_sg" {
    source = "../sg-module"
    project_name = var.project_name
    common_tags = var.common_tags
    sg_name =  "frontend"
    sg_description = "frontend_sg for instance"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
  
}

module "bastion_sg" {
    source = "../sg-module"
    project_name = var.project_name
    common_tags = var.common_tags
    sg_name =  "bastion"
    sg_description = "bastion_sg for instance"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
  
}

module "ansible_sg" {
    source = "../sg-module"
    project_name = var.project_name
    common_tags = var.common_tags
    sg_name =  "ansible"
    sg_description = "ansible_sg for instance"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
  
}


resource "aws_security_group_rule" "db_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id =  module.db_sg.sg_id
  source_security_group_id = module.backend_sg.sg_id
}

resource "aws_security_group_rule" "db_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id =  module.db_sg.sg_id
  source_security_group_id = module.bastion_sg.sg_id
}


resource "aws_security_group_rule" "backend_frontend" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id =  module.backend_sg.sg_id
  source_security_group_id = module.frontend_sg.sg_id
}

resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.backend_sg.sg_id
  source_security_group_id = module.bastion_sg.sg_id
}

resource "aws_security_group_rule" "backend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.backend_sg.sg_id
  source_security_group_id = module.ansible_sg.sg_id
}

resource "aws_security_group_rule" "frontend_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id =  module.frontend_sg.sg_id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.frontend_sg.sg_id
  source_security_group_id = module.bastion_sg.sg_id
}


resource "aws_security_group_rule" "frontend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.frontend_sg.sg_id
  source_security_group_id = module.ansible_sg.sg_id
}


resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.bastion_sg.sg_id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ansible_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id =  module.ansible_sg.sg_id
  cidr_blocks = ["0.0.0.0/0"]
}