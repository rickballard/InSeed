param(
  [string]$From = "$HOME\Downloads",      # where your exported PNG/SVG live
  [string]$To   = "assets/diagrams",      # repo-relative dest
  [switch]$RebuildOnly                    # only rebuild gallery
)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest

# Resolve repo root (script is in <repo>/scripts)
$PSScriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$destAbs  = Join-Path $repoRoot $To
$gallery  = Join-Path $repoRoot "content/diagrams.md"

ni -ItemType Directory -Force $destAbs | Out-Null

# Accept .png / .svg starting with 3-digit index
$src = @(Get-ChildItem -File $From -Include *.png,*.svg -ErrorAction SilentlyContinue |
  Where-Object { $_.BaseName -match '^\d{3}_[^ ]+' })

if(-not $RebuildOnly){
  foreach($f in $src){
    $leaf = ($f.Name -replace '\s+','-')
    Copy-Item $f.FullName (Join-Path $destAbs $leaf) -Force
  }
}

# Build gallery Markdown
$figs = @(Get-ChildItem -File $destAbs -Include *.png,*.svg -ErrorAction SilentlyContinue | Sort-Object Name)

$lines = @("# InSeed Diagram Gallery","")
foreach($g in $figs){
  # Name pattern: NNN_title__context.ext
  if($g.BaseName -match '^(?<n>\d{3})_(?<title>[^_]+?)(?:__?(?<ctx>.*))?$'){
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

# Ensure content folder exists even if no figures yet
ni -ItemType Directory -Force (Split-Path $gallery -Parent) | Out-Null
$lines -join "`r`n" | Set-Content -Encoding UTF8 $gallery

$cnt = ($figs | Measure-Object).Count
Write-Host ("✅ Gallery rebuilt with {0} image(s): {1}" -f $cnt, $gallery) -ForegroundColor Green
