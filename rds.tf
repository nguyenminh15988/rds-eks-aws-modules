module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "4.2.0" #latest at 17/04/2022

  identifier = "myeksdb"

  engine            = "mysql"
  engine_version    = "5.7.25"
  instance_class    = "db.t2.micro"
  allocated_storage = 5

  db_name  = "demodb"
  username = "admin"
  password = var.rds_admin_password
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [aws_security_group.rds-internal.id]

  tags = {
    Provisioner = "terraform"
  }

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # DB subnet group
  subnet_ids = module.vpc.private_subnets

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"
}