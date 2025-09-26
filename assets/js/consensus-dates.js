(function(){
  function addMonths(d, m){ const x=new Date(d); x.setMonth(x.getMonth()+m); return x; }
  function fmtMonthYYYY(d){ return d.toLocaleString(undefined,{month:"short", year:"numeric"}); }

  const now = new Date();
  const start = addMonths(now, 22);
  const end   = addMonths(start, 30);

  const s = document.getElementById("consensus-start");
  const e = document.getElementById("consensus-end");
  if (s) s.textContent = fmtMonthYYYY(start);
  if (e) e.textContent = fmtMonthYYYY(end);
})();
