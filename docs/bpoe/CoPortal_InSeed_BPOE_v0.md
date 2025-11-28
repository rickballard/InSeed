# InSeed CoPortal BPOE (v0, seed stage)

Repo: InSeed
Site: inseed.com

## Role

Treat inseed.com as a first class CoPortal testbed for legacy executives and boards who need to realign with an AI intensive future. The site is dual faced: human facing for copy and persuasion, AI facing for structure, descriptors, and machine readable summaries.

## Source of truth

- Anchor repo: github.com/rickballard/InSeed
- CoPortal descriptor: embedded in index.html as an HTML comment block named inseed.com::portal.v0
- CoSteward and CoCivium remain the doctrine hubs; InSeed consumes and applies that doctrine for executive advisory.

## Design rails

1. Dual face
   - Human side: clear hero, three service ladders (CoAudit, CoFlow, CoMirror), CEO Survival Guide, and InPrimer.
   - AI side: stable ids on key sections, compact machine readable descriptors, and a CoPortal descriptor that names role, status, content trust, and anchor repos.

2. Stable nav, evolving depth
   - Top level nav remains short and predictable (Services, Resources, InPrimer, Engagement, Contact).
   - Depth (InPrimer modules, CEO Survival Guide variants, experiment sections) may iterate quickly, but changes are always tagged in git and CoSynced.

3. Receipts
   - Any material change to hero copy, nav structure, or CoPortal descriptor is:
     - made on a short feature branch,
     - described in a small docs/intent/advice note in the InSeed repo,
     - CoSynced back to CoSteward as part of CoBrowser and CoPortal experiments.

4. CoBrowser dogfooding
   - InSeed is the first target for CoBrowser style helpers:
     - scripts should be able to identify hero offers, services, key CTAs, and the CoPortal descriptor without brittle scraping.
     - any parsing pain is folded back into design and markup improvements.

5. Edge control friendly
   - Assume exec visitors often arrive through an AI helper acting as a proxy.
   - Content should make it easy for those helpers to:
     - summarise the risk and opportunity framing,
     - extract prompt packs,
     - understand how to engage (CoAudit / CoFlow / CoMirror, and InPrimer).

6. Steward identity
   - All copy should reinforce the identity shift from classic CEO to Steward and eventually CoSteward.
   - InPrimer is the explicit depth module where that identity shift is mapped and made actionable.

## Status

This document represents a seed stage BPOE for InSeed as a CoPortal. It should be revised once CoBrowser experiments and InPrimer content mature.
