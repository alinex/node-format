chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###
fs = require 'fs'
debug = require('debug') 'test'
chalk = require 'chalk'

formatter = require '../../src/index'

describe "JavaScript", ->

  file = __dirname + '/../data/format.js'
  format = 'js'
  example = fs.readFileSync file, 'UTF8'
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
    calc: 900000
    math: 4

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
