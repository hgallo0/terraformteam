terraform {
  backend "s3" {
    bucket         = "sp2020sc"
    key            = "terraformteam"
    encrypt        = "true"
    region         = "us-east-1"
    dynamodb_table = "cs622"
    profile        = "hgallo_sacredheart"
  }
}
