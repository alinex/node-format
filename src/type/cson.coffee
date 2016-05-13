# Serializer for cson syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
CSON = require 'cson-parser'


# object -> string
# -------------------------------------------------
exports.stringify = (obj, options, cb) ->
  cb null, CSON.stringify obj, null, options?.indent ? 2


# string -> object
# -------------------------------------------------
exports.parse = (text, _, cb) ->
  try
    result = CSON.parse text
  catch error
    return cb error
  cb null, result
