# async-proxy-pool
Promise-based asynchronous resource pool allowing shared resource proxies.

Extends [shaunc/async-pool](https://github.com/shaunc/async-pool).

# Installation

npm install async-proxy-pool

# Usage.

In addition to `AsyncPool.use()` there is a `AsyncProxyPool.share()` which gets a proxy to a resource, and issues
method calls on onresources when they are available. This can be useful if you want to pass around a resource, like
a database connection, without depleting the supply, and you don't care about serializing your method calls.


  

