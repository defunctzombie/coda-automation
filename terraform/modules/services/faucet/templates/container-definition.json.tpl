[
  {
    "name": "faucet",
    "image": "codaprotocol/bot:${container_version}",
    "cpu": 0,
    "memory": 512,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${region}",
        "awslogs-group": "${log_group}",
        "awslogs-stream-prefix": "${log_group}"
      }
    },
    "environment" : [
        { "name" : "DISCORD_API_KEY", "value" : "${discord_api_key}" },
        { "name" : "CODA_GRAPHQL_HOST", "value" : "${coda_graphql_host}" },
        { "name" : "CODA_GRAPHQL_PORT", "value" : "${coda_graphql_port}" },
        { "name" : "FAUCET_PUBLICKEY", "value" : "${faucet_public_key}" },
        { "name" : "FAUCET_PASSWORD", "value" : "${faucet_password}" },
        { "name" : "ECHO_PUBLICKEY", "value" : "${echo_public_key}" },
        { "name" : "ECHO_PASSWORD", "value" : "${echo_password}" },
        { "name" : "FEE_AMOUNT", "value" : "${fee_amount}" }
    ]
  }
]