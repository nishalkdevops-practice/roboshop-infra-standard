

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
      Component = "user"
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
                Name = "user"
            }
        }, 

        {
            resource_type = "volume"

            tags = {
                Name = "user"
            }

        }
    ]
  
}

variable "autoscaling_tags" {
    default = [
        {
            key = "Name"
            value = "user"
            propagate_at_launch = true
        },

        {
            key = "project"
            value = "Roboshop"
            propagate_at_launch = true
        }
    ]
  
}

