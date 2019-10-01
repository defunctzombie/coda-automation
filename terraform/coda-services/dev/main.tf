locals {
  environment = "dev"
  name = "coda-services"
}

terraform {
  required_version = "~> 0.12.0"
  backend "s3" {
    key     = "test-net/terraform-coda-services-dev.tfstate"
    encrypt = true
    region  = "us-west-2"
    bucket  = "o1labs-terraform-state"
    acl     = "bucket-owner-full-control"
  }
}

provider "aws" {
  region = "us-west-2"
}

data "aws_secretsmanager_secret" "prometheus_remote_write_config" {
  name = "coda-services/prometheus/remote_write_config"
}

data "aws_secretsmanager_secret_version" "current_prometheus_remote_write_config" {
  secret_id = "${data.aws_secretsmanager_secret.prometheus_remote_write_config.id}"
}

data "aws_secretsmanager_secret" "prometheus_aws_keys" {
  name = "coda-services/prometheus/aws_keys"
}

data "aws_secretsmanager_secret_version" "current_prometheus_aws_keys" {
  secret_id = "${data.aws_secretsmanager_secret.prometheus_aws_keys.id}"
}

module "ecs-cluster" {
    #source = "github.com/codaprotocol/coda-automation/terraform/modules/ecs"
    source = "../../modules/ecs"

    name = "${local.name}"
    environment = "${local.environment}"
}

module "prometheus-service" {
    #source = "github.com/codaprotocol/coda-automation/terraform/modules/services/prometheus"
    source = "../../modules/services/prometheus"

    cluster_id = "${module.ecs-cluster.cluster_id}"
    environment = "${local.environment}"
    remote_write_uri = jsondecode(data.aws_secretsmanager_secret_version.current_prometheus_remote_write_config.secret_string)["remote_write_uri"]
    remote_write_username = jsondecode(data.aws_secretsmanager_secret_version.current_prometheus_remote_write_config.secret_string)["remote_write_username"]
    remote_write_password = jsondecode(data.aws_secretsmanager_secret_version.current_prometheus_remote_write_config.secret_string)["remote_write_password"]
    aws_access_key = jsondecode(data.aws_secretsmanager_secret_version.current_prometheus_aws_keys.secret_string)["aws_access_key"]
    aws_secret_key = jsondecode(data.aws_secretsmanager_secret_version.current_prometheus_aws_keys.secret_string)["aws_secret_key"]
}


