resource "aws_security_group" "test-ec2-sg" {
  name        = "${var.project}-test-ec2-sg"
  description = "Allow inbound SSH and HTTP"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-test-ec2-sg"
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-key-pair"
  public_key = var.public_key  # Замените на ваш публичный ключ
}

resource "aws_instance" "my_ec2" {
  depends_on = [aws_security_group.test-ec2-sg]
  ami             =   var.ubuntu_ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.test-ec2-sg.id]
  key_name        = aws_key_pair.my_key.key_name

  tags = {
    Name = "${var.project}-test-vpc"
  }

  associate_public_ip_address = true
}