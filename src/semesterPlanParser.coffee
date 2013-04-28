
###
  @author   Patrick Kromeyer
###

cheerio = require 'cheerio'
moment = require 'moment'

semesterPlanParser = (html) ->
  data = []

  $ = cheerio.load(html)

  url = $('[href^="javascript:void(printUrl"]').attr('href')
  matches = url.match(/date=(\d+)/)
  date = moment.unix(parseInt(matches[1])) # is 00:00:00 in local time

  $('[data-role=listview]').each((i, elem) ->
    $(elem).find('li:not(:first-child)').each((j, e) ->
      dateStart = date.clone()
      dateEnd = date.clone()

      matchTime = $(e).find('.cal-time').text().match(/^(\d{2}):(\d{2})-(\d{2}):(\d{2})$/)
      dateStart.hours(matchTime[1])
      dateStart.minutes(matchTime[2])
      dateEnd.hours(matchTime[3])
      dateEnd.minutes(matchTime[4])

      event = {
        'name'        : $(e).find('.cal-title').text()
        'dateStart'   : dateStart.toDate()
        'dateEnd'     : dateEnd.toDate()
        'description' : $(e).find('.cal-res').text()
      }

      data.push(event)
    )

    date.add('day', 1)
  )

  return data

module.exports = semesterPlanParser
