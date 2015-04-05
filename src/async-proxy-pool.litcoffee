Async Proxy Pool
================

Resource manager serializing resource use but providing an interface for
parallel access as well.

Builds on resource pool; to checkout a resource for use in a callback,
or get use a proxy for a resource, when you don't need exclusive
access.

Currently, the proxy is built using a list of methods which are
assumed to return promises, and a list of readonly data attributes.

Note: getting a data attribute returns a promise of the value; subsequent
calls could return data from different resources. Intended for use for
accessing values such as query connection strings, for which it doesn't matter
which client we use.

    Promise = require 'bluebird'
    AsyncPool = require 'async-pool'
    log = (require 'logger-facade-nodejs').getLogger('async-proxy-pool')
    
    class AsyncProxyPool extends AsyncPool
      constructor: (resources, methods, dataAttributes = [])->
        super(resources)
        @_Proxy = class Proxy
        self = this
        for method in methods ? []
          Proxy.prototype[method] = ()-> 
            args = arguments
            return Promise.using self.use(), (obj)->
              obj[method].apply(obj, args)
        for attr in dataAttributes
          Object.defineProperty Proxy.prototype, attr,
            get: ->
              Promise.using self.use(), (obj)->
                obj[attr]

      share: ()->
        @_checkCloseOnUse()
        Promise.resolve(new @_Proxy())

    module.exports = AsyncProxyPool
