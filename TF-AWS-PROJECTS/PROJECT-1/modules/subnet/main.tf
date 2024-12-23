

resource "aws_subnet" "myapp-subnet-1" {
    vpc_id = var.vpc_id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name: "${var.env_prefix}-subnet-1"
    }
}

resource "aws_route_table" "myapp-rtb" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myigw.id 
    }
    tags = {
        Name: "${var.env_prefix}-rtb"
    }
}

resource "aws_internet_gateway" "myigw" {
    vpc_id = var.vpc_id
    tags = {
        Name: "${var.env_prefix}-myigw"
    }
}

resource "aws_route_table_association" "rtba" {
    subnet_id = aws_subnet.myapp-subnet-1.id 
    route_table_id = aws_route_table.myapp-rtb.id 
}
