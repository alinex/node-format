# Utility functions for objects.
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
debug = require('debug') 'formatter'
chalk = require 'chalk'
async = require 'async'
path = require 'path'
util = require 'util'

# Setup
# -------------------------------------------------

autoDetect = [
  'xml'
  'ini'
  'properties'
  'cson'
  'coffee'
  'yaml'
  'json'
  'js'
]

# ### Extension to Parser
ext2parser =
  yml: 'yaml'
  yaml: 'yaml'
  js: 'js'
  javascript: 'javascript'
  json: 'json'
  cson: 'cson'
  coffee: 'cson'
  xml: 'xml'
  ini: 'ini'
  properties: 'properties'

# Format Object into String
# -------------------------------------------------
# __Arguments:__
#
# * `obj`
#   object to be formatted
# * `format`
#   formatter to use or filename to read format from
# * `options` (optional)
#   specific for the formatter
# * `cb`
#   callback will be called with (err, text)

exports.format = (obj, format, options, cb) ->
  debug "format object as #{format}"
  if typeof options is 'function'
    cb = options
    options = null
  # read format from filename extension
  if format?.match /\./
    ext = path.extname(format).substring 1
    format = ext2parser[ext] ? format
  # load library
  try
    lib = require "./type/#{format}"
  catch error
    return cb "Couldn't load #{format} library: #{error.message}"
  # format
  lib.format obj, options, cb


# Parse Object from String
# -------------------------------------------------
# Try to parse object from string. Auto detect if no format is given.
#
# __Arguments:__
#
# * `string`
#   text to be parsed
# * `format` (optional)
#   formatter to use or filename to read format from
# * `cb`
#   callback will be called with (err, object)
exports.parse = (text, format, cb) ->
  if typeof format is 'function'
    cb = format
    format = null
  debug "start parsing #{format ? 'unknown'} format"
  # get list of parsers to check
  detect = autoDetect[0..]
  if format?.match /\./
    ext = path.extname(format).substring 1
    if type = ext2parser[ext]
      i = detect.indexOf type
      detect.splice i, 1 if i > -1
      detect.unshift type
  else if format
    if i = detect.indexOf format
      detect.splice i, 1 if i > -1
      detect.unshift format
  # try to parse
  errors = []
  obj = null
  async.detectSeries detect, (format, cb) ->
    debug chalk.grey "try to parse as #{format}"
    # load library
    try
      lib = require "./type/#{format}"
    catch error
      return cb "Couldn't load #{format} library: #{error.message}"
    # run parser
    lib.parse text, (err, result) ->
      if err
        debug chalk.grey "#{format}: #{err.message}"
        errors.push err.message
        return cb()
      obj = result
      cb null, true
  , (err, result) ->
    return cb err if err
    if result and obj
      debug chalk.grey "result:\n#{util.inspect obj, {depth:null}}"
      return cb null, obj
    cb new Error "Could not parse from #{format ? 'unknown'}:\n#{errors.join '\n'}"
