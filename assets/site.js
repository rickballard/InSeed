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
(function(){ // theme toggle
  try{
    const root = document.documentElement;
    const key="inseed-theme";
    const btn = document.getElementById("themeToggle");
    const apply = (m)=>{ if(m==="dark"){root.classList.add("theme-dark");} else {root.classList.remove("theme-dark");} };
    apply(localStorage.getItem(key)||"");
    if(btn){ btn.addEventListener("click", ()=>{ const cur = (root.classList.contains("theme-dark")?"dark":"light"); const next = (cur==="dark"?"light":"dark"); localStorage.setItem(key,next); apply(next); }); }
  }catch(_){}
})();
(function(){ // language ticks + persist
  try{
    const key="inseed-lang";
    const cur = (localStorage.getItem(key) || (document.documentElement.getAttribute("lang")||"en")).toLowerCase();
    document.documentElement.setAttribute("lang",cur);
    document.querySelectorAll(".lang-item").forEach(li=>{
      const v=(li.getAttribute("data-lang")||li.textContent||"").trim().toLowerCase();
      li.setAttribute("aria-selected", v.startsWith(cur) ? "true" : "false");
      li.addEventListener("click",()=>{ localStorage.setItem(key,v); location.reload(); });
    });
  }catch(_){}
})();
(function(){ // dedupe topnav after DOM ready
  function dedupe(){ try{ const navs=[...document.querySelectorAll("nav.topnav")]; if(navs.length>1) navs.slice(1).forEach(n=>n.remove()); }catch(_){}} 
  if(document.readyState==="loading") document.addEventListener("DOMContentLoaded", dedupe); else dedupe();
})();
/* autopatch: nav dedupe + theme + lang */
(()=>{try{
  const run=()=>{ const navs=[...document.querySelectorAll("nav.topnav")]; if(navs.length>1) navs.slice(1).forEach(n=>n.remove()); };
  document.readyState==="loading" ? document.addEventListener("DOMContentLoaded",run) : run();
}catch(_){}})();

(()=>{try{
  const root=document.documentElement, key="inseed-theme", btn=document.getElementById("themeToggle");
  const apply=(m)=>{ m==="dark" ? root.classList.add("theme-dark") : root.classList.remove("theme-dark"); };
  apply(localStorage.getItem(key)||"");
  btn && btn.addEventListener("click",()=>{ const cur=root.classList.contains("theme-dark")?"dark":"light"; const next=cur==="dark"?"light":"dark"; localStorage.setItem(key,next); apply(next); });
}catch(_){}})();

(()=>{try{
  const key="inseed-lang";
  const cur=(localStorage.getItem(key)||(document.documentElement.getAttribute("lang")||"en")).toLowerCase();
  document.documentElement.setAttribute("lang",cur);
  document.querySelectorAll(".lang-item").forEach(li=>{
    const v=(li.getAttribute("data-lang")||li.textContent||"").trim().toLowerCase();
    li.setAttribute("aria-selected", v.startsWith(cur) ? "true" : "false");
    li.addEventListener("click",()=>{ localStorage.setItem(key,v); location.reload(); });
  });
}catch(_){}})();
/* lang dropdown + persistence */
(()=>{try{
  const key="inseed-lang"; const root=document.documentElement;
  const cur=(localStorage.getItem(key)||(root.getAttribute("lang")||"en")).toLowerCase();
  root.setAttribute("lang",cur);

  // dropdown
  const wrap=document.querySelector(".lang-dropdown");
  if(wrap){
    const btn=wrap.querySelector(".lang-button");
    const menu=wrap.querySelector(".lang-menu");
    const setTicks=()=>{
      menu.querySelectorAll(".lang-item").forEach(li=>{
        const v=(li.getAttribute("data-lang")||"").toLowerCase();
        li.setAttribute("aria-selected", v===cur ? "true" : "false");
      });
    };
    setTicks();
    if(btn && menu){
      btn.addEventListener("click",e=>{
        e.stopPropagation();
        const show=!menu.classList.contains("show");
        document.querySelectorAll(".lang-menu.show").forEach(m=>m.classList.remove("show"));
        if(show){ menu.classList.add("show"); setTicks(); }
      });
      document.addEventListener("click",()=>menu.classList.remove("show"));
      menu.addEventListener("click",e=>{
        const li=e.target.closest(".lang-item"); if(!li) return;
        const v=(li.getAttribute("data-lang")||"").toLowerCase();
        if(v==="more"){ location.href="/gibberlink/"; return; }
        localStorage.setItem(key,v); root.setAttribute("lang",v); menu.classList.remove("show"); location.reload();
      }, {capture:true});
    }
  }

  // gibberlink page: clicking a card sets language
  if(location.pathname.startsWith("/gibberlink/")){
    document.querySelectorAll(".lang-list li").forEach(li=>{
      li.addEventListener("click",()=>{
        const v=(li.getAttribute("data-lang")||"").toLowerCase();
        localStorage.setItem(key,v); root.setAttribute("lang",v);
        location.href="/"; // back to home with chosen language
      });
    });
  }
}catch(_){}})();
