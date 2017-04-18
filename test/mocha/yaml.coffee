chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###
fs = require 'fs'
debug = require('debug') 'test'
chalk = require 'chalk'

formatter = require '../../src/index'

describe "YAML", ->

  file = __dirname + '/../data/format.yml'
  format = 'yaml'
  example = fs.readFileSync file, 'UTF8'
  data =
    null: null
    boolean: true
    string: 'test'
    unicode: 'Sosa did fine.☺'
    control: '\b1998\t1999\t2000\n'
    'hex esc': '\r\n is \r\n'
    single: '"Howdy!" he cried.'
    quoted: ' # Not a \'comment\'.'
    date: new Date '2016-05-10T19:06:36.909Z'
    numberInt: -8
    numberFloat: 5.6
    octal: '0o14'
    hexadecimal: 12
    exponential: 1230.15
    fixed: 1230.15
    'negative infinity': -Infinity
    'not a number': NaN
    list: ['one', 'two', 'three']
    list2: ['one', 'two', 'three']
    person: {name: 'Alexander Schilling', job: 'Developer'}
    complex: [{name: 'Egon'}, {name: 'Janina'}]
    multiline: 'This text will be read as one line without linebreaks.'
    multilineQuoted: 'This text will be read as one line without linebreaks.'
    lineBreaks: 'This text will keep\nas it is and all line\nbreaks will be kept.\n'
    lineSingle: 'This text will be read as one line without linebreaks.\n'
    lineBreak: 'The empty line\nwill be a line break.\n'
    address1: {city: 'Stuttgart'}
    address2: {city: 'Stuttgart'}
    numberString: '123'
    numberString2: '123'
    re: /\d+/
    picture: new Buffer 'R0lGODdhDQAIAIAAAAAAANnZ2SwAAAAADQAIAAACF4SDGQar3xxbJ9p0qa7R0YxwzaFME1IAADs=', 'base64'
    'Detroit Tigers,Chicago cubs': new Date '2001-07-23'

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
