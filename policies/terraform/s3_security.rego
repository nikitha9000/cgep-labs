
package cgep.s3_security

import rego.v1

# C01: Require all S3 public access block settings.

deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_s3_bucket_public_access_block"
    after := object.get(rc.change, "after", {})
    object.get(after, "block_public_acls", false) != true
    msg := sprintf("%s: block_public_acls must be true", [rc.address])
}

deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_s3_bucket_public_access_block"
    after := object.get(rc.change, "after", {})
    object.get(after, "block_public_policy", false) != true
    msg := sprintf("%s: block_public_policy must be true", [rc.address])
}

deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_s3_bucket_public_access_block"
    after := object.get(rc.change, "after", {})
    object.get(after, "ignore_public_acls", false) != true
    msg := sprintf("%s: ignore_public_acls must be true", [rc.address])
}

deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_s3_bucket_public_access_block"
    after := object.get(rc.change, "after", {})
    object.get(after, "restrict_public_buckets", false) != true
    msg := sprintf("%s: restrict_public_buckets must be true", [rc.address])
}

# C02: Require AES-256 server-side encryption.

encryption_is_aes256(after) if {
    some rule in object.get(after, "rule", [])
    some config in object.get(rule, "apply_server_side_encryption_by_default", [])
    object.get(config, "sse_algorithm", "") == "AES256"
}

deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_s3_bucket_server_side_encryption_configuration"
    after := object.get(rc.change, "after", {})
    not encryption_is_aes256(after)
    msg := sprintf("%s: AES256 server-side encryption is required", [rc.address])
}
