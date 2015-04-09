Test Async Proxy Pool
=====================

    Promise = require 'bluebird'
    require 'mocha'
    should = (require 'chai').should()
    AsyncProxyPool = require '..'

    # run base-class tests
    global.Pool = AsyncProxyPool
    require 'async-pool/test/test'

    class Foo
      constructor: (@id, @bar)->

      foo: ->
        return @id


    describe 'AsyncProxyPool', ->
      pool = null
      beforeEach ->
        pool = new AsyncProxyPool(
          [new Foo(1,'a'),new Foo(1,'a')], ['foo'], ['bar'])

      it 'allows sharing of resource', ->
        Promise.using pool.use(), pool.share(), pool.share(), (a, b, c)->
          a.foo().should.equal 1
          a.bar.should.equal 'a'
          b.foo().isPending().should.equal true
          b.bar.isPending().should.equal true
          c.foo().isPending().should.equal true
          c.bar.isPending().should.equal true
          Promise.join(b.foo(), c.foo()).spread (bf, cf)->
            bf.should.equal 1
            cf.should.equal 1
          .then ->
            Promise.join(b.bar, c.bar)
          .spread (bf, cf)->
            bf.should.equal 'a'
            cf.should.equal 'a'



