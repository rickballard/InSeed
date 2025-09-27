export default {
  async fetch(request, env, ctx) {
    const u = new URL(request.url);
    if (u.pathname !== "/ping") return new Response(null, {status:204});

    const cf = request.cf || {};
    const org = (cf.asOrganization || "").trim();
    const asn = cf.asn || "";
    const ip  = request.headers.get("CF-Connecting-IP") || "";
    const ua  = request.headers.get("User-Agent") || "";
    const ref = request.headers.get("Referer") || "";

    const page = u.searchParams.get("u") || ref || "https://inseed.com/";
    const hi   = u.searchParams.get("hi") === "1";

    // De-noise consumer ISPs & clouds so the "Lead: ..." is more business-like
    const generic = /(digitalocean|aws|amazon|google|microsoft|azure|verizon|comcast|t[- ]?mobile|at&t|charter|spectrum|rogers|bell|telus|vodafone|starlink|chinanet|ovh|hetzner|cloudflare)/i;
    const label  = org && !generic.test(org) ? org : (asn ? `AS${asn}` : "Unknown");

    // Name encoded in event so we don't depend on custom props support
    const eventName = "Lead: " + label + (hi ? " (HI)" : "");

    const body = JSON.stringify({ name: eventName, url: page, domain: "inseed.com" });
    const headers = { "Content-Type":"application/json", "User-Agent": ua, "X-Forwarded-For": ip, "Referer": ref };

    // Fire-and-forget to Plausible; never block the page
    ctx.waitUntil(fetch("https://plausible.io/api/event", { method:"POST", headers, body }).catch(()=>{}));
    return new Response(null, {status:204});
  }
}