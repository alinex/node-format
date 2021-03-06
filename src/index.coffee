# Utility functions for objects.
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
debug = require('debug') 'format'
chalk = require 'chalk'
async = require 'async'
path = require 'path'
util = require 'util'


# Setup
# -------------------------------------------------
autoDetect = [
  'bson'
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
  csv: 'csv'
  yml: 'yaml'
  yaml: 'yaml'
  js: 'js'
  javascript: 'javascript'
  json: 'json'
  bson: 'bson'
  cson: 'cson'
  coffee: 'coffee'
  xml: 'xml'
  ini: 'ini'
  properties: 'properties'


# Format Object into String
#
# @param {Object} obj to be formatted
# @param {String} format to use or filename to read format from
# @param {Object} [options] specific for the format
# @param {Function(Error, String)} cb callback will be called with result
exports.stringify = (obj, format, options, cb) ->
  debug "format object as #{format}" if debug.enabled
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
  lib.stringify obj, options, (err, text) ->
    debug chalk.grey "result:\n#{text}" if debug.enabled
    cb err, text

# Parse Object from String
#
# Try to parse object from string. Auto detect if no format is given.
#
# @param {String} text to be parsed
# @param {String} format to use or filename to read format from
# @param {Object} [options] specific for the format
# @param {Function(Error, Object)} cb callback will be called with result
exports.parse = (text, format, options, cb) ->
  if typeof format is 'function'
    cb = format
    format = null
  if typeof options is 'function'
    cb = options
    options = null
  debug "start parsing #{format ? 'unknown'} format" if debug.enabled
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
    debug chalk.grey "try to parse as #{format}" if debug.enabled
    # load library
    try
      lib = require "./type/#{format}"
    catch error
      return cb "Couldn't load #{format} library: #{error.message}"
    # run parser
    lib.parse text, options, (err, result) ->
      if err
        debug chalk.grey "#{format}: #{err.message}" if debug.enabled
        errors.push err.message
        return cb()
      obj = result
      cb null, true
  , (err, result) ->
    return cb err if err
    if result and obj
      debug chalk.grey "result:\n#{util.inspect obj, {depth: null}}" if debug.enabled
      return cb null, obj
    cb new Error "Could not parse from #{format ? 'unknown'}:\n#{errors.join '\n'}"
