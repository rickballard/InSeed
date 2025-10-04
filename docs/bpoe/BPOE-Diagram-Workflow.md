# Diagram Workflow (BPOE)

1) Draft in Canvas/Figma/hand; export **SVG** (e.g., 1100×260/320). Use nodes rx=12; panel rx=16.
2) Inject Blue-Pop styles + `#pop` filter _inside_ SVG.
3) Save to `/assets/diagram-*.svg` with a descriptive name.
4) Insert with `<figure>`; write literal **alt** and interpretive **figcaption**.
5) Cache-bust the page (update `site.css?v=…` and `site.js?v=…`).
6) Keep arrows visible (prefer short segments; avoid obscured long lines).
