# resource "aws_key_pair" "mykey" {
#   key_name   = "mykey"
#   public_key = file(var.PATH_TO_PUBLIC_KEY)
# }

## TO TEST IMPORT
# resource "aws_instance" "nginx-import" {
#   # ...instance configuration...
#   ami                          = "ami-0f86a70488991335e"
#   instance_type                = "t2.micro"
# }

resource "aws_instance" "nginx" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = "eks-course"
  tags = {
    Name = "nginx-demo"
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh", # Remove the spurious CR characters.
      "sudo /tmp/script.sh",
    ]
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.nginx.private_ip} >> private_ips.txt"
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}

output "ip" {
  value = aws_instance.nginx.public_ip
}
