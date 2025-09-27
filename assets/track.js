window.plausible = window.plausible || function(){(window.plausible.q=window.plausible.q||[]).push(arguments)};

// track key nav/CTA clicks
function trackSelector(sel, name){
  document.querySelectorAll(sel).forEach(a=>{
    a.addEventListener('click', ()=>plausible(name,{props:{href:a.getAttribute('href')}}));
  });
}
document.addEventListener('DOMContentLoaded', function(){
  trackSelector('a[href="/resources/billing/"]', 'Billing CTA');
  trackSelector('a[href^="/resources/global-strategy-firms"]', 'CEO Guide CTA');
  trackSelector('a[href="/resources/partners/"]', 'Partners CTA');
  trackSelector('a[href="/resources/testimonials/"]', 'Testimonials CTA');
  // Print buttons
  document.querySelectorAll('button, a').forEach(el=>{
    if((el.textContent||'').match(/print/i)) el.addEventListener('click', ()=>plausible('Print to PDF'));
  });
});
// INSEED Lead Ping (Cloudflare Worker)
(function(){
  var PING = window.INSEED_LEAD_PING || "https://YOUR-SUBDOMAIN.workers.dev/ping"; // <-- replace after deploy
  var p = location.pathname||"/";
  var hi = /^\/resources\/(billing|partners|testimonials|tos-ai)\//.test(p) || /^\/services(\/|$)/.test(p);
  var u = PING + "?u=" + encodeURIComponent(location.href) + "&hi=" + (hi?1:0);
  if (navigator.sendBeacon) { try{ navigator.sendBeacon(u); } catch(_){} }
  else { try{ fetch(u, {mode:"no-cors", keepalive:true}); } catch(_){} }
})();
