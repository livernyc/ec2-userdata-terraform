resource "aws_security_group" "web-pub-sg" {
  name        = "allow_web_access"
  description = "allow inbound traffic"
  vpc_id      = aws_vpc.this.id
  ingress {
    description = "from my ip range"
    from_port   = "3389"
    to_port     = "3389"
    protocol    = "tcp"
    cidr_blocks = ["71.255.56.112/32"]
  }
  ingress {
    description = "Allow SSH traffic"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["71.255.56.112/32"]
  }
  ingress {
    description = "allow traffic from TCP/80"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    to_port     = "0"
  }
  tags = {
    "Name" = "Application-1-sg"
  }
}

data "aws_ami" "windows-ami" {
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-2021*"]
  }
  filter {
    name   = "platform"
    values = ["windows"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners      = ["amazon"]
}

resource "aws_instance" "win-app-server" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.windows-ami.id
  vpc_security_group_ids = [aws_security_group.web-pub-sg.id]
  subnet_id              = aws_subnet.public.id
  private_ip             = "10.20.20.122"
  key_name               = "skundu-sandbox"
  user_data = templatefile("user_data/user_data.tpl",
    {
      ServerName1 = var.ServerName1
  })
  associate_public_ip_address = true
  tags = {
    Name = "app-server-win"
  }
}

data "aws_ami" "amzlinux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
  name = "virtualization-type"
  values = ["hvm"]
  }
  filter {
  name = "architecture"
  values = ["x86_64"]
  }  
} 

resource "aws_instance" "lin-app-server" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.amzlinux.id
  vpc_security_group_ids = [aws_security_group.web-pub-sg.id]
  subnet_id              = aws_subnet.public.id
  private_ip             = "10.20.20.123"
  key_name               = "skundu-sandbox"
  user_data = templatefile("user_data/user_data_lin.tpl",
    {
      ServerName2 = var.ServerName2
  })
  associate_public_ip_address = true
  tags = {
    Name = "app-server-lin"
  }
}