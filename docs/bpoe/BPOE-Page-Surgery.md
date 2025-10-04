# Page Surgery Playbook (BPOE)

- **Nav landmark**: `<nav class="topnav" role="navigation" aria-label="Main">`
- **Skip link**: `<a id="skip-link" href="#main" class="skip-link">…</a>` + `<main id="main">`
- **Language**: current first; **Gibberlink** second; `aria-expanded`, keyboard handlers
- **Strapline**: top-level pages only; audit and remove elsewhere
- **Cache bust**: two separate `-replace` calls (CSS then JS)

**Regex tip**: When you need capture groups (`$m.Groups`), use `[regex]::Replace($text, 'pattern', { param($m) '…' }, 1)`.
