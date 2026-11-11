
package cgep.s3_security

import rego.v1

test_compliant_plan_passes if {
    count(deny) == 0
    with input as {
        "resource_changes": [
            {
                "type": "aws_s3_bucket_public_access_block",
                "address": "aws_s3_bucket_public_access_block.primary",
                "change": {
                    "after": {
                        "block_public_acls": true,
                        "block_public_policy": true,
                        "ignore_public_acls": true,
                        "restrict_public_buckets": true
                    }
                }
            },
            {
                "type": "aws_s3_bucket_server_side_encryption_configuration",
                "address": "aws_s3_bucket_server_side_encryption_configuration.primary",
                "change": {
                    "after": {
                        "rule": [
                            {
                                "apply_server_side_encryption_by_default": [
                                    {
                                        "sse_algorithm": "AES256"
                                    }
                                ]
                            }
                        ]
                    }
                }
            }
        ]
    }
}

test_noncompliant_plan_is_denied if {
    count(deny) == 5
    with input as {
        "resource_changes": [
            {
                "type": "aws_s3_bucket_public_access_block",
                "address": "aws_s3_bucket_public_access_block.insecure",
                "change": {
                    "after": {
                        "block_public_acls": false,
                        "block_public_policy": false,
                        "ignore_public_acls": false,
                        "restrict_public_buckets": false
                    }
                }
            },
            {
                "type": "aws_s3_bucket_server_side_encryption_configuration",
                "address": "aws_s3_bucket_server_side_encryption_configuration.insecure",
                "change": {
                    "after": {
                        "rule": []
                    }
                }
            }
        ]
    }
}
