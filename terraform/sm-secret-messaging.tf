resource "random_password" "messaging_secret_password" {
  length  = 20
  special = false
}

resource "aws_secretsmanager_secret" "secrets_messaging" {
  name = "messaging_secrets"
}

resource "aws_secretsmanager_secret_version" "secrets_version_messaging" {
  secret_id     = aws_secretsmanager_secret.secrets_messaging.id
  secret_string = jsonencode({
    BCRYPT_SALT       = "10"
    JWT_EXPIRATION    = "2d"
    JWT_SECRET_KEY    = random_password.messaging_secret_password.result
    DB_URL            = "postgres://${module.rds_messaging.db_instance_username}:${random_password.messaging_database_password.result}@${module.rds_messaging.db_instance_address}:5432/${module.rds_messaging.db_instance_name}"
  })
}
