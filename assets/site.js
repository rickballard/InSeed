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
