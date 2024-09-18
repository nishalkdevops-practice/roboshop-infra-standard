

variable "sg_description" {
    default = ""
  
}



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
      Component = "Web-ALB"
      Terraform = "true"
  
   }
}

variable "sg_tags" {
  default = {}
}