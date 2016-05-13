# Serializer for json syntax
# =================================================


# object -> string
# -------------------------------------------------
exports.stringify = (obj, options, cb) ->
  cb null, JSON.stringify obj, null, options?.indent ? 2


# string -> object
# -------------------------------------------------
exports.parse = (text, _, cb) ->
  try
    result = JSON.parse text
  catch error
    return cb error
  cb null, result
