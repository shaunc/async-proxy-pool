Test Async Proxy Pool
=====================

    Promise = require 'bluebird'
    require 'mocha'
    should = (require 'chai').should()
    AsyncProxyPool = require '..'

    # run base-class tests
    global.Pool = AsyncProxyPool
    require 'async-pool/test/test'

    describe 'AsyncProxyPool', ->
      pool = null
      beforeEach ->
        pool = new AsyncProxyPool([{foo:1},{foo:1}], [], ['foo'])

      it 'allows sharing of resource', ->
        Promise.using pool.use(), pool.share(), pool.share(), (a, b, c)->
          a.foo.should.equal 1
          b.foo.isPending().should.equal true
          c.foo.isPending().should.equal true
          Promise.join(b.foo, c.foo).spread (bf, cf)->
            bf.should.equal 1
            cf.should.equal 1
