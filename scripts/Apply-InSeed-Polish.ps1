
param(
  [Parameter()][string]$Repo = ".",
  [Parameter()][string]$Hero = "assets/InSeed_Hero.png",
  [Parameter()][string]$OdtText = "",
  [switch]$Force
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$repo = Resolve-Path $Repo
Push-Location $repo

# 0) Ensure helper scripts available
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
. (Join-Path $scriptRoot 'Ensure-Block.ps1')

# 1) Ensure directories
New-Item -ItemType Directory -Force -Path ".github\workflows" | Out-Null
New-Item -ItemType Directory -Force -Path ".github" | Out-Null
New-Item -ItemType Directory -Force -Path "docs\bpoe" | Out-Null
New-Item -ItemType Directory -Force -Path "tools" | Out-Null

# 2) README wiring: hero + badges + anchors
$readme = "README.md"
if (-not (Test-Path $readme)) { New-Item -ItemType File -Path $readme | Out-Null }

$badgeBlock = & (Join-Path $scriptRoot 'AutoBadge-Status.ps1')
Ensure-Block -File $readme -AnchorStart "<!-- BADGES:BEGIN -->" -AnchorEnd "<!-- BADGES:END -->" -Content $badgeBlock -CreateIfMissing

if (Test-Path $Hero) {
  $heroRel = Resolve-Path -Relative $Hero
  $heroMd = "![InSeed Hero]($heroRel)"
  Ensure-Block -File $readme -AnchorStart "<!-- HERO:BEGIN -->" -AnchorEnd "<!-- HERO:END -->" -Content $heroMd -CreateIfMissing
}

if ($OdtText -and $OdtText.Trim().Length -gt 0) {
  Ensure-Block -File $readme -AnchorStart "<!-- ODT:BEGIN -->" -AnchorEnd "<!-- ODT:END -->" -Content $OdtText -CreateIfMissing
}

# 3) PR Template
$prTmpl = @"
# PR Checklist
- [ ] Hero banner wired (`<!-- HERO:BEGIN -->` block present)
- [ ] ODT text merged if applicable (`<!-- ODT:BEGIN -->` block)
- [ ] README badges present and current (`<!-- BADGES:BEGIN -->` block)
- [ ] Repo Smoke passes locally (`tools/Repo-Smoke.ps1`)
- [ ] Assets manifest updated (`docs/assets/manifest.json`)
- [ ] BPOE SESSION_STATUS updated
"@
$prPath = ".github\pull_request_template.md"
$prTmpl | Set-Content -Path $prPath -Encoding UTF8

# 4) Assets manifest
& (Join-Path $scriptRoot 'Ensure-Assets-Manifest.ps1') -Repo $repo | Out-Null

# 5) Session status placeholder
$statusPath = "docs\bpoe\SESSION_STATUS.md"
$stamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss K")
$content = @"
# Session Status
- Updated: $stamp
- Branch: $(git rev-parse --abbrev-ref HEAD 2>$null)
- Commit: $(git rev-parse --short HEAD 2>$null)

> Auto-maintained by `.github/workflows/self-evolve.yml` if enabled.
"@
$content | Set-Content -Path $statusPath -Encoding UTF8

# 6) Workflows
$wfDir = ".github\workflows"
@"
name: readme-smoke
on:
  push: {branches: ["**"]}
  pull_request:
  schedule:
    - cron: "23 3 * * *"
jobs:
  smoke:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup PowerShell
        uses: PowerShell/PowerShell@v1
        with: { version: '7.4.x' }
      - name: Run smoke
        shell: pwsh
        run: |
          ./tools/Repo-Smoke.ps1 -Repo .
"@ | Set-Content -Path (Join-Path $wfDir "readme-smoke.yml") -Encoding UTF8

@'

name: safety-gate
on:
  pull_request:
    types: [opened, synchronize, reopened]
jobs:
  checks:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with: { fetch-depth: 0 }
      - name: Light diff sanity
        run: |
          MAX=500000
          SIZE=$(git diff --numstat origin/${{ github.base_ref }}...HEAD | awk '{s+=$1+$2} END {print s+0}')
          echo "Total changed lines: $SIZE"
          if [ "$SIZE" -gt "$MAX" ]; then
            echo "::error::Change too large ($SIZE > $MAX)."
            exit 1
          fi
      - name: Secret scan (trufflehog light)
        uses: trufflesecurity/trufflehog@v3.88.11
        with:
          path: .
          base: ${{ github.event.pull_request.base.sha }}
          head: ${{ github.sha }}

'@ | Set-Content -Path (Join-Path $wfDir "safety-gate.yml") -Encoding UTF8

@"
name: self-evolve
on:
  schedule:
    - cron: "13 4 * * *"
  workflow_dispatch:
permissions:
  contents: write
jobs:
  evolve:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with: { fetch-depth: 0 }
      - name: Setup PowerShell
        uses: PowerShell/PowerShell@v1
        with: { version: '7.4.x' }
      - name: Ensure assets manifest
        shell: pwsh
        run: |
          ./scripts/Ensure-Assets-Manifest.ps1 -Repo .
      - name: Refresh badges block
        id: badges
        shell: pwsh
        run: |
          $out = ./scripts/AutoBadge-Status.ps1
          ./scripts/Ensure-Block.ps1 -File README.md -AnchorStart "<!-- BADGES:BEGIN -->" -AnchorEnd "<!-- BADGES:END -->" -Content $out -CreateIfMissing
      - name: Update SESSION_STATUS
        shell: pwsh
        run: |
          $stamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss K"
          @"
# Session Status
- Updated: $stamp
- Branch: $(git rev-parse --abbrev-ref HEAD 2>$null)
- Commit: $(git rev-parse --short HEAD 2>$null)
"@ | Set-Content -Path docs/bpoe/SESSION_STATUS.md -Encoding UTF8
      - name: Commit (gated by ENABLE_AUTOCOMMITS)
        shell: bash
        run: |
          set -e
          echo "ENABLE_AUTOCOMMITS=${{ vars.ENABLE_AUTOCOMMITS }}"
          if [ "${{ vars.ENABLE_AUTOCOMMITS }}" = "true" ]; then
            git config user.name "github-actions[bot]"
            git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
            git add -A
            if ! git diff --cached --quiet; then
              git commit -m "auto: self-evolve refresh"
              git push
            else
              echo "No changes to commit."
            fi
          else
            echo "Auto-commits disabled; set repo variable ENABLE_AUTOCOMMITS=true to enable."
          fi
"@ | Set-Content -Path (Join-Path $wfDir "self-evolve.yml") -Encoding UTF8

Write-Host "InSeed Polish applied locally. Next: commit + push + open PR (squash preferred)."
Pop-Location

