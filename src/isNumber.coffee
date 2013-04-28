
###
  @author   Patrick Kromeyer
###

isNumber = (n) ->
  not isNaN(parseFloat(n) and isFinite(n))

module.exports = isNumber
