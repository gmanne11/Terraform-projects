
output "ec2_public_ip" {
    value = module.web-app.instance.public_ip
}

