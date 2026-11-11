

GRC Control-to-Code Mapping



Organization: TechNova Solutions (Fictional)

Project: AWS S3 Security Compliance

Infrastructure Tool: Terraform

Cloud Provider: AWS

1\. Purpose



This document establishes traceability between documented GRC security controls, Terraform infrastructure resources, and planned security verification activities.



It helps reviewers identify where each control is implemented in code and what evidence is needed to demonstrate its effectiveness.

2\. Control-to-Code Mapping

Control ID	Security Requirement	Terraform Resource	Configuration Location	Verification Method

C01	Restrict public access	aws\_s3\_bucket\_public\_access\_block.primary and .logs	terraform/primitives/compliant-s3/main.tf	Inspect all four public access block settings

C02	Encrypt stored data	aws\_s3\_bucket\_server\_side\_encryption\_configuration.primary and .logs	terraform/primitives/compliant-s3/main.tf	Verify AES256 encryption configuration

C03	Support data recovery	aws\_s3\_bucket\_versioning.primary	terraform/primitives/compliant-s3/main.tf	Verify versioning is Enabled and perform a recovery test

C04	Generate access activity logs	aws\_s3\_bucket\_logging.primary	terraform/primitives/compliant-s3/main.tf	Verify logging target and actual log delivery

C05	Govern cloud service usage	Governance documentation and review process	lab-01/ and documentation/	Review AWS responsibilities and cloud service governance

C06	Manage infrastructure configurations	Terraform provider, resources, variables and outputs	terraform/primitives/compliant-s3/	Run Terraform formatting, validation and security scanning

3\. Technical Verification Commands



Run these commands from the Terraform project directory:



cd C:\\Users\\Nikit\\cgep-labs\\terraform\\primitives\\compliant-s3



terraform fmt -check

terraform validate



These checks validate formatting and Terraform configuration. They do not prove that AWS resources have been deployed or that controls work operationally.

4\. Evidence Requirements

Control ID	Required Evidence	Current Evidence Status

C01	Terraform configuration and deployed bucket access settings	Configuration available; deployment verification pending

C02	Encryption configuration and deployed bucket encryption settings	Configuration available; deployment verification pending

C03	Versioning configuration and successful recovery test	Configuration available; recovery test pending

C04	Logging configuration and sample delivered log objects	Configuration available; delivery verification pending

C05	Cloud service governance review and responsibility records	Documentation pending

C06	Terraform validation and security scan results	Formatting and validation completed; security scanning pending

5\. Limitations



&#x20;   Resource references identify intended Terraform implementation points.



&#x20;   Terraform validation does not establish deployed security.



&#x20;   Operational evidence must be collected from the AWS environment.



&#x20;   Versioning is not a substitute for a separately tested backup strategy.



&#x20;   Framework mappings do not constitute certification or audit assurance.



6\. Review and Maintenance



Review this mapping whenever:



&#x20;   A Terraform resource is added, removed or modified.



&#x20;   A security control changes.



&#x20;   A risk or compliance requirement changes.



&#x20;   A new automated test or security check is introduced.



Status: Initial control-to-code traceability documented. Operational verification and automated policy testing remain pending.

⋮⋮

⋮⋮

