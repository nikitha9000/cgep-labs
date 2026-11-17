
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$outputDir = Join-Path $root "evidence/generated"

New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

$checks = @()

function Add-Check {
    param(
        [string]$Name,
        [string]$Command,
        [string]$Status,
        [string]$Details
    )

    $script:checks += [PSCustomObject]@{
        name       = $Name
        command    = $Command
        status     = $Status
        details    = $Details
        checked_at = (Get-Date).ToUniversalTime().ToString("o")
    }
}

# Check Terraform formatting
Push-Location $root
try {
    $result = & terraform fmt -check -recursive terraform/ 2>&1
    $exitCode = $LASTEXITCODE

    if ($exitCode -eq 0) {
        Add-Check "Terraform formatting" "terraform fmt -check -recursive terraform/" "PASS" "Formatting check passed."
    }
    else {
        $details = ($result | Out-String).Trim()
        if ([string]::IsNullOrWhiteSpace($details)) {
            $details = "Terraform formatting failed with exit code $exitCode and returned no output."
        }
        Add-Check "Terraform formatting" "terraform fmt -check -recursive terraform/" "FAIL" $details
    }
}
catch {
    Add-Check "Terraform formatting" "terraform fmt -check -recursive terraform/" "NOT_RUN" $_.Exception.Message
}
finally {
    Pop-Location
}

# Check Terraform configuration
$module = Join-Path $root "terraform/primitives/compliant-s3"
Push-Location $module
try {
    $result = & terraform validate 2>&1
    $exitCode = $LASTEXITCODE

    if ($exitCode -eq 0) {
        Add-Check "Terraform validation" "terraform validate" "PASS" "Configuration is valid."
    }
    else {
        $details = ($result | Out-String).Trim()
        if ([string]::IsNullOrWhiteSpace($details)) {
            $details = "Terraform validation failed with exit code $exitCode and returned no output."
        }
        Add-Check "Terraform validation" "terraform validate" "FAIL" $details
    }
}
catch {
    Add-Check "Terraform validation" "terraform validate" "NOT_RUN" $_.Exception.Message
}
finally {
    Pop-Location
}

# Check Terraform mocked tests
Push-Location $module
try {
    $result = & terraform test 2>&1
    $exitCode = $LASTEXITCODE

    if ($exitCode -eq 0) {
        Add-Check "Terraform tests" "terraform test" "PASS" "Mock-provider tests passed; this does not verify deployed AWS resources."
    }
    else {
        $details = ($result | Out-String).Trim()
        if ([string]::IsNullOrWhiteSpace($details)) {
            $details = "Terraform tests failed with exit code $exitCode and returned no output."
        }
        Add-Check "Terraform tests" "terraform test" "FAIL" $details
    }
}
catch {
    Add-Check "Terraform tests" "terraform test" "NOT_RUN" $_.Exception.Message
}
finally {
    Pop-Location
}

# Check OPA policy syntax
$policyDir = Join-Path $root "policies/terraform"
Push-Location $root
try {
    $result = opa check $policyDir 2>&1
    if ($LASTEXITCODE -eq 0) {
        Add-Check "OPA policy check" "opa check policies/terraform/" "PASS" "OPA policy syntax check passed."
    }
    else {
        Add-Check "OPA policy check" "opa check policies/terraform/" "FAIL" ($result -join "`n")
    }
}
catch {
    Add-Check "OPA policy check" "opa check policies/terraform/" "NOT_RUN" $_.Exception.Message
}
finally {
    Pop-Location
}

# Check OPA policy tests
Push-Location $root
try {
    $result = opa test policies/terraform/ -v 2>&1
    if ($LASTEXITCODE -eq 0) {
        Add-Check "OPA policy tests" "opa test policies/terraform/ -v" "PASS" "OPA policy tests passed."
    }
    else {
        Add-Check "OPA policy tests" "opa test policies/terraform/ -v" "FAIL" ($result -join "`n")
    }
}
catch {
    Add-Check "OPA policy tests" "opa test policies/terraform/ -v" "NOT_RUN" $_.Exception.Message
}
finally {
    Pop-Location
}

# Check control-to-code mapping
Push-Location $root
try {
$result = & (Join-Path $root "scripts/validate-control-mapping.ps1") 2>&1
if ($?) {
    $details = ($result | Out-String).Trim()
    if ([string]::IsNullOrWhiteSpace($details)) {
        $details = "Control mapping validator completed successfully."
    }
    Add-Check "Control mapping validation" "scripts/validate-control-mapping.ps1" "PASS" $details
}
else {
    Add-Check "Control mapping validation" "scripts/validate-control-mapping.ps1" "FAIL" ($result -join "`n")
}
   }
catch {
    Add-Check "Control mapping validation" "scripts/validate-control-mapping.ps1" "NOT_RUN" $_.Exception.Message
}
finally {
    Pop-Location
}

$runningInCI = $env:GITHUB_ACTIONS -eq "true"

$environment = if ($runningInCI) {
    "GitHub Actions"
}
else {
    "Local Windows PowerShell"
}

$evidenceType = if ($runningInCI) {
    "ci_validation"
}
else {
    "local_validation"
}

$report = [PSCustomObject]@{
    evidence_type = $evidenceType
    generated_at = (Get-Date).ToUniversalTime().ToString("o")
    repository = "cgep-labs"
    execution_environment = $environment
    aws_deployment_verified = $false
    aws_monitoring_verified = $false
    checks = $checks
    summary = @{
        passed = @($checks | Where-Object status -eq "PASS").Count
        failed = @($checks | Where-Object status -eq "FAIL").Count
        not_run = @($checks | Where-Object status -eq "NOT_RUN").Count
    }
}

$reportPath = Join-Path $outputDir "local-validation-evidence.json"
$report | ConvertTo-Json -Depth 8 | Set-Content -Path $reportPath -Encoding utf8

Write-Host ""
Write-Host "Evidence report generated: $reportPath"
Write-Host "Passed: $($report.summary.passed)"
Write-Host "Failed: $($report.summary.failed)"
Write-Host "Not run: $($report.summary.not_run)"
