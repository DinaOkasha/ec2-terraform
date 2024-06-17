provider "aws" {
  region     = "eu-west-1"
}


resource "aws_vpc" "main_dina" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.main_dina.id
  subnet_cidr_block = var.subnet_cidr_block
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix

}


module "myapp-server" {
  source = "./modules/webserver"
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  my-ip = var.my-ip
  myinstance_type = var.myinstance_type
  my-pub-key = var.my-pub-key
  vpc_id = aws_vpc.main_dina.id
  subnet_id = module.myapp-subnet.subnet.id
}











# data "aws_vpc" "existing_vpc"{
#   default = true
# }

# resource "aws_subnet" "main_dina_subnet2" {
#   vpc_id = data.aws_vpc.existing_vpc.id
#   cidr_block = "172.31.48.0/20"
#   availability_zone = "eu-west-1a"

# }