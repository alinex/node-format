chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###
fs = require 'fs'
debug = require('debug') 'test'
chalk = require 'chalk'

formatter = require '../../src/index'

describe.only "JSON", ->

  file = __dirname + '/../data/format.json'
  example = fs.readFileSync file, 'UTF8'
  data =
    null: null
    boolean: true
    string: 'test'
    number: 5.6
    list: [1, 2, 3]
    person:
      name: "Alexander Schilling"
      job: "Developer"

  describe "parse preset file", ->

    it "should get object", (cb) ->
      formatter.parse example, 'json', (err, obj) ->
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
      formatter.format data, 'json', (err, text) ->
        expect(err, 'error').to.not.exist
        expect(typeof text, 'type of result').to.equal 'string'
        debug "result", chalk.grey text
        formatter.parse text, 'json', (err, obj) ->
          expect(obj, 'reread object').to.deep.equal data
          cb()

    it "should format with indent", (cb) ->
      formatter.format data, 'json',
        indent: 0
      , (err, text) ->
        expect(err, 'error').to.not.exist
        expect(typeof text, 'type of result').to.equal 'string'
        debug "result", chalk.grey text
        formatter.parse text, 'json', (err, obj) ->
          expect(obj, 'reread object').to.deep.equal data
          cb()
