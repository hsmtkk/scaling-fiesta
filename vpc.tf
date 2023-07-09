resource "aws_vpc" "aurora" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "aurora1" {
  availability_zone = "ap-northeast-1c"
  vpc_id            = aws_vpc.aurora.id
  cidr_block        = "10.0.10.0/24"
}

resource "aws_subnet" "aurora2" {
  availability_zone = "ap-northeast-1d"
  vpc_id            = aws_vpc.aurora.id
  cidr_block        = "10.0.20.0/24"
}

resource "aws_security_group" "aurora" {
  vpc_id = aws_vpc.aurora.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}