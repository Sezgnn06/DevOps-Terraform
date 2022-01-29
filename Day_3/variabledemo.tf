resource "aws_security_group" "variable-sg" {
  name = "variable-test-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = var.protocol
    cidr_blocks = [var.cidr]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = var.protocol
    cidr_blocks = [var.cidr]
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = var.protocol
    cidr_blocks = [var.cidr]
  }

  egress {
    from_port   = 3000
    to_port     = 3000
    protocol    = var.protocol
    cidr_blocks = [var.cidr]
  }
}

