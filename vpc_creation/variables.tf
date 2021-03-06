variable "access_key" {
    description = "The AWS Access key to use to create the cluster"
}
variable "secret_key" {
    description = "The AWS Secret key to use to create the cluster"
}
variable "aws_region" {
    description = "The region in which to create the cluster"
    default = "ap-southeast-2"
}

variable "key_name" {
    description = "The name of the key pair you created"
}

variable "key_path" {
    description = "The path to the .pem file for the key pair you created"
}

variable "environment" {
    description = "The application environment"
    default = "prod"
}

variable "vpc_name" {
    description = "The Name to be used for VPC"
    default = "workshop"
}

variable "vpc_cidr" {
    description = "The CIDR block for the entire VPC"
    default = "10.1.0.0/16"
}

variable "public_subnet_a_cidr" {
    description = "The CIDR block for public subnet A"
    default = "10.1.0.0/18"
}

variable "public_subnet_b_cidr" {
    description = "The CIDR block for public subnet B"
    default = "10.1.64.0/18"
}

variable "private_subnet_a_cidr" {
    description = "The CIDR block for private subnet A"
    default = "10.1.128.0/18"
}

variable "private_subnet_b_cidr" {
    description = "The CIDR block for private subnet B"
    default = "10.1.192.0/18"
}

variable "cluster_private_dns" {
    description = "The DNS suffix to use for local addresses"
    default = "my.cluster"
}

