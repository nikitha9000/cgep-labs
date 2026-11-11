Security Control Matrix



Organization: TechNova Solutions (Fictional)

Project: AWS S3 Security Compliance

Frameworks: ISO/IEC 27001:2022 and NIST CSF 2.0



1\. Control-to-Risk Mapping



Control ID



Security Control



ISO 27001:2022



NIST CSF 2.0



Implementation



Related Risk IDs



C01



Restrict public access



A.8.3



PR.IR-01



S3 public access block



R01, R03



C02



Encrypt stored data



A.8.24



PR.DS-01



AES-256 server-side encryption



R03



C03



Support data recovery through versioning



A.8.13



PR.DS-11 (partial alignment)



S3 bucket versioning



R02



C04



Generate access activity logs



A.8.15



PR.PS-04



S3 server access logging configuration



R04



C05



Govern the use of cloud services



A.5.23



Not directly mapped in this implementation



Cloud service governance documentation required



R05



C06



Manage infrastructure configurations



A.8.9



PR.PS-01



Terraform configuration



R05



2\. Control Implementation Status



Control ID



Current Status



Verification Required



C01



Configured in Terraform



Verify deployed bucket public access settings



C02



Configured in Terraform



Verify encryption on deployed buckets



C03



Configured in Terraform



Perform version recovery test



C04



Configured in Terraform



Verify actual log delivery and retention



C05



Documentation required



Complete cloud service governance review



C06



Terraform configuration available



Perform security scanning and configuration review



3\. Assessment Notes



S3 public access blocking is configured in Terraform.



AES-256 server-side encryption is configured.



Versioning is enabled on the primary bucket; this does not independently establish a tested backup capability.



Server access logging is configured, but actual log delivery has not been verified.



Logging bucket permissions are configured to allow the S3 logging service to deliver logs.



Security testing and AWS deployment verification are pending.



Terraform validation confirms configuration syntax and provider-schema validity, not operational security or regulatory compliance.



4\. Mapping Limitations



Framework mappings indicate intended alignment, not certification or compliance.



C03 is only partially aligned with backup requirements until backup protection and restoration testing are demonstrated.



C05 requires separate cloud service governance evidence, such as provider assessments, responsibilities, and service reviews.



Risk-to-control mappings identify relevant controls; they do not prove that risks have been fully mitigated.



5\. References



NIST Cybersecurity Framework 2.0: https://www.nist.gov/cyberframework



ISO/IEC 27001:2022, Annex A controls.



Status: Initial control-to-risk mapping documented. Implementation verification and evidence collection remain pending.
