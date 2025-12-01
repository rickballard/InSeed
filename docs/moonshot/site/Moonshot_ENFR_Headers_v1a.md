# Moonshot EN/FR Hero + CTA Headers v1

Suggested repo path:
`InSeed/docs/moonshot/site/Moonshot_ENFR_Headers_v1.md`

This file collects English and draft French text for the Moonshot hero banner and primary calls to action, aimed at a Canadian / federal government audience but still compatible with InSeed’s commercial positioning.

---

## 1. English hero + CTAs (draft v1)

### Hero headline (EN)

> Stress‑tested with industry. Built for civic duty.

### Hero subheadline (EN)

> InSeed helps senior public leaders safely pilot AI‑driven change — starting from commercial proof, and bringing the lessons home to government so citizens, services, and staff are better protected.

### Primary CTA (EN)

> Explore the Moonshot for Government

### Secondary CTA (EN)

> Talk to a Steward

Usage notes (EN):

- **Headline** emphasizes:
  - commercial hardening (“stress‑tested with industry”),
  - civic purpose (“built for civic duty”).
- **Subheadline** reassures:
  - this is not a lab experiment; it’s grounded in real-world engagements,
  - the end-beneficiaries are citizens, services, and staff.
- **Primary CTA** should route to the dedicated Moonshot page.
- **Secondary CTA** should open a contact / booking flow with a stewardship frame (not generic “sales”).

---

## 2. French hero + CTAs (draft v1 – to be reviewed)

These are *working* translations designed to be respectful and bureaucrat‑friendly, but they **must** be reviewed / adjusted by a fluent FR speaker in the Canadian public sector context before being treated as final.

### Hero headline (FR – draft)

> Éprouvé dans le secteur privé. Conçu pour le service public.

### Hero subheadline (FR – draft)

> InSeed aide les dirigeants publics à piloter, en toute sécurité, des transformations appuyées par l’IA — à partir de preuves issues du terrain commercial, puis adaptées aux réalités gouvernementales pour mieux protéger citoyens, services et équipes.

### Primary CTA (FR – draft)

> Découvrir Moonshot pour le secteur public

### Secondary CTA (FR – draft)

> Parler à un·e intendant·e

Notes:

- “Service public” is used to echo “civic duty” without sounding activist.
- “Piloter, en toute sécurité, des transformations appuyées par l’IA” mirrors “safely pilot AI‑driven change”.
- “Intendant·e” is a placeholder for “steward” in an inclusive form; Co1 may want to pick a final FR term (e.g., “responsable de la gouvernance”, “intendant(e) de l’IA”, etc.).

---

## 3. Implementation guidance

1. **Centralization**
   - Keep these strings in this single Markdown source for now.
   - When stable, extract into a shared string resource (e.g., JSON or a template include) and add a GIBindex entry pointing at the canonical copy.

2. **GIBindex linkage**
   - Index the following concepts:
     - `MoonshotHero_EN_v1`
     - `MoonshotHero_FR_v1`
     - `MoonshotCTA_Primary_EN_v1`
     - `MoonshotCTA_Primary_FR_v1`
     - `MoonshotCTA_Secondary_EN_v1`
     - `MoonshotCTA_Secondary_FR_v1`
   - Map each GIB identifier to:
     - language,
     - intended placement (hero / CTA),
     - target audience (federal / public sector).

3. **Review workflow**
   - Before production deployment on InSeed.com:
     - Have a FR‑speaking reviewer (ideally with Canadian public sector exposure) validate tone and terminology.
     - Capture any accepted revisions back into this file (v2+) and into the GIBindex.

4. **Future variants**
   - Over time, Co1 may want:
     - province-specific variants,
     - versions for municipal or agency-level pages,
     - A/B-tested wording focused on risk, opportunity, or talent retention.

This v1 is deliberately conservative and “bureaucrat‑friendly,” designed to be a safe starting point, not the last word.
