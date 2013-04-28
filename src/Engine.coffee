
###
  @author   Patrick Kromeyer
###

class Engine

  STATE_OPEN        = 'stateOpen'
  STATE_CLOSED      = 'stateClosed'
  STATE_REJECTED    = 'stateRejected'

  constructor: (callback) ->
    @_counter = 0
    @_channelState = []
    @_channelContent = []
    @_callback = callback

  _isReady: ->
    for id of @_channelState
      if @_channelState[id] is STATE_OPEN
        return false

    return true

  _handle: ->
    return unless @_isReady()
    @_callback()

  createChannel: ->
    channelId = @_counter++
    @_channelState[channelId] = STATE_OPEN
    @_channelContent[channelId] = ''
    return channelId

  appendToChannel: (id, content) ->
    if @_channelState[id] isnt STATE_OPEN
      throw 'channel is closed, rejected or undefined'

    @_channelContent[id] += content
    return

  closeChannel: (id) ->
    if @_channelState[id] isnt STATE_OPEN
      throw 'channel is allready closed, rejected or undefined'

    @_channelState[id] = STATE_CLOSED
    @_handle()
    return

  rejectChannel: (id) ->
    if @_channelState[id] isnt STATE_OPEN
      throw 'channel is allready rejected, closed or undefined'

    @_channelContent[id] = null
    @_channelState[id] = STATE_REJECTED
    @_handle()
    return

module.exports = Engine
