# InSeed visual overview

This page gives a **visual overview of how InSeed works** and how it sits inside the wider CoSuite ecosystem.  
Use it as a “picture-first” explanation for people who don’t want to read long walls of text.

---

## 1. InSeed engagement funnel

This diagram shows how someone moves from **first hearing about InSeed** to becoming an **active collaborator or client**.

<div class="diagram-gallery">

  <div class="diagram-card">
    <a href="/diagrams/inseed-funnel.svg">
      <img src="/diagrams/inseed-funnel.svg" alt="InSeed engagement funnel" />
    </a>
    <h3>InSeed engagement funnel</h3>
    <p>
      High-level journey from initial curiosity to active co-building with InSeed.
    </p>
    <p class="diagram-meta">
      Source: <code>docs/diagrams/inseed-funnel.mmd</code><br/>
      Hub entry: <code>inseed-engagement-funnel</code>
    </p>
  </div>

</div>

### How to read this diagram

Think of it as a **storyboard for the relationship** between InSeed and the people it serves:

1. <strong>First contact</strong> – they discover InSeed through a conversation, a shared resource, or a talk.
2. <strong>Orientation</strong> – they get a simple explanation of what InSeed does and who it is for.
3. <strong>Fit check</strong> – together, you sense-check whether InSeed is actually the right tool or partner.
4. <strong>Co-design</strong> – you shape an experiment, engagement, or pilot that makes sense for both sides.
5. <strong>Co-evolution</strong> – the relationship moves into an ongoing cycle of learning and refinement.

> If the actual funnel stages in the diagram use different labels, update the bullets here to match them exactly.  
> The copy should always mirror what the visual shows.

---

## 2. CoSuite hub (where InSeed fits in the bigger picture)

This diagram is about the **overall CoSuite**, not just InSeed.  
It helps new people understand that InSeed is one part of a larger civic-tech stack.

<div class="diagram-gallery">

  <div class="diagram-card">
    <a href="/diagrams/cosuite-hub.svg">
      <img src="/diagrams/cosuite-hub.svg" alt="CoSuite hub overview diagram" />
    </a>
    <h3>CoSuite hub</h3>
    <p>
      Shows the main CoSuite components (CoCivium, CoAgent, CoCache, InSeed, etc.) and how they relate.
    </p>
    <p class="diagram-meta">
      Source: <code>docs/diagrams/cosuite-hub.mmd</code><br/>
      Hub entry: <code>cosuite-hub</code>
    </p>
  </div>

</div>

### How to interpret this diagram

- Treat **InSeed** as the part focused on **commercial and engagement architecture**:
  - Helping founders and funders navigate forced pivots.
  - Designing offers and engagements that can plug into CoCivium later.
- Treat **CoCivium** as the **civic kernel** that governs shared best-practice and civic infrastructure.
- Treat **CoAgent** as the **AI-workbench / orchestrator** layer.
- Treat **CoCache** as the **shared memory / reference library**.

Together they form a stack where:

- InSeed engagements generate real-world learning and structure.  
- CoCivium turns that into civic infrastructure and best-practice.  
- CoAgent and CoCache help keep the whole thing usable by humans and AIs.

---

## Notes for InSeed.com integration

- Adjust the <code>href</code> and <code>src</code> paths
  (<code>/diagrams/...svg</code>) to match the real asset URLs on inseed.com.
- Keep the **diagram names and purposes** aligned with
  <code>CoCache/docs/diagrams/HUB_GRAPHICS_INVENTORY.md</code>.
- Link to this page from a human-friendly place in the site nav, e.g.:
  - “Visual overview”
  - “How InSeed works”
  - “InSeed in the CoSuite ecosystem”
