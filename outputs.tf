#this output in terraform plan will fetch that AMI data to make sure that filters are correct
#and if you need id only add data.aws_ami.latest-linux-image.id

# output "aws_ami_id" {
#   value = data.aws_ami.latest-linux-image.id
# }

output "ec2_public_id" {
  value = module.myapp-server.instance.public_ip
}