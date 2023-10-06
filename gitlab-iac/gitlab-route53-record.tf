module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = keys(module.route53-zones.route53_zone_zone_id)[0]

  records = [
    {
      name    = "petw.world"
      type    = "A"
      ttl     = 3600
      records = [module.ec2-instance.public_ip]
    },
    {
      name    = "gitlab.petw.world"
      type    = "A"
      ttl     = 3600
      records = [module.ec2-instance.public_ip]
    }
  ]

  depends_on = [module.route53-zones, module.ec2-instance]
}