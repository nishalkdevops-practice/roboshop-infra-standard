resource "aws_lb" "web_alb" {
  name               = "${var.project_name}-${var.common_tags.Component}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.web_alb_sg_id.value]
  subnets            = split(",",data.aws_ssm_parameter.public_subnet_ids.value)

  #enable_deletion_protection = true

  tags = var.common_tags
}

resource "aws_acm_certificate" "nishalkdevops" {
  domain_name       = "nishalkdevops.online"
  validation_method = "DNS"
  tags = var.common_tags
}

data "aws_route53_zone" "nishalkdevops" {
  name         = "nishalkdevops.online"
  private_zone = false
}

resource "aws_route53_record" "nishalkdevops" {
  for_each = {
    for dvo in aws_acm_certificate.nishalkdevops.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.nishalkdevops.zone_id
}

resource "aws_acm_certificate_validation" "nishalkdevops" {
  certificate_arn         = aws_acm_certificate.nishalkdevops.arn
  validation_record_fqdns = [for record in aws_route53_record.nishalkdevops : record.fqdn]
}



resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.nishalkdevops.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "This is the fixed response from Web ALB HTTPS"
      status_code  = "200"
    }
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = "nishalkdevops.online"

  records = [
    {
      name    = ""
      type    = "A"
      alias   = {
        name    = aws_lb.web_alb.dns_name
        zone_id = aws_lb.web_alb.zone_id
      }
    }
  ]
}