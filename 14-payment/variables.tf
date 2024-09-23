

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
      Component = "payment"
      Terraform = "true"
  
   }
}

variable "target_group_port" {
    default = 8080

}



variable "launch_template_tags" {
    default = [
        {
            resource_type = "instance"

            tags = {
                Name = "payment"
            }
        }, 

        {
            resource_type = "volume"

            tags = {
                Name = "payment"
            }

        }
    ]
  
}

variable "autoscaling_tags" {
    default = [
        {
            key = "Name"
            value = "payment"
            propagate_at_launch = true
        },

        {
            key = "project"
            value = "Roboshop"
            propagate_at_launch = true
        }
    ]
  
}

