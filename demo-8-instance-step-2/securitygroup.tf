resource "aws_security_group" "allow-ssh-http" {
  vpc_id      = aws_vpc.main-lab.id
  name        = "secg-allow-ssh-http"
  description = "security group that allows ssh, http and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["103.6.150.173/32"]
    description = "Allow ssh access from my network"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["103.6.150.173/32"]
    description = "Allow nginx access from my network"
  }

  tags= {
    Name = "secg-allow-ssh-http"
  }

}

