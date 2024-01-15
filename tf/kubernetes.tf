variable "aws_region" {
        default = "us-east-1"
}

variable "vpc_cidr" {
        default = "10.20.0.0/16"
}

variable "subnets_cidr" {
        default = "10.20.1.0/24"
}

variable "azs" {
        default = "us-east-1a"
}


provider "aws" {
        region = var.aws_region  
       access_key = "AKIAUJU24ZR3T7G3YHHH"

       secret_key = "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"

	
}
