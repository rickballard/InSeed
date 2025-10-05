# Cache Busting (BPOE)

Use two separate `-replace` calls:

```powershell
$build = Get-Date -UFormat %Y%m%d%H%M%S
$t = $t -replace 'href="/assets/site\.css(\?[^"]*)?"', "href=""/assets/site.css?v=$build"""
$t = $t -replace 'src="/assets/site\.js(\?[^"]*)?"',  "src=""/assets/site.js?v=$build"""
```
