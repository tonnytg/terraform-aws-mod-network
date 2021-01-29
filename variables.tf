variable "cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "this value set by root module, define a cidr of vpc"
}

variable "cidr_blocks_pri" {
  type    = list(any)
  default = ["10.0.1.0/24"]
}

variable "cidr_blocks_pub" {
  type        = list(any)
  default     = ["10.0.2.0/24"]
  description = "List of pub subnets"
}

variable "project_name" {
  type        = string
  default     = "MyVPC"
  description = "This value set Tag Name of project"
}

