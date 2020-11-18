variable "AWS_REGION" {
  default = "ap-southeast-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "eks-course.pem"
}

# variable "PATH_TO_PUBLIC_KEY" {
#   default = "mykey.pub"
# }

variable "AMIS" {
  type = map(string)
  default = {
    "ap-southeast-1" = "ami-0f86a70488991335e"
    "ap-southeast-2" = "ami-044c46b1952ad5861"
  }
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}
