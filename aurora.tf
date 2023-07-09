resource "aws_db_subnet_group" "aurora" {
  subnet_ids = [aws_subnet.aurora1.id, aws_subnet.aurora2.id]
}

resource "aws_rds_cluster" "aurora" {
  engine               = "aurora-mysql"
  engine_mode          = "serverless"
  db_subnet_group_name = aws_db_subnet_group.aurora.name
  master_username      = var.aurora_username
  master_password      = var.aurora_password
  scaling_configuration {
    min_capacity = 1
    max_capacity = 1
  }
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.aurora.id]
}