
param(
  [Parameter(Mandatory=$false)][string]$Owner = (git config --get remote.origin.url | % { $_ -replace '.*[:/](.+)/(.+)\.git','$1' } | Select-Object -First 1),
  [Parameter(Mandatory=$false)][string]$Repo  = (git config --get remote.origin.url | % { $_ -replace '.*[:/](.+)/(.+)\.git','$2' } | Select-Object -First 1)
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'

$badges = @"
[![Smoke](https://img.shields.io/github/actions/workflow/status/$Owner/$Repo/readme-smoke.yml?label=README%20smoke)](https://github.com/$Owner/$Repo/actions/workflows/readme-smoke.yml)
[![Safety Gate](https://img.shields.io/github/actions/workflow/status/$Owner/$Repo/safety-gate.yml?label=safety%20gate)](https://github.com/$Owner/$Repo/actions/workflows/safety-gate.yml)
[![Self‑Evolve](https://img.shields.io/github/actions/workflow/status/$Owner/$Repo/self-evolve.yml?label=self‑evolve)](https://github.com/$Owner/$Repo/actions/workflows/self-evolve.yml)
"@

$badges
