
provider "aws" {
	region = "ap-south-1"
	profile = "admin"
}

resource "aws_db_instance" "mysqldb" {
  allocated_storage    = 20
  identifier           = "dbinstance"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.30"
  instance_class       = "db.t2.micro"
  name                 = "mysqldb"
  username             = "admin"
  password             = "admin12345"
  iam_database_authentication_enabled = true
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible = true
  tags = {
    Name = "mysqldb"
  }
}
