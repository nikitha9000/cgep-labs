# CGE-P Labs - GRC Engineering Portfolio



## Overview



This repository contains practical Governance, Risk, and Compliance (GRC) engineering projects developed as part of the CGE-P learning program.



The projects demonstrate security governance, risk assessment, compliance documentation, Infrastructure as Code (IaC), policy enforcement, automated testing, security monitoring design, and evidence generation.



## Project 1: AWS S3 Security Compliance



**Organization:** TechNova Solutions (Fictional)



**Objective:** Design a secure AWS S3 storage environment using Terraform and document its alignment with security and compliance requirements.



### Security Controls



\- Restrict public access to S3 buckets.

\- Enable AES-256 encryption at rest.

\- Enable bucket versioning.

\- Configure server access logging.

\- Apply consistent infrastructure tags.

\- Restrict access log delivery permissions.



### Technologies



\- Terraform

\- Amazon Web Services (AWS)

\- Open Policy Agent (OPA/Rego)

\- Git and GitHub

\- GitHub Actions

\- ISO/IEC 27001:2022

\- NIST Cybersecurity Framework 2.0

\- NIST SP 800-53 Revision 5



### GRC Documentation



\- Asset register

\- Risk register

\- Security control matrix

\- Gap assessment

\- Evidence register

\- Remediation plan

\- Control-to-code mapping



### Security Engineering



\- Infrastructure as Code

\- Policy as Code

\- Terraform mock-provider tests

\- Automated policy validation

\- Checkov infrastructure security scanning

\- GitHub Actions CI/CD

\- AWS Config monitoring and detection design

\- Automated local validation evidence



### Validation Status



Local Terraform formatting, validation, mock-provider tests, OPA policy checks, OPA tests, and control mapping validation have passed.



Local validation evidence is generated in:



`evidence/generated/local-validation-evidence.json`



GitHub Actions execution must be verified after pushing the changes.



**AWS deployment and live monitoring have not been verified.** AWS access is currently unavailable.



## Repository Structure



\- `.github/workflows/` - CI/CD workflow

\- `documentation/` - Control-to-code mapping

\- `evidence/` - Generated validation evidence

\- `lab-01/` - GRC assessment documentation

\- `monitoring/` - Security monitoring design

\- `policies/` - OPA security policies

\- `scripts/` - Validation and evidence generation scripts

\- `terraform/` - Secure S3 infrastructure



## Disclaimer



This is an educational GRC engineering portfolio. Framework mappings indicate intended alignment or partial support and do not constitute certification, formal audit assurance, or proof of regulatory compliance.
