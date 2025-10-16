param(
  [string]$From = "$HOME\Downloads",     # where your exported PNG/SVG live
  [string]$To   = "assets/diagrams",     # repo-relative dest
  [switch]$RebuildOnly                   # only rebuild gallery
)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest

# Resolve repo root (script is in <repo>/scripts)
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$destAbs  = Join-Path $repoRoot $To

New-Item -ItemType Directory -Force $destAbs | Out-Null

# Accept .png / .svg starting with 3-digit index
$src = Get-ChildItem -File $From -Include *.png,*.svg -ErrorAction SilentlyContinue |
  Where-Object { $_.BaseName -match '^\d{3}_[^ ]+' }

if(-not $RebuildOnly){
  foreach($f in $src){
    $leaf = $f.Name -replace '\s+','-'
    Copy-Item $f.FullName (Join-Path $destAbs $leaf) -Force
  }
}

# Build gallery Markdown
$figs = Get-ChildItem -File $destAbs -Include *.png,*.svg -ErrorAction SilentlyContinue | Sort-Object Name
$lines = @("# InSeed Diagram Gallery","")
foreach($g in $figs){
  # Parse name: NNN_title__context.ext
  if($g.BaseName -match '^(?<n>\d{3})_(?<title>[^_]+)(?:__?(?<ctx>.*))?$'){
    $title = ($matches.title -replace '-', ' ')
    $ctx   = $matches.ctx
  } else { $title = $g.BaseName; $ctx = "" }

  $rel = ($g.FullName.Replace($repoRoot, '')).TrimStart('\').Replace('\','/')
  $lines += "## $title"
  if($ctx){ $lines += "$ctx" }
  $lines += ""
  $lines += "![${title}](/$rel)"
  $lines += ""
}
$gallery = Join-Path $repoRoot "content/diagrams.md"
$lines -join "`r`n" | Set-Content -Encoding UTF8 $gallery

Write-Host "✅ Gallery rebuilt with $($figs.Count) image(s): $gallery" -ForegroundColor Green
