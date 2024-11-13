resource "random_password" "orders_secret_password" {
  length  = 20
  special = false
}

resource "aws_secretsmanager_secret" "secrets_orders" {
  name = "orders_secrets"
}

resource "aws_secretsmanager_secret_version" "secrets_version_orders" {
  secret_id     = data.aws_secretsmanager_secret.secrets_orders.id
  secret_string = jsonencode({
    BCRYPT_SALT       = "10"
    JWT_EXPIRATION    = "2d"
    JWT_SECRET_KEY    = resource.random_password.orders_secret_password
    DB_URL            = "postgres://${module.rds_orders.db_instance_username}:${random_password.orders_database_password.result}@${module.rds_orders.db_instance_address}:5432/${module.rds_orders.db_instance_name}"
  })
}
