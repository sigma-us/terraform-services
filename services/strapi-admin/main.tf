provider "aws" {
  # shared_credentials_files = ["~/.aws/credentials"]
  profile = var.aws_profile
  region  = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }

  backend "s3" {
    bucket         = "strapi-admin-tf-state"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/strapi-admin-tf-state"
    dynamodb_table = "strapi-admin-tf-lock"
  }
}


# module "vpc" {
#   source = "git@github.com:sigma-us/terraform-modules.git//AWS/modules/vpc"
# }

# module "public_subnet" {
#   source = "git@github.com:sigma-us/terraform-modules.git//AWS/modules/public-subnet"

#   vpc_id = module.vpc.vpc_id
# }

# module "internet_gateway" {
#   source = "git@github.com:sigma-us/terraform-modules.git//AWS/modules/internet-gateway"

#   vpc_id = module.vpc.vpc_id
# }

# module "route_table" {
#   source = "git@github.com:sigma-us/terraform-modules.git//AWS/modules/route-table"

#   vpc_id              = module.vpc.vpc_id
#   internet_gateway_id = module.internet_gateway.internet_gateway_id
#   public_subnet_id    = module.public_subnet.public_subnet_id
# }

# module "ec2" {
#   source = "git@github.com:sigma-us/terraform-modules.git//AWS/modules/ec2"

#   vpc_id                  = module.vpc.vpc_id
#   public_subnet_id        = module.public_subnet.public_subnet_id

#   ec2_ssh_key_name        = var.ec2_ssh_key_name
#   ec2_ssh_public_key_path = var.ec2_ssh_public_key_path
# }