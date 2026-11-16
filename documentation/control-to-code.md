GRC Control-to-Code Mapping



Organization: TechNova Solutions (Fictional)

Project: AWS S3 Security Compliance

Infrastructure Tool: Terraform

Cloud Provider: AWS

Framework: NIST SP 800-53 Revision 5



1\. Purpose



This document establishes bidirectional traceability between internal GRC controls, NIST SP 800-53 Rev. 5 control references, Terraform infrastructure resources, OPA policies, automated tests, and required evidence.



It identifies where security requirements are implemented in code and how their implementation can be verified.



NIST control references indicate alignment or partial support. They do not establish complete control implementation, certification, or audit assurance.



2\. Control-to-Code Mapping (NIST to Implementation)



Internal ID



NIST SP 800-53 Rev. 5



Security requirement



Terraform implementation



Verification



C01



AC-3 - Access Enforcement



Restrict public access to S3 buckets



aws_s3_bucket_public_access_block.primary and .logs



Terraform test and OPA policy



C02



SC-28 - Protection of Information at Rest



Encrypt stored data



aws_s3_bucket_server_side_encryption_configuration.primary and .logs



Terraform test and OPA policy



C03



CP-9 - System Backup (related control; partial support only)



Support data recovery



aws_s3_bucket_versioning.primary



Terraform test; operational recovery test pending



C04



AU-2 - Event Logging; AU-3 - Content of Audit Records



Generate access activity records



aws_s3_bucket_logging.primary



Terraform test and operational log-delivery verification



C05



SA-9 - External System Services



Govern cloud service usage and responsibilities



Governance documentation under lab-01/ and documentation/



Review responsibility records and cloud service governance



C06



CM-6 - Configuration Settings



Manage approved infrastructure configuration



Terraform provider, resources, variables, outputs, and tags



Terraform formatting, validation, tests, and security scanning



Mapping limitations:



C03 provides only partial alignment with CP-9. S3 versioning is not a complete backup strategy.



C04 configures access logging. It does not independently establish that logs are reviewed, retained, or protected as required by broader audit controls.



AU-6 (Audit Record Review, Analysis, and Reporting) is a relevant additional control for a future log-review process; it is not currently claimed as implemented.



C05 requires organizational governance evidence beyond Terraform configuration.



3\. Reverse Traceability (Implementation to NIST)



Implementation component



Internal control



NIST reference



aws_s3_bucket_public_access_block.primary



C01



AC-3 - Access Enforcement



aws_s3_bucket_public_access_block.logs



C01



AC-3 - Access Enforcement



aws_s3_bucket_server_side_encryption_configuration.primary



C02



SC-28 - Protection of Information at Rest



aws_s3_bucket_server_side_encryption_configuration.logs



C02



SC-28 - Protection of Information at Rest



aws_s3_bucket_versioning.primary



C03



CP-9 - System Backup (related control; partial support only)



aws_s3_bucket_logging.primary



aws_s3_bucket_policy.logs



C04



AU-2 - Event Logging; AU-3 - Content of Audit Records



Cloud governance documentation



C05



SA-9 - External System Services



Terraform provider and resource configuration



C06



CM-6 - Configuration Settings



4\. Policy and Test Traceability



Internal control



OPA policy coverage



Terraform native test coverage



Current status



C01



Public access block rules



Both buckets' four public access settings



Implemented and tested



C02



AES256 encryption rule



Both buckets' encryption settings



Implemented and tested



C03



Not yet implemented



Primary bucket versioning



Terraform test implemented



C04



Not yet implemented



Primary bucket logging prefix



Terraform test implemented



C05



Not applicable to current infrastructure policy



Not implemented



Governance review pending



C06



Not yet implemented



Not fully covered



Formatting and validation available; further checks pending



OPA policy files:



policies/terraform/s3_security.rego



policies/terraform/s3_security_test.rego



Terraform test file:



terraform/primitives/compliant-s3/compliant_s3.tftest.hcl



The current OPA policy explicitly enforces C01 and C02. The remaining controls require additional policy coverage where technically appropriate.



5\. Technical Verification Commands



Run these commands from the Terraform project directory:



terraform fmt -check

terraform validate

terraform test



Run OPA tests from the repository root:



opa check policies/terraform/

opa test policies/terraform/ -v



Run the configured Checkov security scan:



checkov --directory terraform/primitives/compliant-s3 --framework terraform



These checks validate code and configuration. Mock-provider Terraform tests do not establish that AWS resources have been deployed or that controls operate successfully in a live environment.



6\. Evidence Requirements



Control



Required evidence



Current evidence status



C01



Terraform configuration, test results, and deployed bucket public-access settings



Configuration and mock test available; deployment verification pending



C02



Encryption configuration, test results, and deployed bucket encryption settings



Configuration and mock test available; deployment verification pending



C03



Versioning configuration and successful recovery test



Configuration and mock test available; recovery test pending



C04



Logging configuration and sample delivered log objects



Configuration and mock test available; delivery verification pending



C05



Cloud service governance review and responsibility records



Documentation and governance review pending



C06



Terraform validation, policy tests, and security scan results



Formatting, validation, Terraform test and OPA tests available; Checkov results require review



Evidence must be collected from the appropriate source and must not be represented as operationally verified until the relevant verification has actually occurred.



7\. Limitations



Resource references identify intended Terraform implementation points.



Terraform validation does not establish deployed security.



Mock-provider tests validate configuration assertions, not actual AWS enforcement.



Operational evidence must be collected from the AWS environment.



Versioning is not a substitute for a separately tested backup and recovery strategy.



Access logging configuration does not prove successful log delivery.



Cloud governance requires organizational policies, agreements, and assigned responsibilities.



Framework mappings do not constitute certification or audit assurance.



8\. Review and Maintenance



Review this mapping whenever:



A Terraform resource is added, removed, or modified.



An OPA policy or automated test changes.



A security control or compliance requirement changes.



A new evidence collection mechanism is introduced.



The NIST SP 800-53 control catalog is updated.



The mapping should be checked against the actual Terraform resources, policy rules, test files, and evidence artifacts during each significant repository change.



9\. Current Status



Status: Initial bidirectional control-to-code traceability documented.



C01 and C02 have OPA policy enforcement and Terraform native test coverage. C03 and C04 have Terraform native test coverage. C05 governance evidence and broader C06 verification remain incomplete. Operational AWS verification and automated evidence collection remain pending.



Reference: NIST Special Publication 800-53 Revision 5, Security and Privacy Controls for Information Systems and Organizations.





## 10. Monitoring-to-Control Traceability



The monitoring design defines proposed AWS Config detection rules for identifying public S3 bucket access.



| Monitoring ID | Detection Rule | Related Control | NIST SP 800-53 Rev. 5 | Detection Purpose | Implementation Status |
|---|---|---|---|---|---|
| MON-01 | S3_BUCKET_PUBLIC_READ_PROHIBITED | C01 | AC-3 | Detect prohibited public read access to S3 buckets | Designed; AWS deployment pending |
| MON-02 | S3_BUCKET_PUBLIC_WRITE_PROHIBITED | C01 | AC-3 | Detect prohibited public write access to S3 buckets | Designed; AWS deployment pending |



**Monitoring design reference:** `monitoring/s3-monitoring-design.md`



**Evidence limitation:** These monitoring rules are documented as a proposed design. AWS Config deployment, live rule evaluation, alert delivery, and operational response have not been verified because AWS access is unavailable.



The monitoring design must be reviewed whenever the related Terraform controls, policies, or security requirements change.
