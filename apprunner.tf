resource "aws_apprunner_vpc_connector" "wordpress" {
  vpc_connector_name = "wordpress"
  security_groups    = [aws_security_group.aurora.id]
  subnets            = [aws_subnet.aurora1.id, aws_subnet.aurora2.id]
}

resource "aws_apprunner_service" "wordpress" {
  service_name = "wordpress"
  network_configuration {
    egress_configuration {
      egress_type       = "VPC"
      vpc_connector_arn = aws_apprunner_vpc_connector.wordpress.arn
    }
  }
  source_configuration {
    auto_deployments_enabled = false
    image_repository {
      image_configuration {
        port = "80"
        runtime_environment_variables = {
          WORDPRESS_DB_HOST     = aws_rds_cluster.aurora.endpoint
          WORDPRESS_DB_USER     = var.aurora_username
          WORDPRESS_DB_PASSWORD = var.aurora_password
          WORDPRESS_DB_NAME     = var.wordpress_database_name
        }
      }
      image_identifier      = "public.ecr.aws/docker/library/wordpress:6"
      image_repository_type = "ECR_PUBLIC"
    }
  }
}

resource "aws_apprunner_auto_scaling_configuration_version" "wordpress" {
  auto_scaling_configuration_name = "default"
  min_size                        = 1
  max_size                        = 1
}

output "wordpress" {
  value = aws_apprunner_service.wordpress.service_url
}