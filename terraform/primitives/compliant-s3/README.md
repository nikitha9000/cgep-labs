# AWS S3 Secure Infrastructure



## Overview

Terraform configuration demonstrating security controls for AWS S3 storage.



## Resources and Security Controls

- Primary S3 bucket

- Separate logging bucket

- Public access blocks on both buckets

- AES-256 server-side encryption on both buckets

- Versioning enabled on both buckets

- Server access logging configuration

- Lifecycle rules to abort incomplete multipart uploads after 7 days on both buckets

- Restricted bucket policy for S3 server access log delivery

- Default resource tags



## Security Scanning

Checkov 3.4.4 local scan:

- 29 checks passed

- 6 checks failed

- 0 checks skipped



Remaining findings:

- S3 event notifications are not configured.

- Cross-region replication is not configured.

- AWS KMS encryption is not configured; AES-256 SSE-S3 is used.



These findings are documented for further risk assessment and remediation. They are not silently suppressed.



## Validation

- Terraform formatting: Passed

- Terraform initialization: Passed

- Terraform validation: Passed

- Terraform tests: Passed (1 test run, 10 security assertions)

- Checkov: 29 passed, 6 failed



## Limitations

- AWS deployment has not been verified.

- Logging delivery requires testing in AWS.

- Event notifications and cross-region replication are not deployed.

- KMS key management is a planned enhancement.

- AWS costs and operational requirements must be reviewed before deployment.



## Security

Never commit AWS credentials, Terraform state files, plan files, or sensitive variables.



## Disclaimer

Educational project for a fictional organization. This configuration is not proof of production security or regulatory compliance.
