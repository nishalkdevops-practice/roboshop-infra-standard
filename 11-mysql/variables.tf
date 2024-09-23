variable "sg_name" {
    default = "roboshop-mysql"
}

variable "sg_description" {
    default = ""
  
}

# variable "vpc_id" {
  
# }

variable "sg_ingress_rules" {
    default = []
  
}

variable "project_name" {
    default = "ROBOSHOP"

}

variable "env" {
    default = "dev"

}

variable "common_tags" {
    default = {  
      Project = "roboshop"
      Env = "DEV"
      Component = "mysql"
      Terraform = "true"
  
   }
}

variable "sg_tags" {
  default = {}
}

variable "zone_name" {
    default = "nishalkdevops.online"

}