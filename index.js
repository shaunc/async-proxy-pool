// require coffee if possible; js otherwise
try {
  require('coffee-script/register');  
  AsyncProxyPool = require('./src/async-proxy-pool');
}
catch (e) {
  if(e.message.indexOf("Cannot find module") != -1 
      && (e.message.indexOf('./src/index') != -1 
        || e.message.indexOf('coffee-script/register') != -1))
    AsyncProxyPool = require('./lib/async-proxy-pool');
  else
    throw e;
}
module.exports = AsyncProxyPool;