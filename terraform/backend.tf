terraform {
  backend "s3" {
    bucket = "terraform-state-demonstration"
    key    = "development/messaging"
    region = "us-east-1"
  }
}