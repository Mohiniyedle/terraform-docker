
resource "aws_security_group" "allow_all" {
  count       = "${true == "" ? 1 : 0}"
  name        = "instance_sg"
  description = "Allow all inbound traffic for security group"
  vpc_id      = "vpc-0a9a2e553fb009324"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = ["pl-12c4e678"]
  }
}



# resource "aws_key_pair" "example" {
#   key_name   = "terraform"
#   #public_key = file("/home/gajanan/.ssh/id_rsa.pub")
# public_key = file("~/.ssh/id_rsa.pub")
# }


resource "aws_instance" "Demo" {
  ami = "ami-0597375488017747e"
  instance_type = "t2.micro"
  key_name = "terraform"
  #security_groups = ["sg-015bab7cc29ea3764"]
  vpc_security_group_ids = [ "sg-0a45be99eefb9415f" ]
  tags = {
    Name = "terraform"
  }



  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("/home/gajanan/Downloads/terraform.pem")}"
    #private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      #"sudo -i",
      "sudo apt-get update -y",
      "sudo apt install docker.io -y"
    ]
  }
}
# output "public_ip" {
#     value = aws_instance.web.*.public_ip
# }