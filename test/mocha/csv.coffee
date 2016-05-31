chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###
fs = require 'fs'
debug = require('debug') 'test:csv'
chalk = require 'chalk'
Table = require 'alinex-table'

formatter = require '../../src/index'

describe.only "CSV", ->

  file = __dirname + '/../data/format.csv'
  format = 'csv'
  example = fs.readFileSync file
  source = null
  data = [
    [ 'num', 'type', 'object' ]
    [ 1, 'null', null ]
    [ 2, 'undefined', null ]
    [ 3, 'boolean', 1 ]
    [ 4, 'number', 5.6 ]
    [ 5, 'text', "Hello" ]
    [ 6, 'quotes', "Give me a \"hand up\"" ]
    [ 7, 'date', 128182440000 ]
    [ 8, 'list', [1, 2, 3] ]
    [ 9, 'object', {name: 'Egon'} ]
    [ 10, 'complex', [{name: 'Valentina'}, {name: 'Nadine'}, {name: 'Sven'}] ]
  ]

  describe "parse preset file", ->

    it "should get object", (cb) ->
      formatter.parse example, format, (err, obj) ->
        source = obj
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
      source = data
      formatter.stringify source, format, (err, text) ->
        expect(err, 'error').to.not.exist
# used to create the example file
#        fs.writeFile __dirname + '/../data/format.csv', text
        debug "result", chalk.grey text
        expect(typeof text, 'type of result').to.equal 'string'
        formatter.parse text, format, (err, obj) ->
          expect(obj, 'reread object').to.deep.equal data
          cb()

  describe "table", ->

    it "should reread object", (cb) ->
      table = new Table data
      formatter.stringify table, format, (err, text) ->
        expect(err, 'error').to.not.exist
        debug "result", chalk.grey text
        expect(typeof text, 'type of result').to.equal 'string'
        formatter.parse text, format, (err, obj) ->
          expect(obj, 'reread object').to.deep.equal data
          cb()
