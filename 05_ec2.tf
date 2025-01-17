data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}

resource "aws_instance" "red" {
  ami           = data.aws_ami.ubuntu.id
  count         = 2
  instance_type = "t3.micro"

  tags = {
    Name = "Red"
    AutoStop = "true"
  }
}

resource "aws_instance" "green" {
  ami           = data.aws_ami.ubuntu.id
  count         = 2
  instance_type = "t3.micro"

  tags = {
    Name = "Red"
  }
}
