

# S3 Security Monitoring and Detection Design



## 1. Objective



This document defines a detective monitoring approach for identifying insecure Amazon S3 bucket configurations.



The monitoring design complements preventive controls implemented through Terraform and OPA policies.



**Implementation status:** Designed. AWS deployment and live evaluation are pending.



## 2. Monitoring Scope



| Control ID | Security requirement | Detection mechanism |

|---|---|---|

| MON-01 | Detect public read access | AWS Config managed rule |

| MON-02 | Detect public write access | AWS Config managed rule |

| MON-03 | Detect configuration changes | AWS Config configuration recording |

| MON-04 | Track compliance status | AWS Config compliance evaluation |



## 3. AWS Config Managed Rules



### MON-01: Public Read Access Detection



- Rule identifier: `S3_BUCKET_PUBLIC_READ_PROHIBITED`

- Resource type: `AWS::S3::Bucket`

- Evaluation: Configuration changes and periodic

- Expected result: COMPLIANT

- Detection purpose: Identify buckets that permit public read access through bucket policies or ACLs without effective public access restrictions.

- Related internal control: C01

- Related NIST reference: AC-3 - Access Enforcement



### MON-02: Public Write Access Detection



- Rule identifier: `S3_BUCKET_PUBLIC_WRITE_PROHIBITED`

- Resource type: `AWS::S3::Bucket`

- Evaluation: Configuration changes and periodic

- Expected result: COMPLIANT

- Detection purpose: Identify buckets that permit public write access through bucket policies or ACLs without effective public access restrictions.

- Related internal control: C01

- Related NIST reference: AC-3 - Access Enforcement



## 4. Detection and Response Workflow



1\. AWS Config records supported resource configurations.

2\. AWS Config evaluates S3 bucket configurations against the managed rules.

3\. Non-compliant results are identified.

4\. Compliance changes can be routed through Amazon EventBridge and Amazon SNS.

5\. The GRC or security team reviews the finding.

6\. The team records the affected resource, risk rating, owner and remediation deadline.

7\. Remediation is performed through an approved change.

8\. AWS Config reevaluates the resource and the finding is closed after compliance is verified.



## 5. Proposed Alert Information



Each finding should capture:



- Detection rule identifier

- AWS account and region

- Affected resource identifier

- Compliance status

- Detection timestamp

- Finding severity

- Assigned owner

- Remediation action

- Closure evidence



## 6. Prerequisites



Live implementation requires:



- An active AWS account and appropriate permissions.

- AWS Config enabled in the target region.

- A configuration recorder and delivery channel.

- Appropriate permissions for AWS Config to record resource configurations.

- Managed rules deployed and evaluated.

- An approved notification and incident-handling process.



## 7. Validation Plan



| Validation activity | Expected result | Current status |

|---|---|---|

| Review managed rule identifiers | Correct AWS rule identifiers | Documented |

| Review Terraform preventive controls | Public access blocked | Local tests passed |

| Deploy AWS Config rules | Rules available in AWS | Pending |

| Evaluate S3 buckets | Compliance results generated | Pending |

| Test alert delivery | Security team receives alert | Pending |

| Verify remediation | Finding returns to COMPLIANT | Pending |



## 8. Limitations



- This document describes a monitoring design, not a deployed monitoring service.

- AWS Config findings have not been collected from a live account.

- Notification delivery has not been tested.

- Local Terraform tests use a mocked AWS provider.

- No live AWS compliance status is claimed.



## 9. References



- AWS Config - S3 bucket public read prohibited:

&#x20; https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-public-read-prohibited.html



- AWS Config - S3 bucket public write prohibited:

&#x20; https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-public-write-prohibited.html
