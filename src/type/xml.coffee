# Serializer for xml syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
xml2js = require 'xml2js'


# object -> string
# -------------------------------------------------
exports.format = (obj, options, cb) ->
  builder = new xml2js.Builder()
  try
    text = builder.buildObject obj
  catch error
    return cb error
  cb null, text


# string -> object
#   -------------------------------------------------
exports.parse = (text, cb) ->
  xml2js.parseString text, {explicitArray: false}, (err, result) ->
    if err
      return cb new Error err.message.replace /\n/g, ' '
    # optimize result of attributes
    cb null, xmlOptimize result

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
