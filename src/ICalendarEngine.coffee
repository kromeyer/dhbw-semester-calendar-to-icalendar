
###
  @author   Patrick Kromeyer
###

icalendar = require 'icalendar'

Engine = require './Engine.js'

class ICalendarEngine extends Engine

  constructor: (parser, callback) ->
    super(callback)
    @_parser = parser

  _handle: ->
    return unless @_isReady()

    ical = new icalendar.iCalendar()

    for channelId of @_channelContent
      events = @_parser(@_channelContent[channelId])

      for event in events
        eventObject = new icalendar.VEvent(event.dateStart.toJSON())
        eventObject.setSummary(event.name)
        eventObject.setDate(event.dateStart, event.dateEnd)
        eventObject.setDescription(event.description)
        ical.addComponent(eventObject)

    @_callback(ical.toString())

module.exports = ICalendarEngine
