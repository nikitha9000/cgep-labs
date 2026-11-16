
mock_provider "aws" {}

run "s3_security_controls" {
  command = apply

  assert {
    condition = (
      aws_s3_bucket_public_access_block.primary.block_public_acls &&
      aws_s3_bucket_public_access_block.primary.block_public_policy &&
      aws_s3_bucket_public_access_block.primary.ignore_public_acls &&
      aws_s3_bucket_public_access_block.primary.restrict_public_buckets
    )
    error_message = "Primary S3 bucket must block all public access."
  }

  assert {
    condition = (
      aws_s3_bucket_public_access_block.logs.block_public_acls &&
      aws_s3_bucket_public_access_block.logs.block_public_policy &&
      aws_s3_bucket_public_access_block.logs.ignore_public_acls &&
      aws_s3_bucket_public_access_block.logs.restrict_public_buckets
    )
    error_message = "Logging S3 bucket must block all public access."
  }

  assert {
    condition = (
      one([
        for rule in aws_s3_bucket_server_side_encryption_configuration.logs.rule :
        rule.apply_server_side_encryption_by_default[0].sse_algorithm
      ]) == "AES256"
    )
    error_message = "Logging bucket must use AES256 encryption."
  }

  assert {
    condition = (
      one([
        for rule in aws_s3_bucket_server_side_encryption_configuration.primary.rule :
        rule.apply_server_side_encryption_by_default[0].sse_algorithm
      ]) == "AES256"
    )
    error_message = "Primary bucket must use AES256 encryption."
  }

  assert {
    condition = (
      aws_s3_bucket_versioning.primary.versioning_configuration[0].status == "Enabled"
    )
    error_message = "Primary bucket versioning must be enabled."
  }

  assert {
    condition = (
      aws_s3_bucket_versioning.logs.versioning_configuration[0].status == "Enabled"
    )
    error_message = "Logging bucket versioning must be enabled."
  }

  assert {
    condition = (
      one([
        for rule in aws_s3_bucket_lifecycle_configuration.logs.rule :
        rule.abort_incomplete_multipart_upload[0].days_after_initiation
      ]) == 7
    )
    error_message = "Logging bucket must abort incomplete multipart uploads after 7 days."
  }

  assert {
    condition = (
      one([
        for rule in aws_s3_bucket_lifecycle_configuration.primary.rule :
        rule.abort_incomplete_multipart_upload[0].days_after_initiation
      ]) == 7
    )
    error_message = "Primary bucket must abort incomplete multipart uploads after 7 days."
  }

  assert {
    condition = (
      aws_s3_bucket_logging.primary.target_prefix == "access-logs/"
    )
    error_message = "Primary bucket access logs must use the access-logs/ prefix."
  }

  assert {
    condition = (
      jsondecode(aws_s3_bucket_policy.logs.policy).Statement[0].Principal.Service == "logging.s3.amazonaws.com"
    )
    error_message = "Logging bucket policy must allow the S3 logging service."
  }
}
