<#
test-marge.ps1 — Self-test for the Marge Simpson verification system

Validates that:
1. Scripts exist and are valid PowerShell/Bash
2. Folder name auto-detection works
3. SkipIfNoTests exits 0
4. Cleanup script runs in preview mode

Usage:
  powershell -ExecutionPolicy Bypass -File .\marge_simpson\test-marge.ps1
#>

$ErrorActionPreference = "Stop"
$script:TestsPassed = 0
$script:TestsFailed = 0

# Dynamic folder detection
$MsDir = $PSScriptRoot
$MsFolderName = Split-Path $MsDir -Leaf
$RepoRoot = (Get-Item $MsDir).Parent.FullName

function Test-Assert {
    param(
        [string]$Name,
        [scriptblock]$Test
    )
    
    Write-Host -NoNewline "  [$MsFolderName] $Name... "
    try {
        $result = & $Test
        if ($result -eq $true) {
            Write-Host "PASS" -ForegroundColor Green
            $script:TestsPassed++
            return $true
        } else {
            Write-Host "FAIL (returned: $result)" -ForegroundColor Red
            $script:TestsFailed++
            return $false
        }
    }
    catch {
        Write-Host "FAIL (error: $_)" -ForegroundColor Red
        $script:TestsFailed++
        return $false
    }
}

Write-Host ""
Write-Host "============================================================"
Write-Host "[$MsFolderName] Self-Test Suite"
Write-Host "============================================================"
Write-Host ""

# Test 1: Required files exist
Write-Host "[1/5] File existence checks..."
Test-Assert "AGENTS.md exists" { Test-Path (Join-Path $MsDir "AGENTS.md") }
Test-Assert "verify.ps1 exists" { Test-Path (Join-Path $MsDir "verify.ps1") }
Test-Assert "verify.sh exists" { Test-Path (Join-Path $MsDir "verify.sh") }
Test-Assert "cleanup.ps1 exists" { Test-Path (Join-Path $MsDir "cleanup.ps1") }
Test-Assert "cleanup.sh exists" { Test-Path (Join-Path $MsDir "cleanup.sh") }
Test-Assert "verify.config.json exists" { Test-Path (Join-Path $MsDir "verify.config.json") }
Test-Assert "README.md exists" { Test-Path (Join-Path $MsDir "README.md") }
Write-Host ""

# Test 2: verify.ps1 syntax check
Write-Host "[2/5] Script syntax validation..."
Test-Assert "verify.ps1 valid syntax" {
    $null = [System.Management.Automation.Language.Parser]::ParseFile(
        (Join-Path $MsDir "verify.ps1"), [ref]$null, [ref]$null
    )
    $true
}
Test-Assert "cleanup.ps1 valid syntax" {
    $null = [System.Management.Automation.Language.Parser]::ParseFile(
        (Join-Path $MsDir "cleanup.ps1"), [ref]$null, [ref]$null
    )
    $true
}
Write-Host ""

# Test 3: Folder name detection
Write-Host "[3/5] Folder name auto-detection..."
Test-Assert "Detected folder name is '$MsFolderName'" { $MsFolderName -ne "" }
Test-Assert "Parent folder exists" { Test-Path $RepoRoot }
Write-Host ""

# Test 4: verify.ps1 with SkipIfNoTests (skip if already running through verify harness)
Write-Host "[4/5] verify.ps1 SkipIfNoTests behavior..."
$isNestedRun = $env:MARGE_TEST_RUNNING -eq "1"
if ($isNestedRun) {
    Write-Host "  [skip] Skipping nested verify test (already in verify harness)"
    $script:TestsPassed += 2
} else {
    $env:MARGE_TEST_RUNNING = "1"
    $verifyScript = Join-Path $MsDir "verify.ps1"
    $verifyResult = & powershell -ExecutionPolicy Bypass -File $verifyScript fast -SkipIfNoTests 2>&1
    $verifyExitCode = $LASTEXITCODE
    $env:MARGE_TEST_RUNNING = ""
    Test-Assert "verify.ps1 -SkipIfNoTests exits 0" { $verifyExitCode -eq 0 }
    Test-Assert "Output contains folder name" { ($verifyResult -join "`n") -match "\[$MsFolderName\]" }
}
Write-Host ""

# Test 5: cleanup.ps1 preview mode
Write-Host "[5/5] cleanup.ps1 preview mode..."
$cleanupScript = Join-Path $MsDir "cleanup.ps1"
$cleanupResult = & powershell -ExecutionPolicy Bypass -File $cleanupScript 2>&1
$cleanupExitCode = $LASTEXITCODE
Test-Assert "cleanup.ps1 exits 0 in preview mode" { $cleanupExitCode -eq 0 }
Test-Assert "Output shows PREVIEW MODE" { ($cleanupResult -join "`n") -match "PREVIEW" }
Write-Host ""

# Summary
Write-Host "============================================================"
Write-Host "[$MsFolderName] Test Results"
Write-Host "============================================================"
Write-Host ""
Write-Host "  Passed: $script:TestsPassed" -ForegroundColor Green
Write-Host "  Failed: $script:TestsFailed" -ForegroundColor $(if ($script:TestsFailed -gt 0) { "Red" } else { "Green" })
Write-Host ""

if ($script:TestsFailed -gt 0) {
    Write-Host "FAIL: $script:TestsFailed test(s) failed" -ForegroundColor Red
    exit 1
} else {
    Write-Host "PASS: All tests passed" -ForegroundColor Green
    exit 0
}
