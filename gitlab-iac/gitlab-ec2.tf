module "ec2-instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "5.5.0"
  name                        = "gitlab-instance"
  instance_type               = "t3a.xlarge"
  key_name                    = "MacBook"
  monitoring                  = true
  associate_public_ip_address = true
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [module.gitlab_sg.security_group_id]
  ami                         = data.aws_ami.amazon_linux.id
  # --hostname gitlab.petw.world \
  # --env GITLAB_OMNIBUS_CONFIG="external_url 'https://gitlab.petw.world/'; gitlab_rails['lfs_enabled'] = true; letsencrypt['contact_emails'] = ['pmbibe@gmail.com']; letsencrypt['enable'] = true;" \
  user_data                   = <<-EOT
    #!/bin/bash
    sudo dnf update -y
    sudo dnf install docker -y
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker has been installed"
    # Install Gitlab EE
    sudo mkdir -p /srv/gitlab
    export GITLAB_HOME=/srv/gitlab
    sudo docker run --detach \
      --hostname gitlab.petw.world \
      --publish 443:443 --publish 80:80 --publish 2222:22 \
      --name gitlab \
      --restart always \
      --volume $GITLAB_HOME/config:/etc/gitlab \
      --volume $GITLAB_HOME/logs:/var/log/gitlab \
      --volume $GITLAB_HOME/data:/var/opt/gitlab \
      --shm-size 256m \
      gitlab/gitlab-ee:latest
  EOT
}
