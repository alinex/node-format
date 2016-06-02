chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###
fs = require 'fs'
debug = require('debug') 'test'
chalk = require 'chalk'

formatter = require '../../src/index'

describe "Core", ->

  file = __dirname + '/../data/format.json'
  format = 'json'
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

  it "should fail parse on unsupported type", (cb) ->
    formatter.parse example, 'jpg', (err) ->
      expect(err, 'error').to.exist
      cb()

  it "should parse on unsupported type", (cb) ->
    formatter.parse example, 'test.jpg', (err, obj) ->
      expect(err, 'error').to.not.exist
      expect(obj, 'object').to.deep.equal data
      cb()

  it "should fail stringify on unsupported type", (cb) ->
    formatter.stringify example, 'jpg', (err) ->
      expect(err, 'error').to.exist
      cb()

  it "should fail parse on defect content", (cb) ->
    formatter.parse '{', 'xml', (err) ->
      expect(err, 'error').to.exist
      cb()
