# resource "aws_ebs_volume" "gitlab-volume" {
#   availability_zone = "us-east-1a"
#   size              = 40

#   tags = {
#     Name = "gitlab-volume"
#   }
# }

# resource "aws_volume_attachment" "gitlab-volume-attachment" {
#   device_name = "/dev/sdb"
#   volume_id   = aws_ebs_volume.gitlab-volume.id
#   instance_id = module.ec2-instance.id
# }
