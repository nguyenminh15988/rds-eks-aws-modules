locals {
  cluster_name = "eks-test"
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  version                = ">= 2.10.0"
}

module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  version      = "17.24.0"
  cluster_name = local.cluster_name
  subnets      = module.vpc.private_subnets

  tags = {
    Provisioner = "terraform"
  }

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      asg_desired_capacity          = 3
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    }
  ]
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }
  version = "~> 1.2"
}

resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "2.3.0"

  set {
    name  = "controller.replicaCount"
    value = 2
  }
}

#kubeconfig
resource "null_resource" "kube_configuration" {
    provisioner "local-exec" {
    command = "aws eks --region ap-southeast-1 update-kubeconfig --name ${local.cluster_name}"
  }
}