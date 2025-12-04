# Infographics Pack v1 — CoTheory of Civilization

All diagrams are minimalist, line/box/connector style, using Mermaid or D2.
They are designed to be copy-pasted into:
- GitHub markdown
- Docs sites (Docusaurus/MkDocs)
- Slides
- Zenodo appendices

---

## 1. Civilizational Phases (Mermaid)

```mermaid
flowchart TD
    A[Phase 1:\nAI Containerization] --> B[Phase 2:\nPlatform Wars]
    B --> C[Phase 3:\nPower Wars]
    C --> D[Phase 4:\nElite Convergence]
    D --> E{Phase 5:\nCivilizational Fork}
    E --> F[Authoritarian\nConvergence]
    E --> G[Edge-Governed\nPluralism]
```

---

## 2. Actor Landscape (D2)

```d2
tech: {
  label: "Tech-State Complex"
}
auth: {
  label: "Authoritarian Sovereigns"
}
reg: {
  label: "Regulatory Hubs"
}
cap: {
  label: "Capital Pools"
}
civic: {
  label: "Civic Commons & Stewards"
}

tech -> auth: "competition,\ncopying tools"
tech -> reg: "lobbying,\nstandard-setting"
tech -> cap: "returns,\nexits"
auth -> tech: "market access,\nconstraints"
reg -> tech: "rules,\npenalties"
cap -> tech: "investment,\npressure"
civic -> tech: "audit,\ncritique,\nco-design"
civic -> reg: "advocacy,\npublic input"
civic -> auth: "resistance,\nexposure"
```

---

## 3. Identity & Work Transformation (Mermaid)

```mermaid
flowchart LR
    J[Jobs as\nIdentity] --> A[AI Automation]
    A --> C[Role Erosion]
    C --> D[Identity Crisis]
    D --> E[New Roles:\nStewards,\nMediators,\nCivic Builders]
    E --> F[Edge-Governed\nPluralism Path]
    D --> G[Resentment,\nDisplacement]
    G --> H[Authoritarian\nConvergence Path]
```

---

## 4. Governance Drift (Mermaid)

```mermaid
flowchart TD
    G1[Traditional\nGovernance] --> G2[AI-Assisted\nGovernance]
    G2 --> G3[Dashboard-\nDependent\nGovernance]
    G3 --> G4{Who Controls\nThe Stack?}
    G4 --> G5[Closed\nVendors,\nCaptured State]
    G4 --> G6[Open Civic OS,\nCommunity Control]

    G5 --> AC[Authoritarian\nConvergence]
    G6 --> EP[Edge-Governed\nPluralism]
```

---

## 5. Truth Mesh (D2)

```d2
source_journalism: {
  label: "Investigative\nJournalism"
}
source_science: {
  label: "Scientific\nEvidence"
}
source_civic: {
  label: "Civic\nObservation"
}
source_local: {
  label: "Lived\nExperience"
}
ai_node: {
  shape: circle
  label: "AI\nSynthesis Node"
}
public: {
  label: "Public\nDeliberation"
}

source_journalism -> ai_node
source_science -> ai_node
source_civic -> ai_node
source_local -> ai_node
ai_node -> public: "summaries,\nmultiple views"
public -> ai_node: "feedback,\ncorrections,\nnew data"
```

---

## 6. Steward Lifecycle (Mermaid)

```mermaid
flowchart TD
    S1[Identify\nPotential Steward] --> S2[Training &\nMentoring]
    S2 --> S3[Join\nSteward Circle]
    S3 --> S4[Oversight &\nFacilitation Work]
    S4 --> S5[Reflection,\nBurnout Check]
    S5 --> S6{Rotate or\nContinue?}
    S6 --> S3
    S6 --> S7[Alumni /\nMentor Role]
```

---

## 7. Coercion Loop Under AI (D2)

```d2
citizen: {
  label: "Citizen"
}
data: {
  label: "Behavioral\nData"
}
model: {
  label: "Risk /\nLoyalty Model"
}
policy: {
  label: "AI-Mediated\nPolicy"
}
impact: {
  label: "Life Impact\n(Access,\nRates,\nFreedom)"
}

citizen -> data: "actions,\nspeech,\nlocation"
data -> model: "training,\nupdates"
model -> policy: "scores,\nclassifications"
policy -> impact: "sanctions,\nrewards"
impact -> citizen: "behavior change,\nself-censorship"
```

---

## 8. Civic OS Stack (Mermaid)

```mermaid
flowchart TD
    L[Local Community,\nOrg,\nCity] --> C[Local Civic OS\n(Policies,\nPlaybooks,\nConstitutions)]
    C --> A[AI Systems\n(Models,\nTools,\nWorkflows)]
    A --> R[Receipts,\nLogs,\nReports]
    R --> S[Steward Circle]
    S --> U[Updates to Civic OS]
    U --> C
```
