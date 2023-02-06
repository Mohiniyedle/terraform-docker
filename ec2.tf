
resource "aws_security_group" "allow_all" {
  count       = "${true == "" ? 1 : 0}"
  name        = "instance_sg"
  description = "Allow all inbound traffic for security group"
  vpc_id      = "***vpc-id****"

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
#   #public_key = file("**** id_rsa.pub location *****")
# public_key = file("**** id_rsa.pub location *****")
# }


resource "aws_instance" "Demo" {
  ami = "**** ami *****"
  instance_type = "t2.micro"
  key_name = "**** key name without .pem *****"
  #security_groups = ["**** sg group id *****"]
  vpc_security_group_ids = [ "**** sg group id *****" ]
  tags = {
    Name = "terraform"
  }



  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("**** .pem location *****")}"
    
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
