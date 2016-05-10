# Serializer for js syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
CSON = require 'cson-parser'


# object -> string
# -------------------------------------------------
exports.format = (obj, options, cb) ->
  # default settings
  options ?=
    indent: 2
  cb null, CSON.stringify obj, null, options?.indent


# string -> object
# -------------------------------------------------
exports.parse = (text, cb) ->
  try
    result = CSON.parse text
  catch error
    return cb error
  cb null, result
