# Utility functions for objects.
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
debug = require('debug') 'formatter:json'
chalk = require 'chalk'
yaml = null # loaded on demand
vm = null # loaded on demand
coffee = null # loaded on demand
properties = null # loaded on demand
ini = null # loaded on demand
xml2js = null # loaded on demand


# object -> string
# -------------------------------------------------
exports.format = (obj, options, cb) ->
  # `indent` - (integer|string) to be used as indention for each level
  json: (obj, options, cb) ->
    cb null, JSON.stringify obj, null, options?.indent

  yaml: (obj, options, cb) ->
    cb()

formatter.js = formatter.json # same format possible


# Possible parsers
# -------------------------------------------------
exports.parse = (text, cb) ->
  js: (text, cb) ->
    vm ?= require 'vm'
    try
      result = vm.runInNewContext "x=#{text}"
    catch error
      return cb error
    cb null, result

  json: (text, cb) ->
    try
      result = JSON.parse text
    catch error
      return cb error
    cb null, result

  xml: (text, cb) ->
    xml2js ?= require 'xml2js'
    xml2js.parseString text, {explicitArray: false}, (err, result) ->
      if err
        return cb new Error err.message.replace /\n/g, ' '
      # optimize result of attributes
      cb null, xmlOptimize result

  ini: (text, cb) ->
    ini ?= require 'ini'
    try
      result = ini.decode text
    catch error
      return cb error
    # detect failed parsing
    if not result?
      return cb new Error "could not parse any result"
    if result['{']
      return cb new Error "Unexpected token { at start"
    for k, v of result
      if v is true and k.match /:/
        return cb new Error "Unexpected key name containing ':' with value true"
    cb null, result

  properties: (text, cb) ->
    properties ?= require 'properties'
    properties.parse text,
      sections: true
      namespaces: true
    , (err, result) ->
      return cb err if err
      unless propertiesCheck result
        return cb new Error "Unexpected characters []{}/ in key name found"
      cb null, result

  coffee: (text, cb) ->
    coffee ?= require 'coffee-script'
    try
      text = "module.exports =\n  " + text.replace /\n/g, '\n  '
      m = new module.constructor()
      m._compile coffee.compile(text), 'object.cson'
    catch error
      return cb error
    cb null, m.exports

  yaml: (text, cb) ->
    yaml ?= require 'js-yaml'
    try
      result = yaml.safeLoad text
    catch error
      error.message = error.message.replace 'JS-YAML: ', ''
      return cb new Error(
        error.message
        .replace 'JS-YAML: ', ''
        .replace /[\s^]+/g, ' '
      )
    cb null, result


# Helper methods
# -------------------------------------------------

# ### Optimize parsed cml
xmlOptimize = (data) ->
  return data unless typeof data is 'object'
  if Array.isArray data
    # seep analyze array
    result = []
    for v in data
      result.push xmlOptimize v
    return result
  result = {}
  for k, v of data
    # set value
    if k is '_'
      result.value = v
    # set attributes
    else if k is '$'
      for s, w of xmlOptimize v
        result[s] = w
    # keep other but check contents
    else
      result[k] = xmlOptimize v
  return result

# ### Check that the properties parser for correct result
propertiesCheck = (data) ->
  return true unless typeof data is 'object'
  for k, v of data
    if v is null or ~'[]{}/'.indexOf k.charAt 0
      return false
    return false unless propertiesCheck v
  return true
