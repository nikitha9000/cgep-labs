$root = Split-Path -Parent $PSScriptRoot

$mappingFile = Join-Path $root "documentation/control-to-code.md"
$terraformFile = Join-Path $root "terraform/primitives/compliant-s3/main.tf"
$policyFile = Join-Path $root "policies/terraform/s3_security.rego"
$testFile = Join-Path $root "terraform/primitives/compliant-s3/compliant_s3.tftest.hcl"
$monitoringFile = Join-Path $root "monitoring/s3-monitoring-design.md"
$files = @(
    $mappingFile,
    $terraformFile,
    $policyFile,
    $testFile
$files = @(
    $mappingFile,
    $terraformFile,
    $policyFile,
    $testFile,
    $monitoringFile
)
)

foreach ($file in $files) {
    if (-not (Test-Path $file)) {
        throw "Required file missing: $file"
    }
}

$mapping = Get-Content $mappingFile -Raw
$terraform = Get-Content $terraformFile -Raw
$policy = Get-Content $policyFile -Raw
$tests = Get-Content $testFile -Raw
$monitoring = Get-Content $monitoringFile -Raw

$errors = @()

# Verify internal control identifiers.
$controls = @("C01", "C02", "C03", "C04", "C05", "C06")

foreach ($control in $controls) {
    if ($mapping -notmatch "(?<![A-Za-z0-9])$control(?![A-Za-z0-9])") {
        $errors += "Missing internal control: $control"
    }
}

# Verify all documented NIST references.
$nistControls = @(
    "AC-3",
    "SC-28",
    "CP-9",
    "AU-2",
    "AU-3",
    "SA-9",
    "CM-6"
)

foreach ($control in $nistControls) {
    if ($mapping -notmatch [regex]::Escape($control)) {
        $errors += "Missing NIST reference: $control"
    }
}

# Verify Terraform resources exist and are documented.
$resources = @(
    "aws_s3_bucket_public_access_block.primary",
    "aws_s3_bucket_public_access_block.logs",
    "aws_s3_bucket_server_side_encryption_configuration.primary",
    "aws_s3_bucket_server_side_encryption_configuration.logs",
    "aws_s3_bucket_versioning.primary",
    "aws_s3_bucket_logging.primary",
    "aws_s3_bucket_policy.logs"
)

foreach ($resource in $resources) {
    $parts = $resource -split "\."
    $pattern = 'resource\s+"' +
        [regex]::Escape($parts[0]) +
        '"\s+"' +
        [regex]::Escape($parts[1]) +
        '"'

    if ($terraform -notmatch $pattern) {
        $errors += "Terraform resource declaration missing: $resource"
    }

    if ($mapping -notmatch [regex]::Escape($resource)) {
        $errors += "Resource missing from control-to-code documentation: $resource"
    }
}

# Verify OPA covers the four public access settings.
$policyAssertions = @(
    "aws_s3_bucket_public_access_block",
    "block_public_acls",
    "block_public_policy",
    "ignore_public_acls",
    "restrict_public_buckets",
    "aws_s3_bucket_server_side_encryption_configuration",
    "AES256"
)

foreach ($assertion in $policyAssertions) {
    if ($policy -notmatch [regex]::Escape($assertion)) {
        $errors += "OPA policy is missing expected enforcement: $assertion"
    }
}

# Verify Terraform test coverage for both buckets and logging.
$testAssertions = @(
    "aws_s3_bucket_public_access_block.primary",
    "aws_s3_bucket_public_access_block.logs",
    "aws_s3_bucket_server_side_encryption_configuration.primary",
    "aws_s3_bucket_server_side_encryption_configuration.logs",
    "block_public_acls",
    "block_public_policy",
    "ignore_public_acls",
    "restrict_public_buckets",
    "sse_algorithm",
    "versioning_configuration",
    "aws_s3_bucket_logging.primary",
    "target_prefix",
    "aws_s3_bucket_policy.logs",
    "logging.s3.amazonaws.com"
)

foreach ($assertion in $testAssertions) {
    if ($tests -notmatch [regex]::Escape($assertion)) {
        $errors += "Terraform test is missing expected coverage: $assertion"
    }
}


# Verify monitoring design and control traceability.
$monitoringAssertions = @(
    "S3_BUCKET_PUBLIC_READ_PROHIBITED",
    "S3_BUCKET_PUBLIC_WRITE_PROHIBITED",
    "MON-01",
    "MON-02",
    "MON-03",
    "MON-04",
    "AWS Config Configuration recording",
    "AWS Config Compliance Evaluation"
)

foreach ($assertion in $monitoringAssertions) {
    if ($monitoring -notmatch [regex]::Escape($assertion)) {
        $errors += "Monitoring design is missing: $assertion"
    }
}

# Verify MON-01 and MON-02 map to C01 and NIST AC-3.
if ($mapping -notmatch '(?m)^\| MON-01 \|.*\| C01 \| AC-3 \|') {
    $errors += "MON-01 mapping to C01 and AC-3 is missing."
}

if ($mapping -notmatch '(?m)^\| MON-02 \|.*\| C01 \| AC-3 \|') {
    $errors += "MON-02 mapping to C01 and AC-3 is missing."
}

# Verify MON-03 and MON-04 have traceability entries.
if ($mapping -notmatch '(?m)^\| MON-03 \|') {
    $errors += "MON-03 traceability mapping is missing."
}

if ($mapping -notmatch '(?m)^\| MON-04 \|') {
    $errors += "MON-04 traceability mapping is missing."
}

# Report validation results.
if ($errors.Count -gt 0) {
    Write-Host "`nCONTROL MAPPING VALIDATION FAILED" -ForegroundColor Red

    foreach ($errorMessage in $errors) {
        Write-Host " - $errorMessage" -ForegroundColor Red
    }

    exit 1
}

Write-Host "`nCONTROL MAPPING VALIDATION PASSED" -ForegroundColor Green
Write-Host "Six internal controls verified."
Write-Host "NIST references verified."
Write-Host "Terraform declarations and documentation verified."
Write-Host "OPA enforcement and test coverage verified."
Write-Host "MON-01 through MON-04 monitoring traceability verified."