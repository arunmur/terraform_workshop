variable "access_key" {
    description = "The AWS Access key to use to create the cluster"
}
variable "secret_key" {
    description = "The AWS Secret key to use to create the cluster"
}

variable "key_name" {
    description = "The name of the key pair you created"
}

variable "key_path" {
    description = "The path to the .pem file for the key pair you created"
}

variable "aws_region" {
    description = "The region in which to create the cluster"
    default = "ap-southeast-2"
}
