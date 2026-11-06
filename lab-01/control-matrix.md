# Security Control Matrix
**Organization:** TechNova Solutions  
**Project:** AWS S3 Security Compliance  
**Frameworks:** ISO/IEC 27001:2022 and NIST CSF 2.0
| ID | Security Control | ISO 27001:2022 | NIST CSF 2.0 | Implementation |
|---|---|---|---|---|
| C01 | Restrict public access | A.8.3 | PR.IR-01 | S3 public access block |
| C02 | Encrypt stored data | A.8.24 | PR.DS-01 | AES-256 server-side encryption |
| C03 | Support data recovery through versioning | A.8.13 | PR.DS-11 (partial alignment) | S3 bucket versioning |
| C04 | Generate access activity logs | A.8.15 | PR.PS-04 | S3 server access logging configuration |
| C05 | Govern the use of cloud services | A.5.23 | Not directly mapped in this implementation | Cloud service governance documentation required |
| C06 | Manage infrastructure configurations | A.8.9 | PR.PS-01 | Terraform configuration |
## Assessment Notes
- S3 public access blocking is configured in Terraform.
- AES-256 server-side encryption is configured.
- Versioning is enabled on the primary bucket; this does not independently establish a tested backup capability.
- Server access logging is configured, but actual log delivery has not been verified.
- Logging bucket permissions are configured to allow the S3 logging service to deliver logs.
- Security testing and AWS deployment verification are pending.
- Terraform validation confirms configuration syntax and provider-schema validity, not operational security or regulatory compliance.
## Mapping Limitations
- Framework mappings indicate alignment, not certification or compliance.
- C03 is only partially aligned with backup requirements until backup protection and restoration testing are demonstrated.
- C05 requires separate cloud service governance evidence, such as provider assessments, responsibilities, and service reviews.
## References
- NIST Cybersecurity Framework 2.0: https://www.nist.gov/cyberframework
- ISO/IEC 27001:2022, Annex A controls.
