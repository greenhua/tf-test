module "ec2" {
  source = "./modules/ec2/"
  instance_type = var.instance_type
  public_key = var.public_key
  ubuntu_ami = var.ubuntu_ami
  project = var.project
  subnet_id = aws_subnet.public-1.id
  vpc_id = aws_vpc.my_vpc.id
}