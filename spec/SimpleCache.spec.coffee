
###
  @author   Patrick Kromeyer
###

SimpleCache = require '../src/SimpleCache.js'

describe 'SimpleCache', ->

  cache = null

  beforeEach ->
    cache = new SimpleCache()

  it 'should have a getItem function, that returns null on an empty cache', ->
    expect(cache.getItem('key')).toBeNull()

  it 'should have a getItem function, that returns a stored item', ->
    cache.setItem('key', 'value')
    expect(cache.getItem('key')).toBe('value')

  it 'should have a getItem function, that returns null if item lifetime is over', ->
    cache.setItem('key', 'value', 1)

    now = Date.now()
    spyOn(Date, 'now').andReturn(now + 2)

    expect(cache.getItem('key')).toBeNull()

  it 'should have a hasItem function, that returns false on an empty cache', ->
    expect(cache.hasItem('key')).toBeFalsy()

  it 'should have a hasItem function, that returns true on an item that is available', ->
    cache.setItem('key', 'value')
    expect(cache.hasItem('key')).toBeTruthy()

  it 'should have a hasItem function, that returns false if item lifetime is over', ->
    cache.setItem('key', 'value', 1)

    now = Date.now()
    spyOn(Date, 'now').andReturn(now + 2)

    expect(cache.hasItem('key')).toBeFalsy()
