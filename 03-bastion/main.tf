module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = local.resoure_name

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
  # convert StringList to list and get first element
  subnet_id      = local.public_subnet_id
  ami = data.aws_ami.ami_info.id

  tags = merge(
    var.common_tags,
      {
        Name =  local.resoure_name
      }
   )
}