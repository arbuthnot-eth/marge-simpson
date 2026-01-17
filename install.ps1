\
<#
install.ps1
Copies the drop-in `marge_simpson` folder into the current directory (your project root).

Usage (PowerShell):
  # from inside the cloned repo folder:
  powershell -ExecutionPolicy Bypass -File .\install.ps1

Optional:
  powershell -ExecutionPolicy Bypass -File .\install.ps1 -Target "C:\path\to\project" -Force
#>

param(
  [string]$Target = ".",
  [switch]$Force
)

$src = Join-Path $PSScriptRoot "marge_simpson"
if (-not (Test-Path $src)) {
  Write-Error "Could not find source folder: $src"
  exit 1
}

$dst = Join-Path (Resolve-Path $Target) "marge_simpson"

if (Test-Path $dst) {
  if (-not $Force) {
    Write-Host "Destination already exists: $dst"
    Write-Host "Re-run with -Force to overwrite."
    exit 1
  }
  Remove-Item -Recurse -Force $dst
}

Copy-Item -Recurse -Force $src $dst
Write-Host "Installed: $dst"
