
param(
  [Parameter()][string]$Repo = ".",
  [Parameter()][string]$OutDir = "docs/assets"
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$repo = Resolve-Path $Repo
Push-Location $repo

$imgExt = @(".png",".jpg",".jpeg",".webp",".svg",".gif")
$assets = Get-ChildItem -Recurse | ? { $imgExt -contains $_.Extension.ToLower() -and -not $_.FullName.Contains("\.git\") } |
  Select-Object FullName, Name, Length, LastWriteTime

$items = @()
foreach ($a in $assets) {
  $rel = Resolve-Path -Relative $a.FullName
  $items += [pscustomobject]@{
    path = $rel
    bytes = $a.Length
    modified = $a.LastWriteTime.ToString("o")
    alt = ""
    placement = ""
    license = ""
  }
}

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$jsonPath = Join-Path $OutDir "manifest.json"
$mdPath   = Join-Path $OutDir "manifest.md"

$items | ConvertTo-Json -Depth 5 | Set-Content -Path $jsonPath -Encoding UTF8

$md = @()
$md += "# Assets Manifest"
$md += ""
foreach ($i in $items) {
  $md += "* `{0}` — **{1} bytes** — _{2}_ — alt:\"{3}\"".Replace("{0}", $i.path).Replace("{1}", $i.bytes).Replace("{2}", $i.modified).Replace("{3}", $i.alt)
}
$mdText = ($md -join "`n")
$mdText | Set-Content -Path $mdPath -Encoding UTF8

Write-Host "Assets manifest written to $jsonPath and $mdPath"
Pop-Location
