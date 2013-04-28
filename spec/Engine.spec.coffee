
###
  @author   Patrick Kromeyer
###

Engine = require '../src/Engine.js'

describe 'Engine', ->

  it 'should have an createChannel method, that returns an unique channel id', ->
    engine = new Engine()
    id1 = engine.createChannel()
    id2 = engine.createChannel()

    expect(id1).not.toBe(id2)

  it 'should call the callback: channel closed', ->
    called = false

    runs ->
      engine = new Engine(->
        called = true
      )
      channelId = engine.createChannel()
      engine.closeChannel(channelId)

    waitFunc = -> called
    waitsFor(waitFunc, 'callback should be called', 1000)

  it 'should call the callback: channel rejected', ->
    called = false

    runs ->
      engine = new Engine(->
        called = true
      )
      channelId = engine.createChannel()
      engine.rejectChannel(channelId)

    waitFunc = -> called
    waitsFor(waitFunc, 'callback should be called', 1000)

  it 'should call the callback only once', ->
    count = 0

    runs ->
      engine = new Engine(-> count++)
      channelIdOne = engine.createChannel()
      channelIdTwo = engine.createChannel()
      engine.closeChannel(channelIdTwo)
      engine.rejectChannel(channelIdOne)

    waitFunc = -> count
    waitsFor(waitFunc, 'callback should be called', 1000)

    runs ->
      expect(count).toBe(1)
