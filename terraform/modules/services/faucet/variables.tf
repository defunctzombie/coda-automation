variable "cluster_id" {
  description = "The ECS cluster ID"
  type        = string
}

variable "environment" {
  description = "The environment the service is running in"
  type        = string
  default = "dev"
}

variable "container_version" {
  description = "The version of the container to be used when deploying the Faucet Service"
  type        = string
  default = "0.0.8-fix"
}

variable "discord_api_key" {
  description = "A Discord Bot API Key"
  type        = string
  default = "dev"
}

variable "coda_graphql_host" {
  description = "The hostname of the Coda GraphQL Endpoint"
  type        = string
  default = "localhost"
}

variable "coda_graphql_port" {
  description = "The hostname of the Coda GraphQL Endpoint"
  type        = string
  default = "3085"
}

variable "faucet_public_key" {
  description = "The Public Key to be used by the Faucet Service, must be installed as a wallet on the Coda Daemon"
  type        = string
}

variable "faucet_password" {
  description = "The password for the private key in use by the Faucet Service"
  type        = string
}

variable "echo_public_key" {
  description = "The Public Key to be used by the Echo Service, must be installed as a wallet on the Coda Daemon"
  type        = string
}

variable "echo_password" {
  description = "The password for the private key in use by the Echo Service"
  type        = string
}

variable "fee_amount" {
  description = "The default fee to be used by the Faucet and Echo Services"
  type        = string
}