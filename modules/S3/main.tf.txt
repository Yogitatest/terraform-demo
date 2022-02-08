
resource "aws_s3_bucket" "bucket" {	
	bucket  = ${var.bucket}
	acl     = ${var.acl}
	tags    = ${var.tags}
	
	dynamic "versioning" {
      for_each = length(keys(var.versioning)) == 0 ? [] : [var.versioning]

      content {
        enabled    = lookup(versioning.value, "enabled", null)
        mfa_delete = lookup(versioning.value, "mfa_delete", null)
      }
    }
}




