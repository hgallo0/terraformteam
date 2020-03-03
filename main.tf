provider "aws" {
  region  = "us-east-1"
  profile = "hgallo_sacredheart"

  assume_role {
    role_arn = "arn:aws:iam::020351640293:role/OrganizationAccountAccessRole"
  }
}

module "bastion" {
  source = "git::https://github.com/hgallo0/module_bastion_host.git"
  # launch config variables
  ssh_key = "hgallonvirginia"
  bastion_role = "arn:aws:iam::020351640293:instance-profile/cs641_profile_s3ro"

  # autoscaling
  max_size = 1
  min_size = 1
  desired_capacity = 1
  subnet_id = ["subnet-b93e9af4", "subnet-de1e45e0" ,"subnet-3d37235a",
               "subnet-d05446fe", "subnet-a78899fb", "subnet-ae22eca0"]
  azs = ["us-east-1a", "us-east-1b", "us-east-1c",
         "us-east-1d", "us-east-1e", "us-east-1f",]

  # security groups
  vpc_id = "vpc-dc3515a6"
}
