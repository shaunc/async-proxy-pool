// require coffee if possible; js otherwise
try {
  try { require('coffee-script/register'); } catch (e) {}
  AsyncProxyPool = require('./src/async-proxy-pool');
}
catch (e) {
  AsyncProxyPool = require('./lib/async-proxy-pool');
}
module.exports = AsyncProxyPool;
