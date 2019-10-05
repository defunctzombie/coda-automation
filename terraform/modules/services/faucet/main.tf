locals {
  service_name  = "faucet-${var.environment}"
}


resource "aws_cloudwatch_log_group" "faucet" {
  name              = local.service_name
  retention_in_days = 1
}

data "template_file" "container_definition" {
  template = "${file("${path.module}/templates/container-definition.json.tpl")}"

  vars = {
      log_group = local.service_name
      region = "us-west-2"
      discord_api_key = var.discord_api_key
      coda_graphql_host = var.coda_graphql_host
      coda_graphql_port = var.coda_graphql_port
      faucet_public_key = var.faucet_public_key
      faucet_password = var.faucet_password
      echo_public_key = var.echo_public_key
      echo_password = var.echo_password
      fee_amount = var.fee_amount
  }
}

resource "aws_ecs_task_definition" "faucet" {
  family = local.service_name
  
  container_definitions = data.template_file.container_definition.rendered
}

resource "aws_ecs_service" "faucet" {
  name = local.service_name
  cluster = var.cluster_id
  task_definition = aws_ecs_task_definition.faucet.arn

  desired_count = 1

  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 0
}