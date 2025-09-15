
param(
  [Parameter(Mandatory)][string]$File,
  [Parameter(Mandatory)][string]$AnchorStart,
  [Parameter(Mandatory)][string]$AnchorEnd,
  [Parameter(Mandatory)][string]$Content,
  [switch]$CreateIfMissing
)
Set-StrictMode -Version Latest; $ErrorActionPreference = 'Stop'

if (-not (Test-Path $File)) {
  if ($CreateIfMissing) { New-Item -ItemType File -Path $File -Force | Out-Null }
  else { throw "File not found: $File" }
}

$text = Get-Content -Raw -Path $File -Encoding UTF8
$pattern = [regex]::Escape($AnchorStart) + '.*?' + [regex]::Escape($AnchorEnd)
if ($text -match $pattern) {
  $new = [regex]::Replace($text, $pattern, "$AnchorStart`n$Content`n$AnchorEnd", 'Singleline')
} else {
  $sep = if ($text.Length -gt 0 -and -not $text.EndsWith("`n")) { "`n`n" } else { "" }
  $new = $text + $sep + "$AnchorStart`n$Content`n$AnchorEnd`n"
}
$new | Set-Content -Path $File -Encoding UTF8
