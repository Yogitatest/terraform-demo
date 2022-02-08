variable "bucket" {
  description = "The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = string
}

variable "acl" {
  description = "The ACL to apply. Defaults to private"
  type        = string
  default     = "private"
}

variable "tags" {
  description = "A mapping of tags to assign to the bucket."
  type        = map(string)
}

variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default     = {}
}


