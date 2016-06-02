# Serializer for xml syntax
# =================================================


# Node Modules
# -------------------------------------------------

# include base modules
xml2js = require 'xml2js'


# object -> string
# -------------------------------------------------
exports.stringify = (obj, options, cb) ->
  builder = new xml2js.Builder()
  try
    text = builder.buildObject obj,
#      charkey: 'value'
      rootName: options?.root ? 'xml'
      cdata: true
  catch error
    return cb error
  cb null, text


# string -> object
#   -------------------------------------------------
exports.parse = (text, options, cb) ->
  xml2js.parseString text,
    explicitRoot: options?.explicitRoot ? false
    explicitArray: false
    trim: true
    emptyTag: null
    ignoreAttrs: options?.ignoreAttrs
    mergeAttrs: true
#    charkey: 'value'
  , (err, result) ->
    if err
      return cb new Error err.message.replace /\n/g, ' '
    # optimize result of attributes
    cb null, result
