chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###
fs = require 'fs'
debug = require('debug') 'test'
chalk = require 'chalk'

formatter = require '../../src/index'

describe "BSON", ->

  file = __dirname + '/../data/format.bson'
  format = 'bson'
  example = fs.readFileSync file
  data =
    null: null
    boolean: true
    string: 'test'
    number: 5.6
    date: "2016-05-10T19:06:36.909Z"
    list: [1, 2, 3]
    person:
      name: "Alexander Schilling"
      job: "Developer"
    complex: [
      {name: 'Egon'}
      {name: 'Janina'}
    ]

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
# used to create the example file
#        fs.writeFile __dirname + '/../data/format.bson', text
        expect(typeof text, 'type of result').to.equal 'object' # buffer
        debug "result", chalk.grey text
        formatter.parse text, format, (err, obj) ->
          expect(obj, 'reread object').to.deep.equal data
          cb()
