
###
  @author   Patrick Kromeyer
###

ICalendarEngine = require '../src/ICalendarEngine.js'

describe 'ICalendarEngine', ->

  it 'should create an icalendar string', ->
    parser = -> [{
      name: 'testName',
      dateStart: new Date(Date.UTC(2013, 1-1, 5, 8, 30, 0, 0)),
      dateEnd: new Date(Date.UTC(2013, 1-1, 5, 9, 0, 0, 0)),
      description: 'testDescription'
    }]

    test = (result) ->
      expect(result).toMatch(/^BEGIN:VCALENDAR(.|\r\n)+END:VCALENDAR\r\n$/)
      expect(result).toMatch(/BEGIN:VEVENT(.|\r\n)+END:VEVENT/)

      expect(result).toMatch(/SUMMARY:testName/)
      expect(result).toMatch(/DTSTART:20130105T083000Z/)
      expect(result).toMatch(/DTEND:20130105T090000Z/)
      expect(result).toMatch(/DESCRIPTION:testDescription/)

    runs ->
      engine = new ICalendarEngine(parser, test)
      channelId = engine.createChannel()
      engine.closeChannel(channelId)
