chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###
fs = require 'fs'
debug = require('debug') 'test'
chalk = require 'chalk'

formatter = require '../../src/index'

describe "Object Format", ->

  describe.only "json", ->

    file = __dirname + '/../data/format.json'
    example = fs.readFileSync file, 'UTF8'
    data = null

    it "should parse", (cb) ->
      formatter.parse example, 'json', (err, obj) ->
        data = obj
        expect(err, 'error').to.not.exist
        expect(obj, 'object').to.deep.equal
          string: 'test'
          list: [1, 2, 3]
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()

    it "should parse (auto)", (cb) ->
      formatter.parse example, (err, obj) ->
        expect(err, 'error').to.not.exist
        expect(obj, 'object').to.deep.equal
          string: 'test'
          list: [1, 2, 3]
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()

    it "should parse (auto by content)", (cb) ->
      formatter.parse example, file, (err, obj) ->
        expect(err, 'error').to.not.exist
        expect(obj, 'object').to.deep.equal
          string: 'test'
          list: [1, 2, 3]
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()

    it "should format", (cb) ->
      formatter.format data, 'json', (err, text) ->
        expect(err, 'error').to.not.exist
        expect(typeof text, 'type of result').to.equal 'string'
        debug "result", chalk.grey text
        formatter.parse text, 'json', (err, obj) ->
          expect(obj, 'reread object').to.deep.equal data
          cb()

    it "should format with indent", (cb) ->
      formatter.format data, 'json',
        indent: 2
      , (err, text) ->
        expect(err, 'error').to.not.exist
        expect(typeof text, 'type of result').to.equal 'string'
        debug "result", chalk.grey text
        formatter.parse text, 'json', (err, obj) ->
          expect(obj, 'reread object').to.deep.equal data
          cb()




  describe "yaml", ->

    it "should parse", (cb) ->
      parse text, 'yaml', (err, obj) ->
        expect(err, 'error').to.not.exist
        expect(obj, 'yaml root').to.deep.equal
          string: 'test'
          longtext: 'And a long text with \' and " is possible, too'
          multiline: 'This may be a very long line in which newlines will be removed.\n'
          keepnewlines: 'Line 1\nLine 2\nLine 3\n'
          simplelist: [1, 2, 3]
          list: ['red', 'green', 'blue']
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()

    it "should parse (auto)", (cb) ->
      init 'format.yml', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.format
        expect(d.yaml, 'yaml root').to.deep.equal
          string: 'test'
          longtext: 'And a long text with \' and " is possible, too'
          multiline: 'This may be a very long line in which newlines will be removed.\n'
          keepnewlines: 'Line 1\nLine 2\nLine 3\n'
          simplelist: [1, 2, 3]
          list: [ 'red', 'green', 'blue' ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()

    it "should parse (auto by content)", (cb) ->
      init 'link.yml', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.link
        expect(d.yaml, 'yaml root').to.deep.equal
          string: 'test'
          longtext: 'And a long text with \' and " is possible, too'
          multiline: 'This may be a very long line in which newlines will be removed.\n'
          keepnewlines: 'Line 1\nLine 2\nLine 3\n'
          simplelist: [1, 2, 3]
          list: [ 'red', 'green', 'blue' ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()

  describe "js", ->

    it "should parse", (cb) ->
      init 'format.js', 'js', (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.format
        expect(d.javascript, 'js root').to.deep.equal
          string: 'test'
          list: [ 1, 2, 3 ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
          session: 15*60*1000
          calc: Math.sqrt(16)
        cb()

    it "should parse (auto)", (cb) ->
      init 'format.js', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.format
        expect(d.javascript, 'js root').to.deep.equal
          string: 'test'
          list: [ 1, 2, 3 ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
          session: 15*60*1000
          calc: Math.sqrt(16)
        cb()

    it "should parse (auto by content)", (cb) ->
      init 'link.js', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.link
        expect(d.javascript, 'js root').to.deep.equal
          string: 'test'
          list: [ 1, 2, 3 ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
          session: 15*60*1000
          calc: Math.sqrt(16)
        cb()

  describe "cson", ->

    it "should parse", (cb) ->
      init 'format.cson', 'coffee', (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.format
        expect(d.coffee, 'cson root').to.deep.equal
          string: 'test'
          list: [ 1, 2, 3 ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
          session: 15*60*1000
          calc: Math.sqrt(16)
        cb()

    it "should parse (auto)", (cb) ->
      init 'format.cson', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.format
        expect(d.coffee, 'cson root').to.deep.equal
          string: 'test'
          list: [ 1, 2, 3 ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
          session: 15*60*1000
          calc: Math.sqrt(16)
        cb()

    it "should parse (auto by content)", (cb) ->
      init 'link.cson', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.link
        expect(d.coffee, 'cson root').to.deep.equal
          string: 'test'
          list: [ 1, 2, 3 ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
          session: 15*60*1000
          calc: Math.sqrt(16)
        cb()

  describe "xml", ->

    it "should parse", (cb) ->
      init 'format.xml', 'xml', (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.format
        expect(d.xml, 'xml root').to.deep.equal
          name: 'test',
          list: [ '1', '2', '3' ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
          cdata: 'i\\\'m not escaped: <xml>!'
          attributes: {value: '\n    Hello all together\n  ', type: 'detail'}
        cb()

    it "should parse (auto)", (cb) ->
      init 'format.xml', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.format
        expect(d.xml, 'xml root').to.deep.equal
          name: 'test',
          list: [ '1', '2', '3' ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
          cdata: 'i\\\'m not escaped: <xml>!'
          attributes: {value: '\n    Hello all together\n  ', type: 'detail'}
        cb()

    it "should parse (auto by content)", (cb) ->
      init 'link.xml', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.link
        expect(d.xml, 'xml root').to.deep.equal
          name: 'test',
          list: [ '1', '2', '3' ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
          cdata: 'i\\\'m not escaped: <xml>!'
          attributes: {value: '\n    Hello all together\n  ', type: 'detail'}
        cb()

  describe "ini", ->

    it "should parse", (cb) ->
      init 'format.ini', 'ini', (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.format
        expect(d.ini, 'ini root').to.deep.equal
          string: 'test',
          list: [ '1', '2', '3' ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()

    it "should parse (auto)", (cb) ->
      init 'format.ini', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.format
        expect(d.ini, 'ini root').to.deep.equal
          string: 'test',
          list: [ '1', '2', '3' ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()

    it "should parse (auto by content)", (cb) ->
      init 'link.ini', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.link
        expect(d.ini, 'ini root').to.deep.equal
          string: 'test',
          list: [ '1', '2', '3' ]
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()

  describe "properties", ->

    it "should parse", (cb) ->
      init 'format.properties', 'properties', (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.format
        expect(d.prop, 'properties root').to.deep.equal
          string: 'test',
          list: {1: 1, 2: 2, 3: 3}
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()

    it "should parse (auto)", (cb) ->
      init 'format.properties', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.format
        expect(d.prop, 'properties root').to.deep.equal
          string: 'test',
          list: {1: 1, 2: 2, 3: 3}
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()

    it "should parse (auto by content)", (cb) ->
      init 'link.properties', null, (err) ->
        expect(err, 'error').to.not.exist
        d = config.value.link
        expect(d.prop, 'properties root').to.deep.equal
          string: 'test',
          list: {1: 1, 2: 2, 3: 3}
          person: {name: 'Alexander Schilling', job: 'Developer'}
        cb()
