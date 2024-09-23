module "shipping" {
    source = "../../terraform-roboshop-app"
    project_name = var.project_name
    env = var.env
    common_tags = var.common_tags

    #target group parameters

    #health_check = var.health_check
    target_group_port = var.target_group_port
    vpc_id = data.aws_ssm_parameter.vpc_id.value

    #launch template parameters 
    image_id = data.aws_ami.devops_ami.id 
    security_group_id = data.aws_ssm_parameter.shipping_sg_id.value 
    user_data = filebase64("${path.module}/shipping.sh")
    launch_template_tags = var.launch_template_tags

    #autoscaling group

    vpc_zone_identifier = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
    tag = var.autoscaling_tags
    
    #autoscaling policy

    #all parameters already declared in root module

    #listener rule

    alb_listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
    rule_priority = 40
    host_header = "shipping.app.nishalkdevops.online"




}