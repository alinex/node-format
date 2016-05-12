chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###
fs = require 'fs'
debug = require('debug') 'test'
chalk = require 'chalk'

formatter = require '../../src/index'

describe "INI", ->

  file = __dirname + '/../data/format.properties'
  format = 'properties'
  example = fs.readFileSync file, 'UTF8'
  data =
    string: 'test'
    other: 'text'
    multiline: 'This text goes over multiple lines.'
    integer: 15
    float: -4.6
    list:
      '1': 'one'
      '2': 'two'
      '3': 'three'
    person:
      name: 'Alexander Schilling'
      job: 'Developer'
    ref: 'test'
    section:
      name: 'Alex'
      same: 'Alex'

  describe "parse preset file", ->

    it "should get object", (cb) ->
      formatter.parse example, format, (err, obj) ->
        expect(err, 'error').to.not.exist
        expect(obj, 'object').to.deep.equal data
        cb()

    it "should work with autodetect", (cb) ->
      formatter.parse example, (err, obj) ->
        expect(err, 'error').to.not.exist
        expect(obj, 'object').to.deep.equal data
        cb()

    it "should work with filename", (cb) ->
      formatter.parse example, file, (err, obj) ->
        expect(err, 'error').to.not.exist
        expect(obj, 'object').to.deep.equal data
        cb()

  describe "format and parse", ->

    it "should reread object", (cb) ->
      formatter.format data, format, (err, text) ->
        expect(err, 'error').to.not.exist
        expect(typeof text, 'type of result').to.equal 'string'
        debug "result", chalk.grey text
        formatter.parse text, format, (err, obj) ->
          expect(obj, 'reread object').to.deep.equal data
          cb()
