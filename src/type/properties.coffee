# Serializer for properties syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
properties = require 'properties'


# object -> string
# -------------------------------------------------
exports.stringify = (obj, options, cb) ->
  try
    text = properties.stringify flatten(obj),
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
    cb null, optimizeArray result


# Helper
# -------------------------------------------------
propertiesCheck = (data) ->
  return true unless typeof data is 'object'
  for k, v of data
    if v is null or ~'[]{}/'.indexOf k.charAt 0
      return false
    return false unless propertiesCheck v
  return true

flatten = (obj) ->
  return obj unless typeof obj is 'object'
  flat = {}
  # recursive flatten
  for key, value of obj
    unless typeof value is 'object'
      flat[key] = value
    else
      for k, v of flatten value
        flat["#{key}.#{k}"] = v
  return flat

optimizeArray = (obj) ->
  return obj unless typeof obj is 'object'
  # resursive work further
  for key, value of obj
    obj[key] = optimizeArray value
  # replace with array if possible
  keys = Object.keys obj
  keys.sort()
  if keys.join(',') is [0..keys.length-1].join(',')
    list = []
    list.push obj[k] for k in keys
    obj = list
  obj
