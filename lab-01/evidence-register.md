# Evidence Register - AWS S3 Security Compliance

Organization: TechNova Solutions
Project: AWS S3 Security Compliance

| Evidence ID | Control | Evidence Required | Current Status |
|---|---|---|---|
| E01 | Public access restriction | AWS S3 public access block configuration or AWS CLI output | Pending AWS verification |
| E02 | Encryption at rest | AWS S3 encryption configuration or AWS CLI output | Terraform configuration available; AWS verification pending |
| E03 | Versioning | AWS S3 versioning configuration and recovery test result | Terraform configuration available; testing pending |
| E04 | Access logging | Logging configuration and delivered log object in target bucket | Terraform configuration available; delivery verification pending |
| E05 | Resource tagging | AWS resource tags or Terraform plan output | Terraform configuration available; AWS verification pending |
| E06 | Infrastructure configuration | Terraform files and successful validation output | Available |

## Evidence Collection Guidelines

- Record the date evidence is collected.
- Identify the person who collected it.
- Store screenshots and command outputs in an organized evidence folder.
- Remove account IDs, credentials and other sensitive information before publishing evidence.
- Do not mark evidence as verified until the relevant test has passed.

## Assessment Note

Terraform source files show intended configuration. They do not independently prove that AWS resources are deployed or that controls operate effectively.

## Disclaimer

Educational evidence register for a fictional organization. No formal audit conclusion is implied.
