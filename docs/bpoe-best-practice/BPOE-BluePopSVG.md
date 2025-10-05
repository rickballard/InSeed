# Blue-Pop SVG (BPOE Pattern)

**Why**: consistent, readable diagrams in light/dark; portable (styles embedded); easy to evolve.

**Key moves**
- Embed palette + styles **inside** `<svg>` via `<style data-inseed-bluepop>…</style>`.
- Add `<defs><filter id="pop"><feDropShadow …/></filter></defs>` and apply to card nodes.
- Prefer rectangles with rx=12 for nodes, rx=16 for panels; blue stroke 1.25–1.35; soft shadow.
- Never rely on external CSS when saving to `/assets/`.

**Starter CSS** (selectors cover both attribute and class-based nodes):

```css
:root{
  /* light */
  --p75:#eaf0ff; --p300:#a5b4fc; --p400:#818cf8; --border:#b8c2ea; --ink:#1e2330; --accent:#eef2ff;
}
@media (prefers-color-scheme: dark){
  :root{
    /* dark */
    --p75:#121a33; --p300:#24367a; --p400:#2f44a3; --border:#2b3246; --ink:#e6e9f5; --accent:#141a2a;
  }
}
rect[rx="16"], .panel { fill:var(--accent); stroke:var(--border) }
rect[rx="12"], .node, .card { fill:var(--p75); stroke:var(--p300); stroke-width:1.25; filter:url(#pop) }
text { fill:var(--ink); }
line, path { stroke:var(--p400); }
marker path { fill:var(--p400); }
```
