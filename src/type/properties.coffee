# Serializer for properties syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
properties = require 'properties'


# object -> string
# -------------------------------------------------
exports.format = (obj, options, cb) ->
  try
    text = properties.stringify obj,
      unicode: true
  catch error
    return cb error if error
  cb null, text


# string -> object
# -------------------------------------------------
exports.parse = (text, cb) ->
  properties.parse text,
    sections: true
    namespaces: true
    variables: true
  , (err, result) ->
    return cb err if err
    unless propertiesCheck result
      return cb new Error "Unexpected characters []{}/ in key name found"
    cb null, result

propertiesCheck = (data) ->
  return true unless typeof data is 'object'
  for k, v of data
    if v is null or ~'[]{}/'.indexOf k.charAt 0
      return false
    return false unless propertiesCheck v
  return true
