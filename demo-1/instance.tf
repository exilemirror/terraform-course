resource "aws_instance" "example1" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
}
