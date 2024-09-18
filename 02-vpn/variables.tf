variable "sg_name" {
    default = "roboshop-vpn"
}


variable "env" {
    default = "dev"

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

variable "common_tags" {
    default = {  
      Project = "roboshop"
      Env = "DEV"
      Component = "vpn"
      Terraform = "true"
  
   }
}

variable "sg_tags" {
  default = {}
}