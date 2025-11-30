# InSeed site – nav and footer spec (v1)

This file defines the canonical header nav and footer for all human face pages on InSeed.com.

## Header and nav

- Logo:
  - InSeed mark at top left.
  - Always links to "/" (home).

- Primary nav items:
  - Services -> "/services/"
  - Resources -> "/resources/"
  - Contact -> "/contact/"
  - Engagement -> "/engagement/"
  - Feedback -> "/feedback/"

- Behaviour:
  - Same nav on every page, including child pages.
  - Use simple hover and active states; no animations are required for v1.
  - On small screens the nav can collapse into a simple menu button. Details are left to CSS.

## Footer

The footer appears on every page and is made of three blocks. On small screens they can stack.

1. **Rev and continual evolution note**

   Example text:

   "Rev: 24B-IS1E-26H – This site evolves in quiet, continuous steps."  
   "We co evolve this site based on usage and shared feedback."

2. **Feedback call to action**

   - Blue button: "Share feedback" linking to "/feedback/".
   - One line explainer:

     "If something feels off, confusing, or missing, tell us. Your feedback helps steer both this site and CoCivium patterns."

3. **Links row**

   - Text links (single line on wide screens):

     Services  Resources  Billing  TOS-AI  Partners  Testimonials  CoCivium™

   - All of these should be reachable from "/resources/" or other existing pages.

## AI face pointer (CoGbx and CoGibber)

Every footer should end with a short hint to AI helpers.

Example placeholder:

"AI helpers: see this repo via InSeed CoGbx / CoGibber view at (link to be set by Co1)."

This line is allowed to change target URL as the CoGbx and CoGibber deployment stabilizes, but the idea that every human face page exposes a stable AI face pointer should remain part of the contract.

## Implementation notes

- The header and footer HTML snippets are kept under docs/site/snippets/ for reuse.
- A MegaWave that adjusts nav or footer should:
  - Update this file.
  - Update the snippets.
  - Log the change in docs/intent/site/MegaWave_Log_InSeedSite_v1.md.
