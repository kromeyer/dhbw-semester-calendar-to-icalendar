
###
  @author   Patrick Kromeyer
###

isNumber = require '../src/isNumber.js'

describe 'isNumber', ->

  it 'should work with number', ->
    expect(isNumber(5.5)).toBeTruthy()

  it 'should work with string', ->
    expect(isNumber('5.5')).toBeTruthy()
    expect(isNumber('x')).toBeFalsy()

module.exports = isNumber
