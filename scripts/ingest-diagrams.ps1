param(
  [string]$From = "$HOME\Downloads",                # where your exported PNG/SVG live
  [string]$To   = "assets/diagrams",                # repo dest
  [switch]$RebuildOnly                              # only rebuild gallery.md
)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
Push-Location (Split-Path -Parent $MyInvocation.MyCommand.Path)

# Accept .png or .svg files that start with a 3-digit index
$src = Get-ChildItem -File $From -Include *.png,*.svg -ErrorAction SilentlyContinue |
  Where-Object { $_.BaseName -match '^\d{3}_[^ ]+' }

if(-not $RebuildOnly){
  foreach($f in $src){
    $leaf = $f.Name -replace '\s+','-'
    Copy-Item $f.FullName (Join-Path $To $leaf) -Force
  }
}

# Build gallery Markdown
$figs = Get-ChildItem -File $To -Include *.png,*.svg | Sort-Object Name
$lines = @()
$lines += "# InSeed Diagram Gallery"
$lines += ""
foreach($g in $figs){
  # Parse name: NNN_title__context.ext
  if($g.BaseName -match '^(?<n>\d{3})_(?<title>[^_]+)(?:__?(?<ctx>.*))?$'){
    $title = ($matches.title -replace '-', ' ')
    $ctx   = $matches.ctx
  } else {
    $title = $g.BaseName
    $ctx   = ""
  }
  $rel = $g.FullName.Replace((Get-Location).Path + '\','').Replace('\','/')
  $lines += "## $title"
  if($ctx){ $lines += "$ctx" }
  $lines += ""
  $lines += $"![{title}]({rel})"
  $lines += ""
}

$gallery = "content/diagrams.md"
$lines -join "`r`n" | Set-Content -Encoding UTF8 $gallery

Write-Host "✅ Gallery rebuilt with $($figs.Count) image(s): $gallery" -ForegroundColor Green
Pop-Location
