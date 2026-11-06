# AWS S3 Risk Register

Organization: TechNova Solutions
Project: AWS S3 Security Compliance

| Risk ID | Risk Description | Likelihood | Impact | Score | Rating | Mitigation |
|---|---|---:|---:|---:|---|---|
| R01 | Unauthorized public access to sensitive S3 data | 3 | 5 | 15 | High | Enable and verify public access blocks |
| R02 | Data loss due to accidental deletion | 3 | 4 | 12 | High | Enable versioning and test recovery |
| R03 | Unauthorized access to stored data | 3 | 5 | 15 | High | Enforce encryption and least privilege |
| R04 | Missing access logs reduce investigation capability | 4 | 4 | 16 | High | Verify logging delivery and retention |
| R05 | Misconfigured cloud resources expose data | 3 | 5 | 15 | High | Perform Terraform security checks and reviews |

## Risk Assessment Methodology

Risk Score = Likelihood x Impact.

- 1-4: Low
- 5-9: Medium
- 10-16: High
- 17-25: Critical

## Assessment Notes

These are illustrative inherent risk scores for a fictional organization. They are not measured residual risks. Risk owners, treatment deadlines and residual scores must be assigned during a formal assessment.
