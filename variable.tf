variable "project" {
  type    = string
  default = "scaling-fiesta"
}

variable "aurora_username" {
  type      = string
  sensitive = true
}

variable "aurora_password" {
  type      = string
  sensitive = true
}

variable "wordpress_database_name" {
  type    = string
  default = "wordpress"
}