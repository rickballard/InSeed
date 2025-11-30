# InSeed CoGbx / CoGibber schema stub (v1)

Purpose: define the minimum contract between InSeed.com and its AI face views.

## CoGbx – box view

- Role: compact semantic index over the InSeed repo.
- Backed by: CoIndex, CoStatus, CoMetrics.
- For AIs:
  - Fast lookups for:
    - Site objectives
    - Service lines
    - Metrics and status
    - Whitepapers and training packs
- For humans:
  - Optional sparse view, such as a table or cards, explaining the index.

## CoGibber – language view

- Role: higher density pattern language for AI to AI communications.
- Uses:
  - Short gibber tokens for commonly used concepts and playbooks.
  - Cross links into CoCivium GIBindex.

## Contract with InSeed.com

- Every human face page must expose:
  - A stable pointer to one or more CoGbx and CoGibber endpoints in the footer.
  - Enough context for an AI to guess which repo and slice to inspect.

- Example footer line (placeholder):

  "AI helpers: see this repo via InSeed CoGbx / CoGibber view at (URL to be assigned)."

- Co1 and CoIndex sessions own:
  - Actual domain choice and routing.
  - Versioning and stability guarantees.

This file is a stub for those sessions and can be replaced by a more formal schema later.
