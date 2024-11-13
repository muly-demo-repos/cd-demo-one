terraform {
  backend "s3" {
    bucket = "terraform-state-demonstration"
    key    = "development"
    region = "us-east-1"
  }
}