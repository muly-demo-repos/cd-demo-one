terraform {
  backend "s3" {
    bucket = "terraform-state-demonstration"
    key    = "development/orders"
    region = "us-east-1"
  }
}