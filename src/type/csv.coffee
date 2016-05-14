# Serializer for ini syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
parser = null # load on demand
stringifyer = null # load on demand
#iconv = null # load on demand

# object -> string
# -------------------------------------------------
exports.stringify = (obj, options, cb) ->
  stringifyer ?= require 'csv-stringify'
#  iconv ?= require 'iconv-lite'
  stringifyer obj,
    columns: options?.columns
    delimiter: options?.delimiter ? ';'
    quote: options?.quote ? '"'
    escape: options?.escape ? '"'
    header: true
    quoted: options?.quoted ? false
    quotedEmpty: options?.quotedEmpty ? false
    quotedString: options?.quotedString ? false
  , cb
#        content: iconv.encode string, 'windows1252'

# string -> object
# -------------------------------------------------
exports.parse = (text, options, cb) ->
  parser ?= require 'csv-parse'
  parser text,
    delimiter: options?.delimiter ? ';'
    quote: options?.quote ? '"'
    escape: options?.escape ? '"'
    comment: options?.comment ? ''
    auto_parse: true
    auto_parse_date: true
  , (err, obj) ->
    return cb err if err
    # optimize objects from json
    cb null, obj.map (line) ->
      line.map (field) ->
        return field unless typeof field is 'string' and field[0] in ['[', '{']
        try
          result = JSON.parse field
        catch
          return field
        result
