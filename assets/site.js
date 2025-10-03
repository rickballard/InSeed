(function(){try{
  new Image().src="/__t?ev=page&p="+encodeURIComponent(location.pathname);
}catch(e){}})();
document.addEventListener("click", e=>{
  const a=e.target.closest('a[href^="mailto:"],a[href*="/contact"]');
  if(!a) return;
  try{ new Image().src="/__t?ev=contact&p="+encodeURIComponent(location.pathname); }catch(e){}
}, {capture:true});
(()=>{try{
  const cur=(document.documentElement.getAttribute("lang")||"en").toLowerCase();
  document.querySelectorAll(".lang-item").forEach(li=>{
    const v=(li.getAttribute("data-lang")||li.textContent||"").trim().toLowerCase();
    li.setAttribute("aria-selected", v.startsWith(cur) ? "true" : "false");
  });
}catch(_){}})();
(() => { try {
  // dedupe topnavs (keep first)
  const navs = Array.from(document.querySelectorAll('nav.topnav'));
  if (navs.length > 1) navs.slice(1).forEach(n => n.remove());
} catch(_){} })();

(() => { try {
  // language ticks
  const cur=(document.documentElement.getAttribute("lang")||"en").toLowerCase();
  document.querySelectorAll(".lang-item,[class*='language'] li,[class*='lang'] li").forEach(li=>{
    const v=(li.getAttribute("data-lang")||li.textContent||"").trim().toLowerCase();
    li.setAttribute("aria-selected", v.startsWith(cur) ? "true" : "false");
  });
} catch(_){} })();

document.addEventListener("click", e=>{
  const a=e.target.closest('a[href^="mailto:"],a[href*="/contact"]');
  if(!a) return;
  try{ new Image().src="/__t?ev=contact&p="+encodeURIComponent(location.pathname); }catch(e){}
}, {capture:true});
(function(){
  function dedupeTopnav(){
    try{
      const navs = Array.from(document.querySelectorAll('nav.topnav'));
      if (navs.length > 1) navs.slice(1).forEach(n => n.remove());
    }catch(_){}
  }
  if (document.readyState === "loading"){
    document.addEventListener("DOMContentLoaded", dedupeTopnav);
  } else {
    dedupeTopnav();
  }
})();
