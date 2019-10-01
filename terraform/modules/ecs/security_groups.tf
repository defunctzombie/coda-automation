resource "aws_security_group" "allow_ssh" {
  name        = "ecs_allow_ssh"
  description = "Allow SSH Ingress"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_egress" {
  name        = "ecs_allow_egress"
  description = "Allow Egress"
  vpc_id      = "${module.vpc.vpc_id}"

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_prometheus_9090" {
  name        = "ecs_allow_prometheus_9090"
  description = "Allow Prometheus Ingress"
  vpc_id      = "${module.vpc.vpc_id}"
  
  ingress {
    from_port       = 9090
    to_port         = 9090
    protocol        = "TCP"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}