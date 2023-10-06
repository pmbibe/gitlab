module "gitlab_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name                = "Gitlab SG"
  description         = "Security group for Gitlab"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp", "ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 2222
      to_port     = 2222
      protocol    = "tcp"
      description = "SSH Gitlab port"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_rules = ["all-all"]
}