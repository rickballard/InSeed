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
$captions = Join-Path $repoRoot "content/diagrams.captions.yml"

ni -ItemType Directory -Force $destAbs | Out-Null
ni -ItemType Directory -Force (Split-Path $gallery -Parent) | Out-Null

function Get-SrcImages {
  # IMPORTANT: -Include needs wildcard or -Recurse; use wildcard on path.
  $p = Join-Path $From '*'
  @(Get-ChildItem -Path $p -File -Include *.png,*.svg -ErrorAction SilentlyContinue)
}

# Accept .png / .svg starting with 3-digit index
$src = Get-SrcImages | Where-Object { $_.BaseName -match '^\d{3}_[^ ]+' }

if(-not $RebuildOnly -and $src.Count){
  foreach($f in $src){
    $leaf = ($f.Name -replace '\s+','-')
    Copy-Item $f.FullName (Join-Path $destAbs $leaf) -Force
  }
}

# Build captions overrides (optional YAML: filename: { alt: "...", caption: "..." })
$override = @{}
if(Test-Path $captions){
  try {
    $raw = Get-Content $captions -Raw
    # Tiny YAML reader for simple key: value pairs
    # Expecting:
    #   020_partner-ecosystem__intro-to-deal.svg:
    #     alt: "Partner ecosystem: key path from intro to signed deal"
    #     caption: "Flow from lead sources..."
    $current = $null
    $raw -split "`r?`n" | ForEach-Object {
      if($_ -match '^\s*([^\:\s]+)\s*:\s*$'){ $current = $matches[1]; $override[$current] = @{} }
      elseif($_ -match '^\s+alt:\s*"(.*)"\s*$' -and $current){ $override[$current]['alt']=$matches[1] }
      elseif($_ -match '^\s+caption:\s*"(.*)"\s*$' -and $current){ $override[$current]['caption']=$matches[1] }
    }
  } catch { }
}

# Build gallery Markdown
$figs = @(Get-ChildItem -Path (Join-Path $destAbs '*') -File -Include *.png,*.svg -ErrorAction SilentlyContinue | Sort-Object Name)

$lines = @("# InSeed Diagram Gallery","")
foreach($g in $figs){
  # Filename pattern: NNN_title__context.ext
  $title = $g.BaseName
  $ctx   = ""
    if($g.BaseName -match '^(?<n>\d{3})_(?<t>[^_]+?)(?:__?(?<c>.*))?

  $rel = ($g.FullName.Replace($repoRoot, '')).TrimStart('\').Replace('\','/')
  $alt = "$title"
  if($ctx){ $alt = "$title — $ctx" }

  if($override.ContainsKey($g.Name)){
    if($override[$g.Name].ContainsKey('alt') -and $override[$g.Name]['alt']){ $alt = $override[$g.Name]['alt'] }
  }

  $lines += "## $title"
  if($ctx){ $lines += "$ctx" }

  # Render with HTML figure so captions appear nicely on the site
  $caption = ""
  if($override.ContainsKey($g.Name) -and $override[$g.Name].ContainsKey('caption')){
    $caption = $override[$g.Name]['caption']
  } elseif($ctx){
    $caption = $ctx
  }

  # Build <figure> block (encode first)
$lines += ""
$lines += "<figure>"

$encodedAlt = [System.Net.WebUtility]::HtmlEncode($alt)
$imgLine    = "  <img src=""{0}"" alt=""{1}"" />" -f ('/' + $rel), $encodedAlt
$lines     += $imgLine

if($caption){
  $encodedCaption = [System.Net.WebUtility]::HtmlEncode($caption)
  $lines += "  <figcaption>$encodedCaption</figcaption>"
}
$lines += "</figure>"
$lines += ""
}

$lines -join "`r`n" | Set-Content -Encoding UTF8 $gallery

$cnt = ($figs | Measure-Object).Count
Write-Host ("✅ Gallery rebuilt with {0} image(s): {1}" -f $cnt, $gallery) -ForegroundColor Green


){
    $title = ($matches['t'] -replace '-', ' ')
    if($matches.Groups['c'].Success){ $ctx = $matches['c'] } else { $ctx = '' }
  }

  $rel = ($g.FullName.Replace($repoRoot, '')).TrimStart('\').Replace('\','/')
  $alt = "$title"
  if($ctx){ $alt = "$title — $ctx" }

  if($override.ContainsKey($g.Name)){
    if($override[$g.Name].ContainsKey('alt') -and $override[$g.Name]['alt']){ $alt = $override[$g.Name]['alt'] }
  }

  $lines += "## $title"
  if($ctx){ $lines += "$ctx" }

  # Render with HTML figure so captions appear nicely on the site
  $caption = ""
  if($override.ContainsKey($g.Name) -and $override[$g.Name].ContainsKey('caption')){
    $caption = $override[$g.Name]['caption']
  } elseif($ctx){
    $caption = $ctx
  }

  # Build <figure> block (encode first)
$lines += ""
$lines += "<figure>"

$encodedAlt = [System.Net.WebUtility]::HtmlEncode($alt)
$imgLine    = "  <img src=""{0}"" alt=""{1}"" />" -f ('/' + $rel), $encodedAlt
$lines     += $imgLine

if($caption){
  $encodedCaption = [System.Net.WebUtility]::HtmlEncode($caption)
  $lines += "  <figcaption>$encodedCaption</figcaption>"
}
$lines += "</figure>"
$lines += ""
}

$lines -join "`r`n" | Set-Content -Encoding UTF8 $gallery

$cnt = ($figs | Measure-Object).Count
Write-Host ("✅ Gallery rebuilt with {0} image(s): {1}" -f $cnt, $gallery) -ForegroundColor Green



