module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  zones = {
    "product.com" = {
      comment = "product.com (production)"
      tags = {
        env = "production"
      }
    }
  }

  tags = {
    ManagedBy = "Terraform"
  }
}

#when apply ingress loadbalancer we will have record on nlb and we will configure below

# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"

#   zone_name = keys(module.zones.route53_zone_zone_id)[0]

#   records = [
#     {
#       name    = "apigateway1"
#       type    = "A"
#       alias   = {
#         name    = "d-10qxlbvagl.execute-api.eu-west-1.amazonaws.com"
#         zone_id = "ZLY8HYME6SFAD"
#       }
#     },
#     {
#       name    = ""
#       type    = "A"
#       ttl     = 3600
#       records = [
#         "10.10.10.10",
#       ]
#     },
#   ]

#   depends_on = [module.zones]
# }