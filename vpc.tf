

variable "rds_admin_password" {
  default = "admin"
}

provider "aws" {
  access_key = "AKIAZJMXRRE4BDNLO66K"
  secret_key = "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"
#  token      = ""
  region     = "us-east-1"
}

# data "aws_availability_zones" "available" {}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

data "aws_subnet_ids" "private_subnets" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "eks-vpc-private-*"
  }
}

# have no right for getting avaibility zone on test environment
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"
  #   azs                  = data.aws_availability_zones.available.names
  azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    Provisioner                                   = "terraform"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
    Provisioner                                   = "terraform"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    Provisioner                                   = "terraform"
  }
}

