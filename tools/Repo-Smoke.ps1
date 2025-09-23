
param(
  [Parameter()][string]$Repo = ".",
  [switch]$FailOnExternalLinks
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$repo = Resolve-Path $Repo
Push-Location $repo

$errors = @()

function Check-LocalImage([string]$mdPath, [string]$imgRel) {
  $p = Join-Path (Split-Path $mdPath -Parent) $imgRel
  if (-not (Test-Path $p)) { $script:errors += "Missing image '$imgRel' referenced by $mdPath" }
}

$mds = Get-ChildItem -Recurse -Include *.md | ? { -not $_.FullName.Contains("\.git\") }
foreach ($md in $mds) {
  $txt = Get-Content -Raw -Path $md.FullName -Encoding UTF8; if (!$txt) { $txt = "" }
  foreach ($m in [regex]::Matches($txt, '!\[[^\]]*\]\(([^)]+)\)')) {
    $url = $m.Groups[1].Value
    if ($url -notmatch '^(https?:)?//') { Check-LocalImage $md.FullName $url }
  }
  foreach ($m in [regex]::Matches($txt, '\[[^\]]+\]\(([^)]+)\)')) {
    $u = $m.Groups[1].Value
    if ($FailOnExternalLinks -and $u -match '^https?://') {
      try { Invoke-WebRequest -Uri $u -Method Head -TimeoutSec 8 | Out-Null }
      catch { $script:errors += "External link 404/timeout '$u' in $($md.Name)" }
    }
  }
}

if ($errors.Count -gt 0) {
  Write-Error ("SMOKE FAIL:`n" + ($errors -join "`n"))
} else { Write-Host "SMOKE OK" }
Pop-Location

