locals {
  public_subnet_id = element(split("," , data.aws_ssm_parameter.public_subnet_ids.value), 0)
  resoure_name = "${var.project_name}-${var.environment}-bastion"

}