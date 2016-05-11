# Serializer for json syntax
# =================================================


# object -> string
# -------------------------------------------------
exports.format = (obj, options, cb) ->
  cb null, JSON.stringify obj, null, options?.indent ? 2


# string -> object
# -------------------------------------------------
exports.parse = (text, cb) ->
  try
    result = JSON.parse text
  catch error
    return cb error
  cb null, result
