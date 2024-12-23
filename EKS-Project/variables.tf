variable "region" {
    default = "us-east-1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
    description = "VPC CIDR range"
}

variable "k8s_version" {
    default = "1.31"
}




