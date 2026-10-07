terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.63.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "eu-north-1"
}

resource "aws_vpc" "main_vpc"{
    cidr_block= local.vpc_cidr_block
    tags={
        Name="Terraform_Project_vpc"
    }
}

resource "aws_subnet" "Public_subnet" {

  vpc_id=aws_vpc.main_vpc.id

  cidr_block=local.public_subnet_cidr_block
  tags={
    Name="Terraform_Project_Public_subnet"
  }

}




resource "aws_internet_gateway" "IGW"{
  vpc_id=aws_vpc.main_vpc.id

  tags={
    Name="Terraform_Project_IGW"
  }
}

resource "aws_default_route_table" "def_route_table" {
  default_route_table_id= aws_vpc.main_vpc.default_route_table_id

# Internet Gateway Route
route {
  cidr_block=local.IGW_cidr_block
  gateway_id=aws_internet_gateway.IGW.id

}
tags = {
  Name = "Terraform_Project_def_route_table"
}

  
}

module "EC2_mod"{
  source ="./EC2_mod"
  subnet_id=aws_subnet.Public_subnet.id
  vpc_id=aws_vpc.main_vpc.id
  IP_address=var.IP_address

  Database_User_password=var.Database_User_password
  Database_User_name=var.Database_User_name
  Database_name=var.Database_name
  Databas_root_password=var.Databas_root_password

}





