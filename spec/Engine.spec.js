// Generated by CoffeeScript 1.6.2
/*
  @author   Patrick Kromeyer
*/

var Engine;

Engine = require('../src/Engine.js');

describe('Engine', function() {
  it('should have an createChannel method, that returns an unique channel id', function() {
    var engine, id1, id2;

    engine = new Engine();
    id1 = engine.createChannel();
    id2 = engine.createChannel();
    return expect(id1).not.toBe(id2);
  });
  it('should call the callback: channel closed', function() {
    var called, waitFunc;

    called = false;
    runs(function() {
      var channelId, engine;

      engine = new Engine(function() {
        return called = true;
      });
      channelId = engine.createChannel();
      return engine.closeChannel(channelId);
    });
    waitFunc = function() {
      return called;
    };
    return waitsFor(waitFunc, 'callback should be called', 1000);
  });
  it('should call the callback: channel rejected', function() {
    var called, waitFunc;

    called = false;
    runs(function() {
      var channelId, engine;

      engine = new Engine(function() {
        return called = true;
      });
      channelId = engine.createChannel();
      return engine.rejectChannel(channelId);
    });
    waitFunc = function() {
      return called;
    };
    return waitsFor(waitFunc, 'callback should be called', 1000);
  });
  return it('should call the callback only once', function() {
    var count, waitFunc;

    count = 0;
    runs(function() {
      var channelIdOne, channelIdTwo, engine;

      engine = new Engine(function() {
        return count++;
      });
      channelIdOne = engine.createChannel();
      channelIdTwo = engine.createChannel();
      engine.closeChannel(channelIdTwo);
      return engine.rejectChannel(channelIdOne);
    });
    waitFunc = function() {
      return count;
    };
    waitsFor(waitFunc, 'callback should be called', 1000);
    return runs(function() {
      return expect(count).toBe(1);
    });
  });
});