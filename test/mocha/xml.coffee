chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###
fs = require 'fs'
debug = require('debug') 'test'
chalk = require 'chalk'

formatter = require '../../src/index'

describe "XML", ->

  file = __dirname + '/../data/format.xml'
  format = 'xml'
  example = fs.readFileSync file, 'UTF8'
  data =
    name: 'test'
    list: ['1', '2', '3']
    person:
      name: 'Alexander Schilling'
      job: 'Developer'
    cdata: 'i\'m not escaped: <xml>!'
    attributes:
      _: 'Hello all together'
      type: 'detail'
      sub: 'And specially you!'
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
      formatter.stringify data, format, (err, text) ->
        expect(err, 'error').to.not.exist
        expect(typeof text, 'type of result').to.equal 'string'
        debug "result", chalk.grey text
        formatter.parse text, format, (err, obj) ->
          expect(obj, 'reread object').to.deep.equal data
          cb()
