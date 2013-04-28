
###
  @author   Patrick Kromeyer
###

class SimpleCache

  constructor: ->
    @_cache = {}
    @_expirationDates = {}

  _checkLifetime: ->
    now = Date.now()
    for key of @_expirationDates
      if @_expirationDates[key] < now
        delete @_expirationDates[key]
        delete @_cache[key]
    return

  setItem: (key, data, lifetime = 3600) ->
    @_cache[key] = data
    @_expirationDates[key] = Date.now() + lifetime
    return

  hasItem: (key) ->
    @_checkLifetime()
    if @_cache[key] then true else false

  getItem: (key) ->
    @_checkLifetime()
    if @_cache[key] then @_cache[key] else null

module.exports = SimpleCache
