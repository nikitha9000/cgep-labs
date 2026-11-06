# Lab 01 - AWS S3 Security Compliance

## Project Overview
This project demonstrates cloud security compliance using Terraform and AWS S3.

## Business Scenario
TechNova Solutions stores sensitive business information in AWS S3 and needs to protect it from unauthorized access, data loss and misconfiguration.

## Security Objectives
- Block public access to S3 buckets
- Enable encryption at rest
- Enable versioning for data recovery
- Configure server access logging
- Apply consistent resource tags

## Technologies
- Terraform
- AWS S3
- ISO/IEC 27001:2022
- NIST Cybersecurity Framework 2.0

## Current Implementation
- S3 public access blocks configured
- AES-256 encryption configured
- Versioning enabled on the primary bucket
- Separate logging bucket configured
- Server access logging configured

## Validation
- Terraform formatting check: Passed
- Terraform initialization: Passed
- Terraform validation: Passed

## Limitations
- AWS deployment has not been verified
- Logging delivery requires testing
- Security evidence and compliance testing are pending

## Deliverables
- Security control matrix
- Risk register
- Gap assessment (to be completed)
- Evidence register (to be completed)
- Remediation plan (to be completed)

## Disclaimer
Educational project using a fictional organization. This is not an independent ISO 27001 certification or audit.
