resource "aws_security_group" "elk" {
  name        = "elk-server"
  description = "All all Elasticsearch traffic"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    description = "elasticsearch"
    cidr_blocks = var.ingress_cidrs
  }

  ingress {
    from_port   = 5043
    to_port     = 5044
    protocol    = "tcp"
    description = "logstash"
    cidr_blocks = var.ingress_cidrs
  }

  ingress {
    from_port       = 5601
    to_port         = 5601
    protocol        = "tcp"
    description     = "kibana"
    security_groups = [aws_security_group.lb.id]
    cidr_blocks     = var.ingress_cidrs
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "ssh"
    cidr_blocks = var.ssh_cidrs
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }
  # outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.common_tags
}
