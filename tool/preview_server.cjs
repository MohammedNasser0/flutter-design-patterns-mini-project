const http=require('http'),fs=require('fs'),path=require('path');
const root=path.resolve(__dirname,'..');
const esc=s=>s.replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;');
const style='<style>body{margin:0;padding:40px;background:#171526;color:#eeedf8;font:17px monospace}h1{font:700 25px sans-serif;color:#b9a5ff}p{color:#9993ac}pre{white-space:pre-wrap;line-height:1.7;padding:24px;background:#242037;border-radius:16px}small{color:#9c94ac}.grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}.grid pre{font-size:13px;margin:0;line-height:1.5}</style>';
http.createServer((req,res)=>{
 const url=new URL(req.url,'http://localhost');
 if(url.pathname.startsWith('/evidence/')){
  const phase=url.pathname.split('/').pop();
  if(phase==='payment'){
   const paths=['payment_method.dart','payment_processor.dart','cash_payment.dart','credit_payment.dart','payment.dart','payment_amount.dart'];
   const blocks=paths.map(p=>'<section><h3>'+p+'</h3><pre>'+esc(fs.readFileSync(path.join(root,'lib/payments',p),'utf8'))+'</pre></section>').join('');
   res.setHeader('Content-Type','text/html; charset=utf-8');res.end(style+'<h1>04 / SOLID payment structure</h1><p>Actual project source · local simulation</p><div class="grid">'+blocks+'</div>');return;
  }
  const transcript=fs.readFileSync(path.join(root,'docs/console-output.txt'),'utf8');
  const chunks=transcript.split(/(?=PHASE [1-4])/);const numbers={builder:1,factory:2,singleton:3};const n=numbers[phase];
  const output=chunks.find(c=>c.startsWith('PHASE '+n))||transcript;
  res.setHeader('Content-Type','text/html; charset=utf-8');res.end(style+'<h1>Pattern Lab / execution evidence</h1><p>Actual Dart stdout transcript displayed in browser</p><pre>$ dart run bin/patterns_demo.dart '+esc(phase)+'<br><br>'+esc(output)+'</pre><small>Generated from the recorded demo run. No output values edited.</small>');return;
 }
 const filename=path.resolve(root,'build/web','.'+decodeURIComponent(url.pathname==='/'?'/index.html':url.pathname));
 if(!filename.startsWith(path.join(root,'build/web')+path.sep)){res.writeHead(403);res.end();return;}
 const types={'.html':'text/html; charset=utf-8','.js':'text/javascript','.wasm':'application/wasm','.json':'application/json','.png':'image/png','.ttf':'font/ttf'};
 fs.readFile(filename,(err,data)=>{if(err){res.writeHead(404);res.end('Build pending');return;}res.setHeader('Content-Type',types[path.extname(filename)]||'application/octet-stream');res.end(data);});
}).listen(8769,'127.0.0.1',()=>console.log('Preview running at http://127.0.0.1:8769'));
