
###
  @author   Patrick Kromeyer
###

http = require 'http'
url = require 'url'
moment = require 'moment'

ICalendarEngine = require './ICalendarEngine.js'
semesterPlanParser = require './semesterPlanParser.js'
isNumber = require './isNumber.js'
SimpleCache = require './SimpleCache.js'

cache = new SimpleCache()

http.createServer((req, res) ->
  parts = url.parse(req.url, true)

  validReq = isNumber(parts.query.gid) and isNumber(parts.query.uid)

  if not validReq
    res.writeHead(200, {'Content-Type': 'text/plain'})
    res.end('invalid parameter found!')
    return

  cacheKey = parts.query.gid.toString() + parts.query.uid.toString()
  if cache.hasItem(cacheKey)
    res.writeHead(200, {
      'Content-Type'      : 'text/calendar',
      'Content-Encoding'  : 'utf-8'
    })
    res.write(cache.getItem(cacheKey))
    res.end()
    return

  engine = new ICalendarEngine(semesterPlanParser, (result) ->
    cache.setItem(cacheKey, result, 60*60*60) # cache an hour

    res.writeHead(200, {
      'Content-Type'      : 'text/calendar',
      'Content-Encoding'  : 'utf-8'
    })
    res.write(result)
    res.end()
  )

  timestamp = moment().day(1).startOf('day').unix()
  weekInSeconds = 60*60*24*7
  limit = timestamp + (weekInSeconds * 12)

  while timestamp <= limit
    getUrl = url.format({
      'protocol'  : 'http',
      'hostname'  : 'vorlesungsplan.dhbw-mannheim.de',
      'pathname'  : 'index.php',
      'query'     : {
        'action'  : 'view',
        'gid'     : parts.query.gid,
        'uid'     : parts.query.uid,
        'date'    : timestamp
      }
    })

    (->
      channelId = engine.createChannel()

      http.get(getUrl, (subRes) ->
        subRes.on('data', (chunk) ->
                try
                  engine.appendToChannel(channelId, chunk)
                catch e
                  console.log(e)
              )
              .on('end', ->
                try
                  engine.closeChannel(channelId)
                catch e
                  console.log(e)
              )
              .on('close', ->
                try
                  engine.closeChannel(channelId)
                catch e
                  console.log(e)
              )
        ).on('error', ->
          try
            engine.rejectChannel(channelId)
          catch e
            console.log(e)
        )
    )()

    timestamp += weekInSeconds
).listen(process.env.PORT || 9000)
