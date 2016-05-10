# Serializer for js syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
ini = require 'ini'


# object -> string
# -------------------------------------------------
exports.format = (obj, options, cb) ->


# string -> object
# -------------------------------------------------
exports.parse = (text, cb) ->
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
