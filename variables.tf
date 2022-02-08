variable "region" {
    default = "ap-south-1"
	type    = string
    description = "AWS Region to deploy to"
}

variable "environment" {
    type    = string
    description = "AWS environment to deploy app like dev, stage, prod"
}

variable "app" {
    type    = string
	default = "demo"
}

