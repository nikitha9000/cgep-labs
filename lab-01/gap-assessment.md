# Gap Assessment - AWS S3 Security Compliance

Organization: TechNova Solutions
Assessment Type: Preliminary configuration review
Assessment Date: 06 November 2026

## Gap Assessment

| ID | Security Requirement | Current State | Gap Identified | Priority |
|---|---|---|---|---|
| G01 | Prevent public access | Public access blocks configured in Terraform | Deployment and effective settings not verified in AWS | High |
| G02 | Encrypt stored data | AES-256 encryption configured | Actual bucket encryption settings need verification | High |
| G03 | Recover deleted or changed data | Versioning enabled on primary bucket | Versioning and recovery process not tested; log bucket versioning not assessed | Medium |
| G04 | Record bucket access activity | Server access logging configured | Log delivery, permissions and retention not verified | High |
| G05 | Control access to cloud resources | No IAM access evidence included yet | Least-privilege permissions and access reviews need assessment | High |
| G06 | Maintain secure configurations | Terraform configuration created | Security scanning, peer review and ongoing drift checks are pending | Medium |

## Recommended Remediation

1. Deploy only after reviewing AWS costs and obtaining authorization.
2. Verify public access block settings on both buckets in AWS.
3. Verify encryption settings on both buckets.
4. Test versioning and recovery on the primary bucket.
5. Verify that server access logs are successfully delivered to the logging bucket.
6. Review IAM permissions and confirm least-privilege access.
7. Run Terraform security checks and retain the results as evidence.

## Assessment Conclusion

The Terraform configuration includes several important security controls. However, deployment, operational effectiveness and supporting evidence have not yet been verified. These gaps must be addressed before claiming compliance.

## Disclaimer

This is a preliminary educational assessment for a fictional organization, not a formal compliance audit.
