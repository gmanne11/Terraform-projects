resource "aws_security_group" "all_worker_mgmt" {
  name        = "all_worker_mgmt"
  description = "Allow TLS inbound traffic and all outbound traffic for worker nodes"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group_rule" "all_worker_mgmt_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16"
  ]
  security_group_id = aws_security_group.all_worker_mgmt.id 
}

resource "aws_security_group_rule" "all_worker_mgmt_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.all_worker_mgmt.id 
}
