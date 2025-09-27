const fs = require("fs");

const token  = process.env.PLAUSIBLE_API_TOKEN;
const site   = process.env.SITE   || "inseed.com";
const period = process.env.PERIOD || "24h";
const limit  = Number(process.env.LIMIT || 12);

if(!token){ throw new Error("Missing PLAUSIBLE_API_TOKEN"); }

async function api(path, body){
  const res = await fetch("https://plausible.io/api/v2/stats/"+path, {
    method: "POST",
    headers: { "Authorization": "Bearer "+token, "Content-Type": "application/json" },
    body: JSON.stringify(Object.assign({ site_id: site, period }, body||{}))
  });
  if(!res.ok){ throw new Error(path+" -> "+res.status+" "+(await res.text())); }
  return res.json();
}

const breakdown = (prop) => api("breakdown", { property: prop, limit });

function hostFromRef(ref){
  try { return (new URL(ref, "https://x")).hostname || ""; } catch(_){ return ""; }
}

function isIgnoreHost(h){
  const ignore = [
    "google.","bing.","duckduckgo.","search.","news.","linkedin.","lnkd.","facebook.","fb.","twitter.","t.co",
    "x.com","reddit.","github.","youtube.","ycombinator.","medium.","substack.","notion.","figma.","slack.","mail."
  ];
  const hn = h.toLowerCase();
  return !hn || ignore.some(p => hn.includes(p));
}

function highIntent(page){
  return ["/resources/billing/","/resources/partners/","/resources/testimonials/","/resources/tos-ai/","/services/"]
         .some(k => (page||"").startsWith(k));
}

(async () => {
  const agg = await api("aggregate", { metrics: ["visitors","pageviews","bounce_rate"] });

  const [pages, sources, referrers, countries] = await Promise.all([
    breakdown("event:page"),
    breakdown("visit:source"),
    breakdown("visit:referrer"),
    breakdown("visit:country"),
  ]);

  // Derive "possible companies" from referrer hostnames (privacy-safe heuristic)
  const companyCounts = new Map();
  for(const r of (referrers.results||[])){
    const h = hostFromRef(r["visit:referrer"]);
    if(h && !isIgnoreHost(h)){
      companyCounts.set(h, (companyCounts.get(h)||0) + (r.visitors||0));
    }
  }
  const companies = [...companyCounts.entries()]
      .sort((a,b)=>b[1]-a[1])
      .slice(0, 10)
      .map(([h,vis])=>`- ${h} (${vis} visitors)`);

  const hiPages = (pages.results||[])
      .filter(x => highIntent(x["event:page"]))
      .slice(0,8)
      .map(x => `- ${x["event:page"]} (${x.visitors} u)`);

  const fmtList = (items, key) =>
    (items.results||[]).slice(0,8).map(x => `- ${x[key] || "(direct)"} (${x.visitors} u)`).join("\n");

  const body = `InSeed traffic (last ${period}) — ${site}
Visitors: ${agg.results?.visitors?.value||0} | Pageviews: ${agg.results?.pageviews?.value||0} | Bounce: ${agg.results?.bounce_rate?.value||0}%

Top pages:
${fmtList(pages, "event:page")}

High-intent pages touched:
${hiPages.length ? hiPages.join("\n") : "- (none in period)"}

Top sources:
${fmtList(sources, "visit:source")}

Top referrers:
${fmtList(referrers, "visit:referrer")}

Top countries:
${fmtList(countries, "visit:country")}

Possible companies (from referrer hostnames, heuristic):
${companies.length ? companies.join("\n") : "- (none detected; many visitors come via search/direct)"}
`;

  fs.writeFileSync("body.txt", body, "utf8");
  console.log(body);
})().catch(e => { console.error(e); process.exit(1); });