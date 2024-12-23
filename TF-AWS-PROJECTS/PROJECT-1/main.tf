resource "aws_vpc" "myapp-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: "${var.env_prefix}-vpc"
    }
}


module "myapp-subnet" {
    source = "./modules/subnet"
    subnet_cidr_block = var.subnet_cidr_block
    vpc_id = aws_vpc.myapp-vpc.id
    avail_zone = var.avail_zone
    env_prefix = var.env_prefix
}


module "web-app" {
    source = "./modules/webserver"
    instance_type = var.instance_type
    env_prefix = var.env_prefix
    vpc_id = aws_vpc.myapp-vpc.id
    sg_name = var.sg_name
    subnet1_id = module.myapp-subnet.subnet.id
    private_key_location = var.private_key_location
    public_key_location = var.public_key_location
    avail_zone = var.avail_zone
    image_name = var.image_name
}

