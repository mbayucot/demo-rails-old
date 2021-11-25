
variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group"
  default     = ""
}

variable "image_url" {
  description = "URL of ecr image url"
  default     = ""
}

variable "lb_blue_arn" {
  description = "ARN of application loadbalancer"
  default     = ""
}

variable "subnets" {
  description = "Ids of the subnets"
  default     = []
}

variable "security_groups" {
  description = "Ids of the security groups"
  default     = []
}

variable "iam_arn" {
  description = "ARN of ECS Task"
  default     = ""
}

variable "web_container_name" {
  description = "Name of the docker image"
  default     = ""
}

variable "env" {
  description = "ENV rails"
  default     = ""
}
