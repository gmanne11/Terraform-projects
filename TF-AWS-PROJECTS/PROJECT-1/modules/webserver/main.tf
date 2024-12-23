resource "aws_security_group" "myapp-sg" {
    vpc_id = var.vpc_id
    name = var.sg_name

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }
    tags = {
        Name: "${var.env_prefix}-sg"
    }
}

resource "aws_instance" "my-server" {
    instance_type = var.instance_type
    ami = data.aws_ami.latest-amazon-linux-image.id
    vpc_security_group_ids = [aws_security_group.myapp-sg.id]
    subnet_id = var.subnet1_id
    availability_zone = var.avail_zone

    associate_public_ip_address = true
    key_name = aws_key_pair.ssh-key.key_name

    user_data = base64encode(file("install-docker.sh"))
    user_data_replace_on_change = true 

    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = file(var.private_key_location)
    }

    provisioner "remote-exec" {
        script = "/home/ec2-user/install-docker.sh"
    }
    provisioner "file" {
        source = "install-docker.sh"
        destination = "/home/ec2-user/install-docker.sh"
    }
    provisioner "local-exec" {
        command = "echo ${self.public_ip} > output.txt"
    }

    tags = {
        Name: "${var.env_prefix}-server"
    }
}


data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners = ["amazon"]
    filter {
      name = "name"
      values = [var.image_name]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
}

resource "aws_key_pair" "ssh-key" {
    key_name = "server-key"
    public_key = file(var.public_key_location)
}



