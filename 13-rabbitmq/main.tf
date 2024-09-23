
module "rabbitmq_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.devops_ami.id
  instance_type = "t3.medium"
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]

  #it should be provision in DB subnet 
  subnet_id = local.db_subnet_id
  user_data = file("rabbitmq.sh")
  
  #the below is optional if we dont give this will be provisioned inside default subnet
  #subnet_id = local.public_subnet_ids[0] # public subnet in default vpc

  tags = merge(
    {
        Name = "Rabbimq"
    },
    var.common_tags
  )
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name
  records = [
    {
        name    = "rabbitmq"
        type    = "A"
        ttl     = 1
        records = [
            module.rabbitmq_instance.private_ip
        ]
    }
  ]
}