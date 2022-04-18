# provider "aws" {
#   region                  = var.region
# #   shared_credentials_file = "C:/Users/CyberGOD/.aws/credentials"
# #   version = ">= 2.38.0"
# }

# data "aws_region" "current" {}

# # data "aws_availability_zones" "available" {
# #     state = "available"
# # }

# provider "http" {}

# provider "kubernetes" {}

# variable "region" {
#   default = "ap-southeast-1"
#   type = string
# }

# variable "cluster-name" {
#   default = "terraform-eks"
#   type    = string
# }
# variable "RDS_name"{
#   default = "MyRDS"
#   type = string
# }
# variable "RDS_username"{
#   default = "admin"
#   type = string
# }
# variable "RDS_password"{
#   default = "admin"
#   type = string
# }
# variable "ssh_key_name"{
#   default = "newKey"    //must be Present in AWS EC2 in Your Region
#   type = string
# }