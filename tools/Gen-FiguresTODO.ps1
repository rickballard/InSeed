param([string]$Site="site",[string]$Out="docs/authoring/FIGURES_TODO.md")
$ErrorActionPreference='Stop'
$root = Split-Path -Parent $PSCommandPath
$repo = Resolve-Path "$root\.." | % Path
$site = Join-Path $repo $Site
$out  = Join-Path $repo $Out
New-Item -ItemType Directory -Force (Split-Path $out -Parent) | Out-Null

$hits = Get-ChildItem -Path $site -Recurse -File -Include *.md,*.mdx,*.html,*.liquid |
  ForEach-Object {
    $m = Select-String -Path $_.FullName -Pattern 'placeholder\.svg' -SimpleMatch
    if($m){ [PSCustomObject]@{ Page=$_.FullName.Substring($repo.Length+1).Replace('\','/'); Count=$m.Count } }
  }

$lines = @("# FIGURES_TODO","",
           "Pages still using `placeholder.svg` (content is live; visuals can catch up):","",
           "| Page | Placeholder refs | Notes |",
           "|---|---:|---|")
if($hits){
  $hits | Sort-Object Page | ForEach-Object {
    $lines += "| $($_.Page) | $($_.Count) | |"
  }
}else{
  $lines += "| _None_ | 0 | |"
}
[IO.File]::WriteAllText($out,($lines -join "`n"),[Text.UTF8Encoding]::new($false))