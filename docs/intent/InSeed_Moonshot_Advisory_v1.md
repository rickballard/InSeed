# InSeed Moonshot Advisory v1 (for Co1 / CoPrime)

Repo-suggested path:
`InSeed/docs/intent/InSeed_Moonshot_Advisory_v1.md`

This advisory is for:
- Co1 / CoPrime
- Future AIs working on InSeed, CoSuite, and CoCivium
- Human maintainers of the InSeed website and Moonshot assets

It explains what the current Moonshot wave has produced, how it fits into InSeed and CoCivium, and how to extend it safely.

---

## 1. Current Moonshot state on repo

Moonshot v1 lives on branch:

- `mw-moonshot-v1-20251130155206`

and is currently in PR:

- `Moonshot v1: Target Grid + Transparency Footer + Page Copy` (PR number to be resolved at merge time).

Artifacts in this PR (as of v1):

1. **Strategy / Targeting**
   - `docs/moonshot/strategy/Moonshot_TargetProfileGrid_v1.md`  
     - Defines core audience categories: AI governance units, digital/data governance councils, digital modernization programs, and ministry-level AI enablement teams.
     - Lists their needs, concerns, and leverage points.

2. **Page Copy (human-facing narrative)**
   - `docs/moonshot/site/Moonshot_PageCopy_v1.md`  
     - Full narrative copy for the InSeed Moonshot landing page.
     - Designed for Canadian federal context but generalizable.

3. **Transparency / Process**
   - `docs/moonshot/transparency/Moonshot_TransparencyFooter_v1.md`  
     - Transparency asset to be linked from the Moonshot page footer.
     - Explains how the page was designed, how guardrails and transparency are applied, and how others can reuse the pattern.

4. **Wireframe / Layout**
   - `docs/moonshot/site/Moonshot_PageWireframe_v1.md`  
     - Human-readable wireframe describing layout and section structure for the Moonshot page.

5. **Section Structure (machine-friendly)**
   - `docs/moonshot/site/Moonshot_PageSections_v1.json`  
     - JSON section map for AI-facing and tool-facing use.
     - Ideal for CoGibber / GBX style navigation and future automation.

Together, these assets form a coherent v1 bundle:
- Who the page is for.
- What it says.
- How it is structured.
- How it was designed.
- How it can be extended.

---

## 2. Design intent for Moonshot

Moonshot is an InSeed offering designed to:

1. Provide a safe, credible on-ramp for AI adoption in government, with a strong emphasis on:
   - guardrails,
   - transparency,
   - and public trust.

2. Leverage InSeed's commercial work as a stress-testing ground for methods and patterns that later flow into civic and government deployments.

3. Align with CoCivium's mission:
   - edge-controlled guardrails,
   - open, auditable workflows,
   - human plus AI co-design,
   - and co-evolution of methods over time.

The narrative in `Moonshot_PageCopy_v1.md` and the wireframe asset are intentionally written to be:

- conservative enough to be acceptable to federal decision makers,
- strong enough to communicate the guardrail-centric value,
- and simple enough to be extended with role-specific variants later.

---

## 3. Relationship to other InSeed and CoSuite work

Moonshot should be seen as:

- InSeed's "federal AI guardrails" offering,
- an on-ramp into CoCivium thinking,
- and a live example of CoCivium-style transparency in practice.

It interacts with:

- **CoCivium**: provides the conceptual backbone for edge-controlled guardrails and hybrid human plus AI governance.
- **CoSteward**: holds the operating principles and BPOE guidance that shape how sessions should behave and how artifacts are recorded.
- **GIBindex**: will eventually hold indexed entries for Moonshot-related concepts (guardrail frameworks, transparency patterns, System.Func`2[System.Text.RegularExpressions.Match,System.String]/CoGibber interfaces).
- **System.Func`2[System.Text.RegularExpressions.Match,System.String] / CoGibber / GBX**: Moonshot's JSON section map is designed to be a natural candidate for AI-facing portal integration.

The concurrent session labelled `InSeed_more` is also evolving header, footer, and navigation for the InSeed site. Co1 should:

- ensure Moonshot integration respects these layout and navigation conventions,
- avoid conflicting changes by using clearly named branches,
- and consider a dedicated "Moonshot integration wave" once the core Moonshot PR is merged.

---

## 4. Recommended next steps for Co1 / CoPrime

Once Moonshot v1 is merged to main, Co1 can:

1. **Promote and refine Moonshot on the InSeed site**
   - Wire Moonshot content into:
     - the services, solutions, or resources navigation,
     - any AI/guardrails-related overview pages.
   - Ensure that the transparency link in the footer is actually wired to a visible page or docs rendering of `Moonshot_TransparencyFooter_v1.md`.

2. **Create role-specific variants (Moonshot v1.x)**
   - Derive targeted variants of Moonshot for:
     - AI governance units,
     - digital modernization programs,
     - ministry-level enablement teams.
   - These can start as sections within the main page or separate pages that reuse the core assets.

3. **Add EN/FR variants of the hero plus CTAs**
   - Use `Moonshot_ENFR_Headers_v1.md` (once present on repo) as a reference for bilingual hero content.
   - Ensure that federal-facing deployments are EN/FR ready, even if only at hero/CTA level initially.

4. **Begin CoGibber / GBX integration**
   - Register key Moonshot concepts in the GIBindex.
   - Map `Moonshot_PageSections_v1.json` into portal or tooling that lets AIs navigate sections by intent, not just by URL.
   - Add minimal machine tags for sections (for example: `hero`, `risk_context`, `guardrail_offer`, `pilot_process`).

5. **Document DO Block naming in BPOE**
   - Capture the emerging convention for DO Block IDs (for example):
     - `DO W<Wave>-Moonshot-<Step>_<Slug>_v<version>`
   - Add this to:
     - bootstrap and quickstart docs,
     - BPOE guidance in CoSteward,
     - and GIBindex entries under something like `DoBlockId.v1`.

---

## 5. Notes on concurrent sessions and repo discipline

This Moonshot session and the `InSeed_more` session have both touched the InSeed repo.

To keep things clean:

- Moonshot work has been kept on `mw-moonshot-v1-20251130155206`.
- InSeed_more work uses branches such as `MW_InSeed_HeaderFooter_Inject_v2` and others.

Co1 should:

1. Continue enforcing a branch-per-wave approach.
2. Ensure that InSeed site HTML templates and includes are not changed in conflicting ways across branches.
3. When merging multiple branches, use a clear order and test that:
   - header and footer still look correct,
   - Moonshot integrations are visible and navigable,
   - transparency links are wired correctly.

---

## 6. Suggested future evolution for Moonshot (v2 and beyond)

Co1 and future maintainers can evolve Moonshot by:

1. **Deepening examples**
   - Add case-study style content (synthetic or real) showing what a low-risk pilot looks like for different ministries.
   - Provide example guardrail maps and transparency tables.

2. **Interactive elements**
   - Embed simple visual diagrams for guardrails and process flows.
   - In later waves, consider a short explainer video or audio asset, provided it can be kept aligned with CoCivium messaging.

3. **Tighter integration with CoCivium materials**
   - Link to CoCivium guardrail primers and public-facing assets when they are ready.
   - Reuse language across InSeed and CoCivium so that people can move between them without cognitive friction.

4. **Bilingual and jurisdictional variants**
   - Expand EN/FR coverage.
   - Allow for variants that speak to other jurisdictions while keeping the Canadian federal version as the reference implementation.

---

## 7. How to treat this advisory

Treat this advisory as:

- a snapshot of Moonshot's current intent and structure,
- a set of prompts for future improvement waves,
- and a starting point for Co1 to coordinate Moonshot with the rest of CoCivium and InSeed.

Co1 is free to:
- fork this document to `InSeed_Moonshot_Advisory_v2.md`,
- split it into separate operational and conceptual notes,
- or re-home parts of it in CoSteward and GIBindex if that improves the global structure.

The only requirement is to preserve a clear and transparent trail so future stewards can see how Moonshot evolved and why certain choices were made.
